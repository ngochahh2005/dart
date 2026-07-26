import 'dart:async';

void main() async {
  final StreamController<String> controller = StreamController<String>();

  // lang nghe stream sau khi da qua cac toan tu bien doi (where, map)
  controller.stream
      .where((event) => event.isNotEmpty) // chi lay cac chuoi khong rong
      .map((event) => event.toUpperCase()) // bien doi chuoi thanh chu hoa
      .listen(
        // xu ly khi nhan duoc du lieu thanh cong (onData)
        (data) {
          // in ket qua cuoi cung ra man hinh
          print('Nhan duoc du lieu: $data');
        },
        // xu ly khi co loi xuat hien trong luong (onError)
        onError: (err, stackTrace) {
          print('Bat duoc loi: $err');
        },
        // (tuy chon) xu ly kho stream bi dong hoan toan (onDone)
        onDone: () {
          print('Stream da duoc dong hoan toan');
        }
      );

  // them cac du lieu mau vao Stream (bao gom ca chuoi rong de kiem chung where)
  print('Bat dau day du lieu vao luong');

  controller.sink.add('Xin chao');
  controller.sink.add('');
  controller.sink.add('flutter');
  controller.sink.addError(Exception('Ket noi mang bi loi'));
  controller.sink.add('   ');
  controller.sink.add('dart stream operators');

  // doi 1 giay roi dong controller de ket thuc chuong trinh
  await Future.delayed(Duration(seconds: 1));
  await controller.close();
  print('Da dong Stream');
}
