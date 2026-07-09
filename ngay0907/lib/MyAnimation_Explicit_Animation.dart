import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
  2. Animation tường minh (Explicit Animation)
  - Kiểm soát chi tiết hơn
  - Cần sử dụng AnimationController và Tween
  - Ví dụ: sử dụng AnimatedBuilder hoặc AnimatedWidget
  - Để tạo animation tường minh, bạn cần:
    + AnimationController - điều khiển thời gian
    + Tween - xác định giá trị đầu và cuối
    + AnimatedBuilder hoặc AnimatedWidget - kết nối animation với widget
 */

class MyAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAnimationState();
}

//SingleTickerProviderStateMixin: cung cấp vsync cho AnimationController
class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  // AnimationController - điều khiển animation
  late AnimationController _controller;

  // Animation - lưu giá trị animation
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // khoi tao controller
    _controller = AnimationController(
      vsync: this,  //// 'this' - phải là một TickerProvider
      duration: Duration(milliseconds: 300),
    );

    // Tween: tu 0 -> pi (180 do)
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: math.pi,
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  void _toggleRotation() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
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
            animation: _rotationAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotationAnimation.value,
                child: Icon(Icons.expand_more, size: 80, color: Colors.blue),
              );
            },
          ),

          ElevatedButton(onPressed: _toggleRotation, child: Text('Rotate'))
        ],
      ),
    );
  }
}
