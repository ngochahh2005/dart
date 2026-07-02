class Person {
  String name;
  int age;

  Person(this.name, this.age);
}

class Student extends Person {
  int rollNumber;

  Student(this.rollNumber, String name, int age) : super(name, age);
}

void main() {
  var student = Student(1, 'Nguyen Van A', 20);

  print('${student.name} - ${student.age} - ${student.rollNumber}');
}
