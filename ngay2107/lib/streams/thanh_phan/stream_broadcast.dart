// tao broadcast controller
import 'dart:async';
// Stream Broadcast (Nhiều người nghe)

final StreamController<String> broadcastConstroller = StreamController<String>.broadcast();

void broadcastExample() {
  // nguoi nghe A
  broadcastConstroller.stream.listen((data) => print('A nhan: $data'));
  // nguoi nghe B
  broadcastConstroller.stream.listen((data) => print('B nhan: $data'));

  broadcastConstroller.sink.add('Hello ca nha!');
  // output: ca A va B deu nhan duoc
}