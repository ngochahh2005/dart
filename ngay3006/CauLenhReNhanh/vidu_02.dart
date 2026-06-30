// Nhap 1 thang, kiem tra xem thang do co bao nhieu ngay
import 'dart:io';

void main() {
  int thang = 0;
  do {
    stdout.write("Nhập vào 1 tháng: ");
    String? input = stdin.readLineSync();
    if (input != null) {
      thang = int.tryParse(input) ?? 0;
    }
  } while (thang < 1 || thang > 12);

  switch (thang) {
    case 2:
      print("Thang $thang co 28 ngay");
      break;
    case 1:
    case 3:
    case 5:
    case 7:
    case 8:
    case 10:
    case 12:
      print("Thang $thang co 31 ngay");
      break;
    default:
      print("Thang $thang co 30 ngay");
      break;
  }
}
