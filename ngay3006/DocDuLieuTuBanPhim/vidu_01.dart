import 'dart:io';

void main() {
  // Nhap ten nguoi dung
  stdout.write('Enter your name: ');
  String name = stdin.readLineSync()!; // !: cam ket se nhap du lieu

  // Nhap tuoi nguoi dung
  stdout.write('Enter your ages: ');
  int age = int.parse(stdin.readLineSync()!);

  print('Xin chao $name, tuoi cua ban la $age');
}
