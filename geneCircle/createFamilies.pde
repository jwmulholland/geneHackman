///////////////Method to get data from Family data and create f=Family objects in the 'families' array
void createFamilies()
{
  int count = 0;
  for(int i = 0; i < records.length; i++) // scan through lines of data file
  {
    if (records[i].charAt(0) == ('0') && records[i].charAt(2) == '@') // if a new record is found (indicated by "0 @")
    {
      //////FAMILIES//////
      if (records[i].charAt(records[i].length()-1) == 'M') // if the record is for an family, the line ends in FAM
      {
        String newID = "_";
        String newUID = "_";
        String newHUSB = "_";
        String newWIFE = "_";
        String newDOM = "_";
        String newPOM = "_";

        //println("new family record at " + i); //print note of new records location
        //Record the ID
        newID = records[i].substring(3);
        newID = newID.replace("@ FAM","");
        Family newFamily = new Family();
        families.add(newFamily);
        //println("(" + newID + ")");
        newFamily.ID = newID;

        //check for hash.
        if (familyHash.containsKey(newID) == false)
        {
          familyHash.put(newID, newFamily);
        }
        //        families.add(new Family(newID, newUID, newHUSB, newWIFE, newDOM, newPOM)); //create new person with properties defined by above parsing

        if (familyHash.containsKey(newID) == true)
        {


          //Get information to create new family
          for (int x = 1 ; x < 7; x++) 
          {
            int rowNum = x+i;

            if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == '_') // if UID is found (indicated by "1 _", short for 1 _UID)
            {
              newUID = records[rowNum].substring(7); //Parse UID
            }
            else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'H') // if husband info is found (indicated by "1 H", short for 1 HUSB)
            {
              newHUSB = records[rowNum].substring(7); //Parse HUSB
              newHUSB = newHUSB.replace("@",""); //remove "@"
            }
            else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'W') // if wife info is found (indicated by "1 W", short for 1 WIFE)
            {
              newWIFE = records[rowNum].substring(7); //Parse WIFE
              newWIFE = newWIFE.replace("@",""); //remove "@"
            }
            else if (records[rowNum].charAt(0) == ('1') && records[rowNum].charAt(2) == 'M') // if marriage info is found (indicated by "1 M", short for 1 MARR)
            {
              for (int y = 1 ; y < 3 ; y++ )
              {
                rowNum += y;
                if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'D') // if date of marriage info is found (indicated by "2 D", short for 2 DATE)
                {
                  newDOM = records[rowNum].substring(7); //Parse DOM
                }
                else if (records[rowNum].charAt(0) == ('2') && records[rowNum].charAt(2) == 'P') // if place of marriage info is found (indicated by "2 P", short for 2 PLACE)
                {
                  newPOM = records[rowNum].substring(7); //Parse POM
                }
              }
            }
            //if new record found, STOP and CONTINUE ON
            else if (records[rowNum].charAt(0) == ('0'))
            {
              break;
            }
          }
        }
        //println(newID + " " + newUID + " (" + newHUSB + ", " + newWIFE + ") " + newDOM + ", " + newPOM); //print out new record
        totalFamilies += 1;
      }
      count += 1; //advance record
    }
  }

  //println(records.length + " lines of data");
  //println(totalFamilies + " total family records");

} //end createFamilies
