class Car {
  int noOfSeats = 4;
}

class Tesla extends Car {
  int noOfSeats = 6;

  void display() {
    print('So ghe trong Tesla: $noOfSeats');
    print('So ghe trong Car: ${super.noOfSeats}');
  }
}

void main() {
  var tesla = Tesla();
  tesla.display();
}
