class Family //new Person(newID, newUID, newHUSB, newWIFE, newDOM, newPOM);
{
  String ID; // unique ID for entry
  String UID;
  String HUSB;
  String WIFE;
  String DOM;
  String POM;
  Person father;
  Person mother;
  ArrayList<Person> children = new ArrayList<Person>();

  Family (    ) //empty constructor
  { }
}
