import 'dart:math';

class Point {
  double x, y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}

class Point2 {
  double? x; // thuoc tinh instance x, ban dau mac dinh la null
  double y = 0; // thuoc tinh instance z, ban dau co gia tri la 0
}

//====
double _X = 1.5;

class Point3 {
  double? x = _X; // co the truy cap khai bao khong phu thuoc this

  // double? y = this.x; => error
  double? y;
  late double? z = this.x; // => duoc gan

  Point3(this.x, this.y, this.z);
}

/* 
  Phương thức khởi tạo
  Ta có thể tạo đối tượng bằng cách sử dụng phương thức khởi tạo (constructors).
  Tên constructor có thể là ClassName hoặc ClassName.identifier
*/
class Rectangle {
  double left, top, width, height;
  late double _z;

  Rectangle(this.left, this.top, this.width, this.height);

  double get z => _z;
  set z(double value) => _z = value;

  @override
  String toString() {
    return left.toString() +
        "," +
        top.toString() +
        ' ' +
        width.toString() +
        ',' +
        height.toString();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;  // kiem tra 2 bien co dang cung tro den cung 1 doi tuong hay khong
    if (other is! Rectangle) return false;

    return left == other.left &&
        top == other.top &&
        width == other.width &&
        height == other.height;
  }
}

/*
  Thuộc tính và phương thức static
  Thuộc tính và phương thức tĩnh (static) được sử dụng để chia sẻ dữ liệu và chức năng giữa tất cả các đối tượng của 1 lớp
  --> Không cần phải tạo ra 1 đối tượng để truy cập vào các thuộc tính hoặc phương thức này.
 */
class MyMath {
  static const double PI = 3.14159;

  static double sqr(double x) => x * x;
}

void main() {
  // khoi tao doi tuong
  Point p1 = Point(0, 0);
  var p2 = Point(3, 3);

  double d = p1.distanceTo(p2);
  print(d.toStringAsFixed(2));

  //=====
  Point2 p2_1 = Point2();
  print(p2_1);

  //=====
  var r = Rectangle(0, 0, 15, 10);
  r.z = 100;
  print(r._z);

  //=====
  print(MyMath.sqr(5));

  //=====
  print(r.toString());

  //=====
  var r2 = Rectangle(1, 0, 15, 10);
  print(r == r2);
}
