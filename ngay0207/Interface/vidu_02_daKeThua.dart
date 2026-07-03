abstract class Area {
  void area();
}

abstract class Perimeter {
  void perimeter();
}

class Rectangle implements Area, Perimeter {
  int length, breadth;
  Rectangle(this.length, this.breadth);

  @override
  void area() => print('Area: ${length * breadth}');

  @override
  void perimeter() => print('Perimeter: ${2 * (length + breadth)}');
}


void main() {
  Rectangle rect = Rectangle(10, 20);
  rect.area();
  rect.perimeter();
}