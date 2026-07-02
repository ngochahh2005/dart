class Car {
  String? name;
  double? price;
}

class Tesla extends Car {
  void display() {
    print('Ten: $name');
    print('Gia: $price');
  }
}

void main() {
  Tesla t = Tesla();
  t.name = 'Tesla model 3';
  t.price = 500.0;
  t.display();
}
