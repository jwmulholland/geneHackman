void createGen(Person main, int iGEN) {
  
  main.GEN = iGEN;
  String FAMSID = "F";
  String FAMCID = main.FAMC;
  
  if (main.FAMS.size() > 0) { //if family has sire 
    FAMSID = main.FAMS.get(0); //get First FAMS
  }
  ///////IF PERSON IS A CHILD (has FAMC) - find siblings, find parents and draw recursively
  Family cFamily = (Family) familyHash.get(FAMCID); //get family for child-of
  if (cFamily != null && cFamily.children.size() > 0)
  { 
    ////draw parents
    if (cFamily.father != null) //if person has father
    {
      createGen(cFamily.father, main.GEN+1);//draw father
    }

    if (cFamily.mother != null) //if person has mother
    { 
      createGen(cFamily.mother, main.GEN+1);//draw mother
    }
    
  }
  
}
