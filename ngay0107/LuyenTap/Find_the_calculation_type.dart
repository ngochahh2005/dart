import 'dart:io';

String calcType(int a, int b, num c) {
  if (a + b == c) return "addition";
  if (a - b == c) return "subtraction";
  if (a * b == c) return "multiplication";
  return "division";
}

void main() {
  String? input = stdin.readLineSync();
  int a = 0, b = 0;
  num c = 0;
  if (input != null) a = int.tryParse(input) ?? 0;
  input = stdin.readLineSync();
  if (input != null) b = int.tryParse(input) ?? 0;
  input = stdin.readLineSync();
  if (input != null) c = int.tryParse(input) ?? 0;
  print(calcType(a, b, c));
}

//https://www.codewars.com/kata/5aca48db188ab3558e0030fa/train/dart
