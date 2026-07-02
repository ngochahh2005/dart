class Camera {
  String? name, color, megapixel;

  void display() {
    print('$name - $color - $megapixel');
  }
}

void main() {
  Camera c1 = Camera();
  c1.name = 'Camera 1';
  c1.color = 'Black';
  c1.megapixel = '4000x3000';
  Camera c2 = Camera();
  c2.name = 'Camera 2';
  c2.color = 'White';
  c2.megapixel = '6000x8000';
  c1.display();
  c2.display();
}
