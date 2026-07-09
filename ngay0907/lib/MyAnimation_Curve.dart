import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
  3. Animation với Curve
  Curve giúp animation trở nên tự nhiên hơn bằng cách thay đổi tốc độ trong suốt quá trình
  Các Curve phổ biến:
  - Curves.linear: tốc độ đều
  - Curves.easeIn: chậm ở đầu, nhanh ở cuối
  - Curves.easeOut: nhanh ở đầu, chậm ở cuối
  - Curves.easeInOut: chậm ở đầu và cuối
  - Curves.bounceOut: nảy ở cuối
  - Curves.elasticOut: co giãn ở cuối
 */

// Thay đổi kích thước của một hình vuông với hiệu ứng "nảy" ở cuối.
class MyAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    // Sử dụng CurvedAnimation để tạo hiệu ứng cong
    final curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _animation = Tween<double>(begin: 50, end: 200).animate(curvedAnimation);

    _controller.forward(); // Tu dong chay animation
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: _animation.value,
                height: _animation.value,
                color: Colors.orange,
                child: Center(
                  child: Text(
                    '${_animation.value.toInt()}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
