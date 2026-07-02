class Laptop {
  Laptop({String name = '', String color = ''}) {
    print("Ham tao cua Laptop");
    print('Ten: $name');
    print('Mau: $color');
  }
}

class MacBook extends Laptop {
  MacBook({String name = '', String color = ''}) : super(name: name, color: color) {
    print("Ham tao cua MacBook");
  }
}

void main() {
  var macbook = MacBook(name: 'MacBook Pro', color: 'Black');
}
