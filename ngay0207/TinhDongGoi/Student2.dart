class Student {
  String _name;
  int _classnumber;

  Student(this._name, this._classnumber);

  set name(String name) => _name = name;

  set classnumber(int classnumber) {
    if (classnumber < 1 || classnumber > 12) {
      throw Exception('Số lớp phải nằm trong khoảng từ 1 đến 12');
    }
    _classnumber = classnumber;
  }

  @override
  String toString() => '$_name - $_classnumber';
}

void main() {
  Student student = Student('Nguyen Van A', 5);
  student.classnumber = 0;
  print(student);
}
