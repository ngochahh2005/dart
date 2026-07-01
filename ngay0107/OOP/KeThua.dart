class Product {
  double price;
  int quantity;
  String name;

  Product(this.price, this.quantity, this.name);

  void showTotal() {
    print('Total price is ${price * quantity}');
  }
}

class Tablet extends Product {
  double width;
  double height;

  Tablet(this.width, this.height, double price, int quantity, String name)
    : super(price, quantity, name); // gan thong tin vao cha

  @override
  void showTotal() {
    print('Name of tablet: $name');
    super.showTotal();
  }
}

void main() {
  Product p = Product(6000000, 1, "San pham");
  Product p1 = new Tablet(7, 6, 20000000, 10, "Ipad pro");
  p.showTotal();
  print("========");
  p1.showTotal();
}
