void main() {
  int diemToan = 8;
  int diemVan = 7;
  int tongDiem = 0;

  tongDiem += diemToan;
  tongDiem += diemVan;

  double diemTB = tongDiem / 2;

  String? ketQua;
  ketQua ??= 'Chua xet';

  if (diemTB >= 5) {
    ketQua = 'Dat';
  }
  print('Diem TB: $diemTB');
  print("Ket qua: $ketQua");
}
