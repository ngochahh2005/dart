/**
 Yêu cầu:

  Tạo một Enhanced Enum tên là CoffeeSize gồm 3 size: small, medium, large.

  Mỗi size phải đi kèm với 2 thuộc tính:

  int volume (thể tích, tính bằng ml). Ví dụ: small = 250, medium = 350, large = 500.

  double price (giá tiền, tính bằng USD). Ví dụ: small = 2.5, medium = 3.5, large = 4.5.

  Tạo một hàm khởi tạo (constructor) const để nhận vào volume và price.

  Viết một phương thức String description() bên trong Enum để in ra chuỗi giới thiệu. Ví dụ gọi CoffeeSize.medium.description() sẽ trả về: "Size medium: 350ml - \$3.5".
 */

enum CoffeeSize {
  small(250, 2.5),
  medium(350, 3.5),
  large(500, 4.5);

  final int volume;
  final double price;

  const CoffeeSize(this.volume, this.price);

  String description() =>
      'Size ${this.name}: ${this.volume}ml - ${this.price}';
}

void main() {
  CoffeeSize cur = CoffeeSize.large;
  print(cur.description());
}
