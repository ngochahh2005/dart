class Car {
  String? name, color;
  int? price;

  Car(this.name, this.color, this.price);

  Car.namedConstructor(this.name, this.color);

  void display() {
    print('$name - $color - $price');
  }
}

void main() {
  Car car = Car('Car 1', 'Black', 1000);
  Car car2 = Car.namedConstructor('Car 2', 'White');
  car.display();
  car2.display();
}
