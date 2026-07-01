import 'dart:io';

bool solution(String text, String ending) => text.endsWith(ending);

void main() {
  String text = stdin.readLineSync()!;
  String ending = stdin.readLineSync()!;
  print(solution(text, ending));
}

//https://www.codewars.com/kata/51f2d1cafc9c0f745c00037d
