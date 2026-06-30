// giai phuong trinh ax^2 + bx + c = 0;

import 'dart:math';
import 'dart:io';

void main() {
  double a = 0, b = 0, c = 0;
  do {
    stdout.write("Nhập hệ số a (a khác 0): ");
    String? input = stdin.readLineSync();
    if (input != null) {
      a = double.tryParse(input) ?? 0; // co bat loi kieu du lieu
    }
  } while (a == 0);

  stdout.write("Nhập hệ số b: ");
  String? input = stdin.readLineSync();
  if (input != null) {
    b = double.tryParse(input) ?? 0;
  }

  stdout.write("Nhập hệ số c: ");
  input = stdin.readLineSync();
  if (input != null) {
    c = double.tryParse(input) ?? 0;
  }

  double delta = b * b - 4 * a * c;
  print("Phương trình: ${a}x^2 + ${b}x + $c = 0");

  if (delta < 0) {
    print("Phương trình vô nghiệm");
  } else if (delta == 0) {
    print("Phương trình có nghiệm kép: ${-b / (2 * a)}");
  } else {
    double x1 = (-b - sqrt(delta)) / (2 * a);
    double x2 = (-b + sqrt(delta)) / (2 * a);
    print("Phương trình có 2 nghiệm là: ${x1.toStringAsFixed(2)} và ${x2.toStringAsFixed(2)}");
  }
}
