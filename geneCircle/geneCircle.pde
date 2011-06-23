//// geneHackman (no relation)
//// by James Mulholland
//// for Interactive Art and Computational Design, Spring 2011 with Golan Levin
//// Studio for Creative Inquiry, Carnegie Mellon University
/*
*/

import java.util.*;
import controlP5.*;
import fullscreen.*;
import japplemenubar.*;

//initialize!//
PFont yearFont;
int yearSize = 12;
boolean rightAlign = true;
float scaleNum = 250;
float targetScaleNum = 250;
float personSize = 25;

//color prefs
//color backFill = 60;
color backFill = #5A5050;
color circleStroke = 120;
color peopleFill = 255;

//data variables
String[] records;
ArrayList<Person> people = new ArrayList<Person>(); //create people array
ArrayList<Family> families = new ArrayList<Family>(); //create family array
int totalPeople = 0;
int totalFamilies = 0;
Map familyHash = new HashMap();
ArrayList myList;

///starting orientation
float xTrans = 0;
float yTrans = 0;
float targetYTrans = 0;
float targetXTrans = 0;
float yearRotation = 0;

//interaction settings
int scanSpeed = 20;

Boolean shiftDown = false;

int genArray[] = new int[40];

SoftFullScreen fs;

///set starting person
Person a;


void setup() {
  frameRate(12);
  //  size(1400, 1000);
  size(1680, 1050);

  background(0);
  fs = new SoftFullScreen(this);
  fs.setShortcutsEnabled(false);
  hint(DISABLE_OPENGL_2X_SMOOTH);
  fs.enter();


  yearFont = loadFont("EuphemiaUCAS-12.vlw");

  noFill();
  smooth();

  //ready the data//
  records = loadStrings("my.ged"); // reads a .ged file
 
  createFamilies();
  createIndividuals();

  Family sFamily = (Family) familyHash.get("F1992");
  Person a = sFamily.children.get(0);
  
  createGen(a, 1);

  //populate genDensity array

  for (int i = 0; i < people.size() ; i++) 
  {
    a = people.get(i);
    cleanUpDOB(people.get(i), 0);
    genArray[a.GEN] += 1;
  }

  //reset angles
  getAngles(a, 0);

  xTrans = width/2;
  yTrans = height/2;
  targetXTrans = width/2;
  targetYTrans = height/2;
}

void draw() {
  //orientation

  personSize = scaleNum*.02;

  background(backFill);



  if(yTrans != targetYTrans)
  {
    yTrans = .9*yTrans + .1*targetYTrans;
  }
  if(xTrans != targetXTrans)
  {
    xTrans = .9*xTrans + .1*targetXTrans;
  }
  if (scaleNum != targetScaleNum)
  {
    scaleNum = .9*scaleNum + .1*targetScaleNum;
  }

  translate(xTrans, yTrans);
  rotate(0);



  Family sFamily = (Family) familyHash.get("F1992");
  Person a = sFamily.children.get(0);

  //  Person a = people.get(0);

  getAngles(a, 0);

  drawYearCircles(a);
  drawYears(a);

  //  sFamily = (Family) familyHash.get("F1992");
  //  Person b = sFamily.children.get(0);
  //  if (sFamily != null) {
  //
  //    if (sFamily.father != null) {
  //      stroke(120);
  //      line(sFamily.father.x, sFamily.father.y, b.x, b.y);
  //    }
  //    if (sFamily.mother != null) {
  //      stroke(120);
  //      line(sFamily.mother.x, sFamily.mother.y, b.x, b.y);
  //    }
  //  }


  for (int i = 0; i < people.size() ; i++) 
  {
    Person p = people.get(i);
    p.hover = false;
    // check to see if highlighted
    if (mouseX > (p.x + xTrans - personSize/2) && mouseX < (p.x + xTrans + personSize/2) && mouseY > (p.y + yTrans - personSize/2) && mouseY < (p.y + yTrans + personSize/2))
    {
      //println(p.NAME + " is now 'Selected' "+ p.x + ", " + p.y);
      p.selected = true;
      p.hover = true;
    }
    if (p.selected == true) {
      lines(p);
    }
  }

  drawPeople(a, a.DOB, a.theta);


///////print instructions on screen

translate(-xTrans, -yTrans);
fill(255);
    textAlign(LEFT);
    textSize(14);
text("Use arrow keys to navigate", 15, 20);
text("press Z to zoom out, X to zoom in", 15, 40); // textAscent()/2
text("press 0 to reset and move to center", 15, 60);
text("hover over to see lineage, click to spread out tree", 15, 80);

  //  assign direct family members
  //  drawDOB = getperson.DOB
  //  drawAngle = getperson.child.angle + 180/(2^getperson.GEN-1);
  //  for (int i = 0; i < people.size() ; i++) 
  //  {
  //    Person p = people.get(i);
  //    drawPeople(p, p.DOB, p.theta);
  //  }
}

