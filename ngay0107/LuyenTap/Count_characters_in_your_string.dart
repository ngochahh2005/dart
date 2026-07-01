import 'dart:io';

Map<String, int> count(String s) {
  Map<String, int> mp = {};
  for (var c in s.split('')) {
    mp[c] = (mp[c] ?? 0) + 1;
  }
  return mp;
}

void main() {
  String str = stdin.readLineSync()!;
  print(count(str));
}

//https://www.codewars.com/kata/52efefcbcdf57161d4000091/train/dart 