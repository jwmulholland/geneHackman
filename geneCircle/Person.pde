class Person
{
  String ID; // unique ID for entry
  String NAME; // full name string of person
  String SURN; // surname of person
  String GIVN; // given name of person
  char SEX; // sex of person (M or F) 
  String BIRT; // birthdate of person
  int DOB; // date of birth
  String POB; // place of birth
  int DOD; // date of death
  String POD; //place of death
  String UID; // universal ID
  ArrayList<String> FAMS = new ArrayList(); //list of families sired (usually only one)
  ArrayList<Person> children = new ArrayList();
  String FAMC; //child of which family

  Person Mom; // person stored as Mom via hashmap for Family class
  Person Dad; // person stored as Dad via hashmap for Family class
  float x = 0;
  float y = 0;
  boolean isDrawn = false;
  int GEN = 1;
  float theta = 0; //angle 
  
  boolean selected = false;
  boolean hover = false;
  boolean dobEstimated = false;


  //simple constructor//
  Person (  String iID  )
  {
    ID = iID;
    isDrawn = false;
  }

  //empty constructor//
  Person ()
  {
  } 


//  void drawPerson(float xPos, float yPos)
//  {
//    noStroke();
//    rectMode(CENTER);
//    ellipseMode(CENTER);
//    
//
//    if (hover == true) {
//      strokeWeight(1);
//      stroke(0);
//      fill(0,50,50,90);
//      rectMode(CENTER);
//      rect(x, y, personSize, personSize);
//      fill(255);
//      textAlign(LEFT);
//      textSize(10);
//      String newText = NAME + " " + DOB + " x" + x + " y" + y;
//      text(newText,xPos+10, yPos+(textAscent()/2));
//    }
//    
//    else {
//     fill(200); 
//    }
//    
//    ellipse(xPos, yPos, personSize, personSize);
//  }
  
} //End class