///////Method to draw year rings
void drawYearCircles(Person p) {
  strokeWeight(1);
  stroke(circleStroke);
  fill(backFill);
  pushMatrix();
  if (rightAlign = true) {
    ellipseMode(CENTER);
    for (int i = 10 ; i > -1 ; i--) {
      ellipse(0, 0, (i)*scaleNum, (i)*scaleNum);
    }
  }
  popMatrix();
}

///////Method to draw year numebers
void drawYears(Person p) {
  pushMatrix();
  rotate(radians(yearRotation));
  //  rotate(0);
  fill(200);
  textFont(yearFont, yearSize);
  textAlign(CENTER); //center align
  for (int i = 0 ; i < 11 ; i++) { // print 11 centuries
    text(2000-(i*100), 0, -(i)*scaleNum/2); //year number (calculated), x coord, y coord.
  }
  popMatrix();
}

void mousePressed() {
  for (int i = 0; i < people.size() ; i++) 
  {
    Person p = people.get(i);
    p.selected = false;


    // check to see if highlighted
    if (mouseX > (p.x + xTrans - personSize/2) && mouseX < (p.x + xTrans + personSize/2) && mouseY > (p.y + yTrans - personSize/2) && mouseY < (p.y + yTrans + personSize/2))
    {
      //println(p.NAME + " is now 'Selected' "+ p.x + ", " + p.y);

      boolean prev = p.selected;

//      if (shiftDown == true) {
//        targetXTrans = width/2 - p.x;
//        targetYTrans = height/2 - p.y;
//      }
      if (p.GEN > 1) {
        p.GEN -= 1;
      }

      createGen(p,p.GEN);

      if (p.selected != prev) {
        p.selected = !p.selected;
      } 
      else {
        //        prev = !p.selected;
      }
    }
  }
}


void keyPressed() {

  if(key =='0') {
    targetXTrans = width/2;
    targetYTrans = height/2;
    
    Family sFamily = (Family) familyHash.get("F1992");
    Person a = sFamily.children.get(0);
  
    createGen(a, 1);
    
  }

  if(key == 'z') {
    targetScaleNum *= .90;
    //    targetYTrans -= targetScaleNum;
    //    targetXTrans -= targetScaleNum;
  }

  if(key == 'x') {
    targetScaleNum *= 1.1;
    //    targetYTrans -= height/targetScaleNum;
    //    targetXTrans -=  width/targetScaleNum;
  }

  if (key == CODED) {
    if (keyCode == DOWN) {
      targetYTrans -= 100;
    }
    if (keyCode == UP) {
      targetYTrans += 100;
    }
    if (keyCode == RIGHT) {
      targetXTrans -= 100;
    }
    if (keyCode == LEFT) {
      targetXTrans += 100;
    }
    if (keyCode == SHIFT) {
       shiftDown = true;
    }
    
  }
}

