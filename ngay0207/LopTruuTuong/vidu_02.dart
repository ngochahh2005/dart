abstract class Shape {
  int dim1, dim2;
  Shape(this.dim1, this.dim2);
  void area();
}

class Rectangle extends Shape {
  Rectangle(int dim1, int dim2) : super(dim1, dim2);

  @override
  void area() => print(dim1 * dim2);
}

void main() {
  Rectangle rectangle = Rectangle(10, 20);
  rectangle.area();
}
