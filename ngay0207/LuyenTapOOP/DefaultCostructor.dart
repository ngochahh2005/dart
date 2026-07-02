class Person {
  String? name, planet;

  Person() {
    this.planet = 'Trái Đất';
  }
}

void main() {
  Person person = Person();
  person.name = 'Nguyen Van A';
  print('${person.name} - ${person.planet}');
}
