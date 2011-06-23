void createIndividuals()
{
  int count = 0;
  for(int i = 0; i < records.length; i++) // scan through lines of data file
  {
    //////////////
    /////CREATE A NEW RECORD
    //////////////
    if (records[i].charAt(0) == ('0') && records[i].charAt(2) == '@') // if a new record is found (indicated by "0 @")
    {
      String newID; //newID variable starts with value of char after first @
      String newName;
      String newSurname;
      String newGiven;
      char newSex;
      String newDOB;
      String newPOB;
      String newDOD;
      String newPOD;
      String newUID;
      String newFAMS;
      String newFAMC;

      //////INDIVIDUALS//////
      if (records[i].charAt(records[i].length()-1) == 'I') // if the record is for an individual "the line ends in I"
      { 
        //println("new person record at " + i); //print note of new records location
        //Record the ID
        newID = records[i].substring(3);
        newID = newID.replace("@ INDI","");
        Person newPerson = new Person(newID);
        people.add(newPerson);

        //Get information to create new individual
        for (int x = 1 ; x < 50 ; x++)
        {
          int rowNum = x+i; // row number relative to the start of new record

          if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'N' && records[rowNum].charAt(3) == 'A') // if a NAME record is found (indicated by "1 N", short for 1 NAME)
          {
            newName = records[rowNum].substring(7); //Parse Full Name
            newName = newName.replace("/",""); //remove "/" separators
            newPerson.NAME = newName;
          } 
          else if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'S') // if a surname is found (indicated by "2 S", short for 2 SURN)
          { 
            newSurname = records[rowNum].substring(7); //Parse Surname
            newPerson.SURN = newSurname;
          } 
          else if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'G') // if a given name is found (indicated by "2 G", short for 2 GIVN)
          { 
            newGiven = records[rowNum].substring(7); //Parse Given Name
            newPerson.GIVN = newGiven;
          } 
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'S') // if a gender is found (indicated by "1 S", short for 1 SEX)
          { 
            newSex = records[rowNum].charAt(6); //Parse Sex
            newPerson.SEX = newSex;
          } 
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'B') // if birth info is found (indicated by "1 B", short for 1 BIRT)
          { 
            
            
            for (int y = 1 ; y < 3 ; y++ )
            {
              rowNum += y;
              if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'D') //if birthdate info is found (indicated by "2 D", short for 2 DATE)
              {
                  newDOB = records[rowNum].substring(records[rowNum].length() - 4); //Parse DOB

                // thanks to the following site for this bit of try/catch code - http://www.devdaily.com/java/edu/qanda/pjqa00010.shtml
                try
                {
                  // the String to int conversion happens here
                  if (newPerson.DOB == 0) {
                    newPerson.DOB = Integer.parseInt(newDOB.trim());
                  }
                  // print out the value after the conversion
                  //println("int newPerson.DOB = " + newPerson.DOB);
                }
                catch (NumberFormatException nfe)
                {
                  //println("NumberFormatException: " + nfe.getMessage());
                }
              } 
              else if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'P') //if birthplace info is found (indicated by "2 P", short for 2 PLAC)
              {
                newPOB = records[rowNum].substring(7); //Parse POB
                newPerson.POB = newPOB;
              }
              if (records[rowNum].charAt(0) == ('1')) {
                break;
              }
            }
          } 
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'D') // if death info is found (indicated by "1 B", short for 1 DEAT)
          { 
            for (int y = 1 ; y < 3 ; y++ )
            {
              rowNum += y;
              if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'D') //if deathdate info is found (indicated by "2 D", short for 2 DATE)
              {
                newDOD = records[rowNum].substring(records[rowNum].length() - 4); //Parse DOD

                // thanks to the following site for this bit of try/catch code - http://www.devdaily.com/java/edu/qanda/pjqa00010.shtml
                try
                {
                  // the String to int conversion happens here
                  newPerson.DOD = Integer.parseInt(newDOD.trim());

                  // print out the value after the conversion
                  //println("int newPerson.DOD = " + newPerson.DOD);
                }
                catch (NumberFormatException nfe)
                {
                  //println("NumberFormatException: " + nfe.getMessage());
                }
              }
              else if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'P') //if deathplace info is found (indicated by "2 P", short for 2 PLAC)
              {
                newPOD = records[rowNum].substring(7); //Parse POB
              }
            }
          } //end else if death info is found
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == '_') // if UID is found (indicated by "1 _", short for 1 _UID)
          {
            newUID = records[rowNum].substring(7); //Parse UID
          } 
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'F' && records[rowNum].charAt(5) == 'S') // if FAMS# is found (indicated by "1 F--S", short for 1 FAMS)
          {
            newFAMS = records[rowNum].substring(8); //Parse FAMS
            newFAMS = newFAMS.replace("@",""); //remove "@"
            newPerson.FAMS.add(newFAMS);

            //check if family exists in map
            //if yes, get family
            //add to F...
            //if no, create family
            //add to family

            ////////////

            Family sFamily = (Family) familyHash.get(newFAMS);
            //            println(newFAMS + ": is null " + (sFamily == null)); //COmment in to debug if Family exists

            if (familyHash.containsKey(newFAMS) == false)
            {
              familyHash.put(newFAMS, sFamily);
            }

            if (newFAMS != null && newPerson.SEX == 'M') //Determine if male sire
            {
              sFamily.father = newPerson;
            }
            else if (newFAMS != null && newPerson.SEX == 'F') //Determine if female sire
            { 
              sFamily.mother = newPerson;
            }
            if (sFamily.children.isEmpty() == false)
            {
              //println(newPerson.NAME + " (born " + newPerson.DOB + ") is the parent of " +  sFamily.children.get(0).NAME ) ;
            }  
            ////////////
          } 
          else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'F' && records[rowNum].charAt(5) == 'C') // if FAMC# is found (indicated by "1 F--C", short for 1 FAMC)
          {
            newFAMC = records[rowNum].substring(8); //Parse FAMC
            newFAMC = newFAMC.replace("@",""); //remove "@"
            newPerson.FAMC = newFAMC;

            ////////////
            if (newFAMC != null) //Determine if child
            {
              if (familyHash.containsKey(newFAMC) == false)
              {
                familyHash.put(newFAMC, new Family());
              }

              Family cFamily = (Family) familyHash.get(newFAMC);
              cFamily.children.add(newPerson); //add children to array list

              //              if (cFamily.father.isEmpty() == false)
              //              {
              //                println(newPerson.NAME + " is the child of " +  sFamily.father.get(0).NAME ) ;
              //              }
            }
          }

          //if new record found, STOP and CONTINUE ON
          if (records[rowNum].charAt(0) == ('0'))
          {
            break;
          }
        }
        totalPeople += 1;
      }
      count += 1; //advance record
    }
  }
  //println(records.length + " lines of data");
  //println(totalPeople + " total people records");
}

