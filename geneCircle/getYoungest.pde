Person getYoungest() {
  
  Person youngest = people.get(0);
  
  
  for (int i = 0; i < people.size() ; i++) 
  {
    Person a = people.get(i);
    if (a.DOB < youngest.DOB) {
      youngest = a;
    } 
  }
  
  return youngest;
}

