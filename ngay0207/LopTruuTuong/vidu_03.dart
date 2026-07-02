abstract class Bank {
  String name;
  double rate;

  Bank(this.name, this.rate);

  void interest();

  void display() {
    print('Bank name: $name');
  }
}

class SBI extends Bank {
  SBI(String name, double rate) : super(name, rate);

  @override
  void interest() => print('The race of interest of SBI is $rate');
}

void main() {
  SBI sbi = SBI('SBI', 8.4);
  sbi.interest();
  sbi.display();
}
