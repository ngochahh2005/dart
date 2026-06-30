void main() {
  var a = 2;
  print(a);

  // ??= : chỉ gán giá trị nếu như biến đó đang null
  int? b;
  b ??= 5;
  print('b = $b'); // b = 5

  b ??= 10;
  print('b = $b'); // b = 5
}
