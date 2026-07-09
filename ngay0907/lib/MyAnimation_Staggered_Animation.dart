import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
  4. Staggered Animation (Animation so le)
  - Staggered animation là kỹ thuật chạy nhiều animation nối tiếp hoặc chồng chéo nhau.
  - Interval cho phép bạn chia nhỏ khoảng thời gian tổng thể của AnimationController (từ 0.0 đến 1.0) thành các phân đoạn nhỏ hơn.
    + 0.0: Là thời điểm bắt đầu (0%).
    + 1.0: Là thời điểm kết thúc (100%).
    + Bằng cách dùng Interval, bạn quyết định khi nào một thuộc tính bắt đầu thay đổi và khi nào nó kết thúc, bất kể AnimationController tổng đang chạy ở đâu.
 */

class MyAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;   // hieu ung lam ro
  late Animation<double> _translateAnimation; // hieu ung dich chuyen
  late Animation<double> _scaleAnimation;     // hieu ung phong to

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    // Animation Opacity: chạy từ 0s đến 1.5s
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    // Animation Dịch chuyển: chạy từ 0.5s đến 2s
    _translateAnimation = Tween<double>(begin: -300, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.17, 0.67, curve: Curves.easeOut),
      ),
    );

    // Animation Scale: chạy từ 1s đến 2.5s
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.33, 0.83, curve: Curves.easeOut),
      ),
    );

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

      body: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(   // widget dieu khien do trong suot cua widget con
                opacity: _opacityAnimation.value,
                child: Transform.translate(   // Dich chuyen vi tri cua widget con
                  // Offset(X, Y): dịch chuyển widget này đi một đoạn là X pixel theo chiều ngang và Y pixel theo chiều dọc
                  offset: Offset(_translateAnimation.value, 0),
                  child: Transform.scale(   // Thay doi kich thuoc hien thi cua Widget con
                    scale: _scaleAnimation.value,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'So le',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
      ),
    );
  }
}
