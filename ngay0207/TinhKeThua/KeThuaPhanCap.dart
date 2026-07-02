class Shape {
  double? diameter1;
  double? diameter2;
}

class Rectangle extends Shape {
  double area() => diameter1! * diameter2!;
}

class Triangle extends Shape {
  double area() => 0.5 * diameter1! * diameter2!;
}

void main() {
  Rectangle r = new Rectangle();
  r.diameter1 = 10.0;
  r.diameter2 = 20.0;
  print("Diện tích hình chữ nhật: ${r.area()}");

  Triangle t = new Triangle();
  t.diameter1 = 10.0;
  t.diameter2 = 20.0;
  print("Diện tích hình tam giác: ${t.area()}");
}