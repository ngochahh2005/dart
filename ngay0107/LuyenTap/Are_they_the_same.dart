import 'dart:io';
import 'dart:math';

bool comp(List<int> a1, List<int> a2) {
  for (var e in a2) {
    if (e < 0) return false;
    int sq = sqrt(e).toInt();
    if (sq * sq != e) return false;
    if (!a1.contains(sq) && !a1.contains(-sq)) return false;
    if (a1.contains(sq))
      a1.remove(sq);
    else
      a1.remove(-sq);
  }
  return true;
}

void main() {
  List<int> l1 = [], l2 = [];
  String? input = stdin.readLineSync();
  if (input != null) {
    l1 = input.split(',').map((e) => int.parse(e)).toList();
  }
  input = stdin.readLineSync();
  if (input != null) {
    l2 = input.split(',').map((e) => int.parse(e)).toList();
  }

  print(comp(l1, l2));
}

//https://www.codewars.com/kata/550498447451fbbd7600041c/train/dart
