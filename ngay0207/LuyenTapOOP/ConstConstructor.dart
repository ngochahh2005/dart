class Costumer {
  final String? name;
  final int? age;
  final String? phone;

  const Costumer({this.name, this.age, this.phone});

  void display() {
    print('$name - $age - $phone');
  }
}

void main() {
  Costumer costumer = const Costumer(name: 'A', age: 20, phone: '0123456789');
  costumer.display();
}
