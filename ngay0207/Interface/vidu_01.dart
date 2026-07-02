/**
  Cú pháp
  abstract class InterfaceName {
    // Các phương thức trừu tượng hoặc thuộc tính
    void method1();
  }


  class ClassName implements InterfaceName {
    @override
    void method1() {
      // Triển khai logic cụ thể
    }
  }
 */

abstract class Vehicle {
  void start();
  void stop();
}

class Car implements Vehicle {
  @override
  void start() => print('Car started');

  @override
  void stop() => print('Car stopped');
}


void main() {
  var car = Car();
  car.start();
  car.stop();
}
