import 'dart:async';

/**
 * Future là gì?
 * Đó là 1 cách làm việc với các tác vụ mất thời gian mà không phải chờ đợi
 * VD: tải dữ liệu từ internet, đọc tệp
 * 
 * Hiểu rõ về async/await
 * 
 * Từ khóa async:
 * - Khi thềm từ khóa async vào 1 hàm, bạn đang nói với Dart: Hàm này sẽ chứa code bất đồng bộ
 * - Một hàm được đánh dấu async sẽ luôn luôn trả về 1 Future (ngay cả khi bạn không khai báo nó)
 */
Future<String> layTen() async {
  return 'Nguyen Van A';
}

/**
 * Từ khóa await:
 * - await chỉ có thể được sử dụng bên trong 1 hàm  async
 * - Khi đặt await trược 1 Future, Dart sẽ:
 *  + Tạm dừng thực thi tại dòng đó
 *  + Đợi Future hoàn thành
 *  + Trả về giá trị từ Future (không còn đóng gói trong Future nữa)
 *  + Tiếp tục thực thi những dòng code còn lại
 * - await biến đổi 
 */

// Ham tra ve Future
Future<String> taiDuLieu() {
  return Future.delayed(Duration(seconds: 2), () => 'Du lieu da tai xong');
}

// Goi ham cach 1
void hamChinh1() {
  print('Bat dau tai');
  Future<String> f = taiDuLieu();
  f.then((ketQua) {
    print('Ket qua: $ketQua');
  });
  print('Tiep tuc cong viec khac');
}

// Goi ham cach 2
void hamChinh2() async {
  print('Bat dau tai'); //1
  String ketQua =
      await taiDuLieu(); // cho nao co du lieu thi moi thuc hien tiep
  print('Ket qua: $ketQua');
  print('Tiep tuc cong viec khac'); //3
}

void main() {
  // hamChinh1();
  // print('========');
  hamChinh2();
}
