class University {
  String _name;
  int _year;

  University(this._name, this._year);

  set name(String name) => _name = name;
  String get name => _name;

  set year(int year) {
    if (year < 1900 || year > 2023)
      throw Exception('Năm phải nằm trong 1900 đến 2023');

    _year = year;
  }

  int get year => _year;
}

void main() {
  University university = University('PTIT', 1989);
  university.year = 200;
  print('${university.name} - ${university.year}');
}
