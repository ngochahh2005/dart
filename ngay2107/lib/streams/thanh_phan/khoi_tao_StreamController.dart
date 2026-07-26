import 'dart:async';

// Khởi tạo StreamController cơ bản
// khoi tao controller (mac dinh la single-subscription)
final StreamController<int> counterController = StreamController<int>();

// lay sink de them du lieu vao
StreamSink<int> get _sink => counterController.sink;

// lay stream de lang nghe
Stream<int> get stream => counterController.stream;

// them du lieu
void incrementCounter() {
  _sink.add(1); // them 1 vao luong
}

// dong khi khong dung nua
void dispose() {
  counterController.close();
}