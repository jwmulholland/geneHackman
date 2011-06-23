void cleanUpDOB(Person q, int birth) {

  //////////////////
  ///CLEAN UP DOB///
  //////////////////
  
  if (q.DOB == 0) {
    q.DOB = birth;
  }
  
  int yearBuffer = 30;

  String FAMSID = "F";
  String FAMCID = q.FAMC;

  Family cFamily = (Family) familyHash.get(FAMCID); //get family for child-of
//  Family sFamily = (Family) familyHash.get(FAMSID); //get family for sire-of

//  if (sFamily == null && cFamily == null) {
//    people.remove(q);
//  }

  cFamily = (Family) familyHash.get(q.FAMC); //get family for child-of
  if (cFamily != null && cFamily.children.size() > 0)
  { 
    if (cFamily.father != null) //if person has father
    {
      cleanUpDOB(cFamily.father, q.DOB - yearBuffer);
    }
    if (cFamily.mother != null) //if person has mother
    { 
      cleanUpDOB(cFamily.mother, q.DOB - yearBuffer);
    }
  }


//  else if (main.DOB == 0) //if no DOB data
//  {
//    println("Trying to find DOB");
//    if (main.DOB == 0 && sFamily != null) //if STILL 0 -&- is parent
//    {
//      if (sFamily.mother.DOB > 0 && sFamily.mother.dobEstimated != true) {// if person has wife
//        main.DOB = sFamily.mother.DOB;
//      }
//      if (sFamily.father.DOB > 0 && sFamily.father.dobEstimated != true) { // if person has wife
//        main.DOB = sFamily.father.DOB;
//      }
//      if (sFamily.children.size() > 0) // if person has children
//      {  
//        for (int c = 0 ; c < sFamily.children.size() ; c++) //go through children
//        {
//          if (sFamily.children.get(c).DOB > 0) //if child's age is OK
//          {
//            main.DOB = sFamily.children.get(c).DOB - yearBuffer; //take child's DOB and subtract 30 to get est. year
//          }
//        }
//      }
//    }
//  }

}

