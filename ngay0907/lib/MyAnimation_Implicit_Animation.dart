import 'package:flutter/material.dart';

/*
  1. Animation ngầm định (Implicit Animation)
  - Dễ sử dụng nhất, chỉ cần thay đổi giá trị thuộc tính
  - Flutter tự động xử lý quá trình chuyển đổi
  Ví dụ: AnimatedContainer, AnimatedOpacity, AnimatedSize...
 */

class MyAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation> {
  // Khai báo biến state
  final _duration = Duration(seconds: 1);
  Color _color = Colors.blue;
  double _width = 150;
  double _height = 150;
  double _borderRadius = 0;
  double _opacity = 0.25;

  void _updateState() {
    setState(() {
      // Thay đổi ngẫu nhiên các thuộc tính
      _color = _color == Colors.blue ? Colors.red : Colors.blue;
      _width = _width == 150 ? 100 : 150;
      _height = _height == 150 ? 100 : 150;
      _borderRadius = _borderRadius == 0 ? 50 : 0;
      _opacity = _opacity == 0.25 ? 1 : 0.25;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My animation app'),
        backgroundColor: Colors.lightBlueAccent[100],
      ),

      body: Column(
        spacing: 24,
        children: [
          // AnimatedContainer: thay đổi kích thước/màu sắc của Container
          MyAnimatedContainer(
            duration: _duration,
            width: _width,
            height: _height,
            color: _color,
          ),

          // AnimatedOpacity: Mờ dần hoặc hiện rõ
          MyAnimatedOpacity(opacity: _opacity, duration: _duration),

          // AnimatedSize: Thay đổi kích thước
          MyAnimatedSize(duration: _duration, width: _width, height: _height),

          ElevatedButton(onPressed: _updateState, child: Text('Change')),
        ],
      ),
    );
  }
}

class MyAnimatedSize extends StatelessWidget {
  const MyAnimatedSize({
    super.key,
    required this._duration,
    required this._width,
    required this._height,
  });

  final Duration _duration;
  final double _width;
  final double _height;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: _duration,
      curve: Curves.easeInOut,
      child: Container(
        color: Colors.lime,
        width: _width,
        height: _height,
      ),
    );
  }
}

class MyAnimatedOpacity extends StatelessWidget {
  const MyAnimatedOpacity({
    super.key,
    required this._opacity,
    required this._duration,
  });

  final double _opacity;
  final Duration _duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _duration,
      curve: Curves.easeInOut,
      child: Container(color: Colors.black, width: 200, height: 200),
    );
  }
}

class MyAnimatedContainer extends StatelessWidget {
  const MyAnimatedContainer({
    super.key,
    required this._duration,
    required this._width,
    required this._height,
    required this._color,
  });

  final Duration _duration;
  final double _width;
  final double _height;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      /// Đây là cách đơn giản nhất để tạo animation.
      /// Chỉ cần thay đổi thuộc tính của AnimatedContainer trong setState(),
      /// Flutter sẽ tự động tạo hiệu ứng chuyển đổi mượt mà.
      duration: _duration,
      width: _width,
      height: _height,
      color: _color,
      curve: Curves.easeInOut,
      child: Center(
        child: Text(
          'Animated',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
