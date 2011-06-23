void lines(Person p)
{
  /*
  strokeWeight(2);
  //find parents
  Family sFamily = (Family) familyHash.get(p.FAMC);
  if (sFamily != null) {

    if (sFamily.father != null) {
      stroke(#38796B);
      line(sFamily.father.x, sFamily.father.y, p.x, p.y);
      lines(sFamily.father);
    }
    if (sFamily.mother != null) {
      stroke(#5EB66B);
      line(sFamily.mother.x, sFamily.mother.y, p.x, p.y);
      lines(sFamily.mother);
    }
  }
  */
  
  strokeWeight(2);
  noFill();
  //find parents
  Family sFamily = (Family) familyHash.get(p.FAMC);
  if (sFamily != null) {

    if (sFamily.father != null) {
      stroke(#38796B);
        bezier(p.x, p.y,         p.x, p.y,          sFamily.father.x, sFamily.father.y,         sFamily.father.x, sFamily.father.y);
      lines(sFamily.father);
    }
    if (sFamily.mother != null) {
      stroke(#5EB66B);
      line(sFamily.mother.x, sFamily.mother.y, p.x, p.y);
      lines(sFamily.mother);
    }
  
  }
  
}


 /**
 * Bezier. 
 * 
 sFamily.father.DOB*cos(sFamily.father.theta), sFamily.father.DOB*sin(sFamily.father.theta)
 
 * The first two parameters for the bezier() function specify the 
 * first point in the curve and the last two parameters specify 
 * the last point. The middle parameters set the control points
 * that define the shape of the curve. 
 *
 
size(200, 200); 
background(0); 
stroke(255);
noFill();
smooth(); 

for(int i = 0; i < 100; i += 20) {
  bezier(90-(i/2.0), 20+i, 210, 10, 220, 150, 120-(i/8.0), 150+(i/4.0));
}
*/
