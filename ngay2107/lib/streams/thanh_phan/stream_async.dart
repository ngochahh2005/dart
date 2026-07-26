// Tạo Stream bằng async* (Generator)
// Ngoài StreamController, bạn có thể tạo Stream bằng hàm async* với từ khóa yield

// Ham nay tra ve 1 Stream phat ra so tu 1 -> 5, moi giay 1 so
Stream<int> createNumberStream() async* {
  for (int i = 1; i <= 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;  // yield la "gui" du lieu ra ngoai, giong sink.add
  }
}

// Su dung: createNumber().listen((num) => print(num));