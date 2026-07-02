class Vehicle {
  String _branch;
  double _speed;

  Vehicle(this._branch, this._speed);

  String get branch => _branch;
  set branch(String branch) => _branch = branch;

  double get speed => _speed;
  set speed(double speed) => _speed = speed;
}

class Car extends Vehicle {
  int _numberOfSeats;
  Car(String branch, double speed, this._numberOfSeats) : super(branch, speed);
}

void main() {
  Car car = Car('Toyota', 80.5, 4);
  print('${car._branch} - ${car._speed} - ${car._numberOfSeats}');
}
