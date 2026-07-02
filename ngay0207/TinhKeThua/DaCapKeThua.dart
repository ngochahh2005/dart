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

class Model3 extends Tesla {
  String? color;

  void display() {
    super.display();
    print('Mau sac: $color');
  }
}

void main() {
  Model3 m = Model3();
  m.name = 'Tesla model 3';
  m.price = 500.0;
  m.color = 'Red';
  m.display();
}
