/* 
  Chuoi la 1 tap hop ky tu UTF-16
*/
void main() {
  var s1 = 'Nguyen Van A';
  var s2 = "PTIT";

  // Chen gia tri cua 1 bieu thuc, bien vao trong chuoi: ${...}
  double diemToan = 9.5;
  double diemVan = 7.5;
  var s3 = 'Xin chao $s1, ban da dat tong diem la: ${diemVan + diemToan}';
  print(s3);

  // tao ra chuoi nam o nhieu dong
  var s4 = '''
  Dong 1
  Dong 2
  Dong 3
  ''';

  var s5 = """ 
  Dong 1
  Dong 2
  Dong 3
  """;

  var s6 = 'Day la mot doan\nvan ban!';
  print(s6);

  // them r (raw): tat ca ky tu dac biet deu khong tinh
  var s7 = r"Day la mot doan\nvan ban!";
  print(s7);

  var s8 = "Chuoi 1 " + "Chuoi 2";
  print(s8);

  var s9 =
      'Chuoi '
      "nay "
      "la "
      "mot chuoi";
  print(s9);
}
