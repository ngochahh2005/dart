/**
  Mixin là 1 lớp có chứa các phương thức và thuộc tính dùng để gộp vào 1 lớp khác.
  Mixin không thể được sử dụng để tạo đối tượng trực tiếp.
  Để sd mixin, sử dụng từ khóa with
 */

mixin M {
  int? a;
  void showSomething() {
    print('Print message...');
  }
}

class B {
  String name = 'Class B';
  void displayInformation() {
    print('Information from B');
  }
}

class C extends B with M {
  @override
  void displayInformation() {
    showSomething();
    a = 100;
  }
}

void main() {
  var c = C();
  c.displayInformation();
}
