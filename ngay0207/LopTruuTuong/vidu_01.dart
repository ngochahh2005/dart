//Lớp trừu tượng là những lớp không thể khởi tạo trực tiếp.
//Chúng được dùng để định nghĩa các hành vi khung cho các lớp khác kế thừa.
//Một lớp trừu tượng được khai báo bằng từ khóa abstract.
abstract class Vehicle {
  void start();
  void stop();
}

class Car extends Vehicle {
  @override
  void start() => print('Car started');

  @override
  void stop() => print('Car stopped');
}

class Bike extends Vehicle {
  @override
  void start() => print('Bike started');

  @override
  void stop() => print('Bike stopped');
}

void main() {
  Car car = Car();
  car.start();
  car.stop();
 
  Bike bike = Bike();
  bike.start();
  bike.stop();
}
