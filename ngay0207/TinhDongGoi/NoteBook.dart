class NoteBook {
  String? _name;
  double? _prize;

  set name(String name) => _name = name;

  set price(double price) {
    if (price < 0) {
      throw Exception("Price cannot be less than 0");
    }
    this._prize = price;
  }

  void display() {
    print("Name: $_name");
    print("Price: $_prize");
  }
}

void main() {
  NoteBook nb = new NoteBook();
  nb.name = "Dell";
  nb.price = -1;

  nb.display();
}