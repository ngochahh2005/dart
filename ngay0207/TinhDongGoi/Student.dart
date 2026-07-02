class Student {
  final String _schoolname;

  Student(this._schoolname);

  String get schoolname => _schoolname;
  // set schoolnam(String value) => _schoolname = value;
}

void main() {
  var student = Student('ABC School');
  print(student.schoolname);
}
