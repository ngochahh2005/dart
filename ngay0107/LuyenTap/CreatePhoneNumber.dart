String createPhoneNumber(List numbers) {
  List<String> s = numbers.map((e) => e.toString()).toList();
  return '(' +
      s[0] +
      s[1] +
      s[2] +
      ') ' +
      s[3] +
      s[4] +
      s[5] +
      '-' +
      s[6] +
      s[7] +
      s[8] +
      s[9];
}

void main() {
  List<int> list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0];
  print(createPhoneNumber(list));
}

//https://www.codewars.com/kata/525f50e3b73515a6db000b83/train/dart 