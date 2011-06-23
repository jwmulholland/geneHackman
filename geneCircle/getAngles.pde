void getAngles(Person main, float angle) {

  String FAMSID = "F";
  String FAMCID = main.FAMC;

  main.theta = angle;
  println(angle);


  int genDensity = genArray[main.GEN];


  float factor  = 2.0; //max(0.1, mouseX / 100.0);
  float overall = 180; //+ map(main.DOB, 1000,2000,  90,0);;
  //map(genDensity,1, 1000, 10,1); //map(main.DOB, 1000,2000,  20,1); //log(1 + main.GEN);
//  float fatherAngle = angle + main.GEN/3*overall/pow(factor, main.GEN-2);
//  float motherAngle = angle - main.GEN/3*overall/pow(factor, main.GEN-2);
  float fatherAngle = angle + overall/pow(factor, main.GEN);
  float motherAngle = angle - overall/pow(factor, main.GEN);


  //overall*log(main.GEN);
  //overall*log(main.GEN);

//  if ()
//  {
//   float fatherAngle = angle + overall/genDensity ;
//   float motherAngle = angle - overall/genDensity ;
//  } else {
//    
//  }


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
      getAngles(cFamily.father, fatherAngle);//draw father
    }

    if (cFamily.mother != null) //if person has mother
    { 
      getAngles(cFamily.mother, motherAngle);//draw mother
    }
  }

  //sibAngle
  //  cleanUp(siblings, sibAngle, main.GEN):
  //  if has sibling and gen is not null or 0, take GEN
  //  
  //  if has parent and gen is not null or 0, take GEN - 1
}

