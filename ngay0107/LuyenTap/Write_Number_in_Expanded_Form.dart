import 'dart:io';

String expandedForm(int num) {
  String rs = "";
  int pow = 1;
  while (num > 0) {
    int s = num % 10 * pow;
    if (s != 0) {
      if (rs != "")
        rs = s.toString() + " + " + rs;
      else
        rs = s.toString();
    }
    pow *= 10;
    num ~/= 10;
  }
  return rs;
}

void main() {
  int n = int.parse(stdin.readLineSync()!);
  print(expandedForm(n));
}

//https://www.codewars.com/kata/5842df8ccbd22792a4000245/train/dart 