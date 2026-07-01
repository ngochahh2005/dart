import 'dart:io';

int persistence(int n) {
  int cnt = 0;
  while (n >= 10) {
    String s = n.toString();
    int x = 1;
    for (var c in s.split('')) {
      x *= int.parse(c);
    }
    cnt++;
    n = x;
  }
  return cnt;
}

void main() {
  int n = int.parse(stdin.readLineSync()!);
  print(persistence(n));
}

// https://www.codewars.com/kata/55bf01e5a717a0d57e0000ec/train/dart 