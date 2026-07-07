import 'dart:async';

/**
 * Stream là gì?
 * Stream trong Dart là chuỗi các sự kiện hoặc dữ liệu theo thời gian, 
 * không chỉ 1 lần như Future
 */

void demSo() {
  print('=== Vi du 1: Stream tro choi nam muoi ===');
  // Tao ra stream dem so (phat ra con so tu 0, 5, 10,..., 100), moi giay dem 1 so
  Stream<int> stream = Stream.periodic(
    Duration(seconds: 1),
    (x) => x + 1,
  ).take(20);

  // Lang nghe
  stream.listen(
    (x) => print('Nghe duoc so: ${x * 5} - dang chay tron'),
    onDone: () => print('Bat dau di tim!'),
    onError: (loi) => print('Co van de, ngung cuoc choi ($loi)'),
  );
}

void streamController() {
  print('Vi du 2: Stream Controller ===');
  // tao bo dieu khien stream
  StreamController<String> controller = StreamController<String>();

  // lang gnhe stream
  controller.stream.listen(
    (tinNhan) => print('Tin nhan moi: $tinNhan'),
    onDone: () => print('Khong con tin nhan nao nua'),
  );

  // gui tin nhan vao stream
  print('Dang gui tin nhan dau tien...');
  controller.add('Xin chao!');

  // gui tin nhan sau 2 giay
  Future.delayed(Duration(seconds: 2), () {
    print('Dang gui tin nhan thu 2...');
    controller.add('Ban khoe khong?');
  });

  // gui tin nhan cuoi va dong stream sau 4 giay
  Future.delayed(Duration(seconds: 2), () {
    print('Dang gui tin nhan cuoi...');
    controller.add('Tam biet!');
    controller.close();
  });
}

void main() {
  // demSo();
  streamController();
}
