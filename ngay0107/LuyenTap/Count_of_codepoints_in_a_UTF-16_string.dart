import 'dart:io';

int getRealLength(String str) {
  Runes r = str.runes;
  return r.length;
}

void main() {
  String str = stdin.readLineSync()!;
  print(getRealLength(str));
}

//https://www.codewars.com/kata/599c4b69eb8e49effa000079/train/dart
