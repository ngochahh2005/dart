//super được sử dụng để tham chiếu đến lớp cha (parent class). 
//Nó được dùng để gọi các thuộc tính và phương thức của lớp cha.

class Laptop {
  void show() {
    print('Phuong thuc show cua Laptop');
  }
}

class MacBook extends Laptop {
  void show() {
    super.show(); // Goi phuong thuc show cua lop cha
    print('Phuong thuc show cua MacBook');
  }
}

void main() {
  MacBook macBook = MacBook();
  macBook.show();
}
