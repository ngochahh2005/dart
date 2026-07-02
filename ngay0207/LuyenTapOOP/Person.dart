class Person {
  String? _name, _address;
  int? _age;

  Person.namedConstrutor(this._name, this._address, this._age);

  String get name => _name!;
  set name(String name) => _name = name;

  String get address => _address!;
  set address(String address) => _address = address;

  int get age => _age!;
  set age(int age) {
    if (age < 0) throw Exception('Tuổi không được nhỏ hơn 0');
    _age = age;
  }

  @override
  String toString() => '$_name - $_age - $_address';
}

void main() {
  Person person = Person.namedConstrutor('Nguyen Van A', 'Ha Noi', 20);
  print(person);
  person.age = -1;
}
