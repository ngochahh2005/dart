class Student {
  int id;
  String name;
  static String schoolName = 'ABC School';

  Student(this.id, this.name);

  void display() {
    print('ID: $id');
    print('Name: $name');
    print('School name: $schoolName');
  }
}

void main() {
  Student s1 = Student(1, 'John');
  Student s2 = Student(2, 'Smith');
  s1.display();
  s2.display();
}
