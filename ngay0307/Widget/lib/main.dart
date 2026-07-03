import 'package:flutter/material.dart';

void main() {
  // runApp(const MaterialApp(
  //     home: Greeting(name: 'Ha')),
  // );

  // runApp(const MaterialApp(
  //     home: Counter()),
  // );

  runApp(const MaterialApp(
      home: CounterScope(
          cnt: 10,
          child: Counter()
      )
  ));
}

//StatelessWidget: vai trò hiển thị dữ liệu tĩnh (không có khả năng tự thay đổi giao diện - không có setState)
class Greeting extends StatelessWidget {
  final String name;
  const Greeting({super.key, required this.name});
  
  @override
  Widget build(BuildContext context) {
    return Text('Xin chao, $name');
  }
}

/// StatefulWidget: Quản lý dữ liệu thay đổi theo thời gian (_cnt)
/// Quy trình: Khi nhấn nút, setState được gọi --> thông báo cho Flutter _cnt đã thay đổi --> build chạy lại
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _cnt = 0;
  @override
  void initState() {
    super.initState();  // gọi 1 lần duy nhất khi State được gắn vào cây
  }

  @override
  void didUpdateWidget(covariant Counter oldWidget) {
    super.didUpdateWidget(oldWidget);
    // gọi khi widget cha rebuild và tạo Counter widget mới,
    // nhưng Element quyết định giữ lại State cũ này (do canUpdate == true)
  }

  @override
  void dispose() {
    super.dispose();
    // dọn dẹp: huỷ AnimationController, cancel StreamSubscription..
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => setState(() => _cnt++), // yêu cầu rebuild
          child: Text('$_cnt'),
    );
  }
}

//InheritedWidget: vai trò chia sẻ dữ liệu
class CounterScope extends InheritedWidget {
  final int cnt;
  const CounterScope({super.key, required this.cnt, required super.child});

  static int of (BuildContext context) // Cách các Widget con bắt sóng để lấy dữ liệu từ CounterScope mà không cần truyền biến qua từng tầng (constructor)
  => context.dependOnInheritedWidgetOfExactType<CounterScope>()!.cnt;

  @override
  bool updateShouldNotify(CounterScope oldWidget) {   // Bộ lọc. Nếu rebuld CounterScope nhưng biến cnt vẫn là 10 --> các Widget con sẽ không bị bắt buộc build lại
    return oldWidget.cnt != cnt;  //// chỉ notify khi giá trị thật sự đổi
  }
}