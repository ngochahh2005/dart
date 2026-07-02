class Laptop {
  Laptop() {
    print("Ham tao cua Laptop");
  }

  Laptop.named() {
    print('Ham tao co ten cua Laptop');
  }
}

class MacBook extends Laptop {
  MacBook() : super.named() {
    print('Ham tao cua MacBook');
  }
}

void main() {
  var macbook = MacBook();
}
