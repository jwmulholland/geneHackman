void drawPeople(Person p, float r, float theta) {

  theta += 90; 
  theta = radians(theta);
  r = (2000-r)/100*scaleNum/2;
  p.x = r*cos(theta);
  p.y = r*sin(theta);
  pushMatrix();
  translate(p.x, p.y);
  rotate(theta);
  fill(peopleFill);
  ellipse(0,0, personSize, personSize);

  if (p.hover == true) {
    strokeWeight(1);
    stroke(0);
    fill(0,50,50,90);
    rectMode(CENTER);
    rect(0, 0, personSize, personSize);

    rotate(-theta);
    fill(255);
    textAlign(LEFT);
    textSize(14);
    String newText = p.NAME + " " + p.DOB  + " " + p.GEN;
    text(newText, personSize + 10, textAscent()/2);
  }

  popMatrix();

  ///////IF PERSON IS A CHILD (has FAMC) - find siblings, find parents and draw recursively
  Family cFamily = (Family) familyHash.get(p.FAMC); //get family for child-of
  if (cFamily != null && cFamily.children.size() > 0)
  { 
    ////draw parents
    if (cFamily.father != null) //if person has father
    {
      drawPeople(cFamily.father, cFamily.father.DOB, cFamily.father.theta);//draw father
    }

    if (cFamily.mother != null) //if person has mother
    { 
      drawPeople(cFamily.mother, cFamily.mother.DOB, cFamily.mother.theta);//draw mother
    }
  }
}

