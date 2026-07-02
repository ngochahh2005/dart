class Patient {
  String name;
  int? age;
  String? disease;

  Patient({this.name = '', this.age, this.disease});

  @override
  String toString() => name + ' ' + age.toString() + ' ' + disease!;
}

void main() {
  Patient patient = Patient(name: 'A', age: 50, disease: 'Benh 1');
  print(patient);
}
