class Home {
  String? name, address, numberOfRooms;

  Home(this.name, this.address, this.numberOfRooms);

  void display() {
    print('$name - $address - $numberOfRooms');
  }
}

void main() {
  Home home = Home('My Home', 'Bac Giang', '101');
  home.display();
}
