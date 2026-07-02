class Animal {
  void makeSound() {
    print('Animal makes a sound');
  }
}

class Dog extends Animal {
  void makeSound() {
    super.makeSound();
    print('Dog barks');
  }
}

void main() {
  Dog dog = Dog();
  dog.makeSound();
}
