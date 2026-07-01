import 'dart:io';

bool isUppercase(String s) => s == s.toUpperCase();

bool isLowercase(String s) => s == s.toLowerCase();

String solve(String s) {
  int low = 0, up = 0;
  for (var c in s.split('')) {
    if (isLowercase(c))
      low++;
    else
      up++;
  }
  if (low >= up)
    s = s.toLowerCase();
  else
    s = s.toUpperCase();
  return s;
}

void main() {
  String s = stdin.readLineSync()!;
  print(solve(s));
}

//https://www.codewars.com/kata/5b180e9fedaa564a7000009a/train/dart 