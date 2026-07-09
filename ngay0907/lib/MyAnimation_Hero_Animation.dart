import 'package:flutter/material.dart';
import 'dart:math' as math;

/*
  5. Chuyển cảnh mượt mà
  Hero Animation tạo hiệu ứng một widget (gọi là hero)
  "bay" từ màn hình này sang màn hình khác khi điều hướng (Navigator).
  Nó giúp người dùng dễ dàng nhận biết sự liên kết giữa hai màn hình, tăng tính trực quan.
  Cơ chế hoạt động:
  - Khi bạn gọi Navigator.push, Flutter sẽ quét cây widget của cả hai route (màn hình cũ và mới).
  - Nó tìm các cặp Hero có cùng tag.
  - Với mỗi cặp, Flutter sẽ:
    + Lấy vị trí và kích thước của hero trên màn hình cũ (bắt đầu).
    + Lấy vị trí và kích thước của hero trên màn hình mới (đích đến).
    + Tạo một overlay (lớp phủ) chứa hero đang bay, di chuyển từ điểm bắt đầu đến điểm đích
    trong suốt quá trình chuyển cảnh.
    + Trong lúc đó, hero ở màn hình cũ bị ẩn đi, và hero ở màn hình mới được hiện ra
    sau khi animation kết thúc.
 */
class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Màn hình 1"), backgroundColor: Colors.lime),

      body: Center(
        child: GestureDetector(
          onTap: () {
            // Điều hướng sang màn hình 2
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
          child: Hero(
            tag: 'hero-image',  // Tag phải giống nhau ở cả 2 màn hình
            // placeholderBuilder: (context, child) => child,  // Widget hiển thị khi hero chưa xuất hiện
            // Tùy chỉnh widget trong quá trình bay (thay đổi hình dạng, màu sắc...)
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              // Lấy widget gốc từ màn hình nguồn (from) hoặc đích (to)
              final heroChild = direction == HeroFlightDirection.push
                  ? (fromContext.widget as Hero).child
                  : (toContext.widget as Hero).child;

              return AnimatedBuilder(
                animation: animation,
                builder: (context, child) {
                  // Thay đổi kích thước, độ cong, màu sắc theo animation
                  final double progress = animation.value;
                  return Transform.scale(
                    scale: 1.0 + 0.2 * progress, // Phóng to dần
                    child: Container(
                      decoration: BoxDecoration(
                        shape: progress < 0.5 ? BoxShape.circle : BoxShape.rectangle,
                        color: Color.lerp(Colors.red, Colors.blue, progress),
                      ),
                      child: child,
                    ),
                  );
                },
                child: heroChild,
              );
            },
            // Có áp dụng hero khi vuốt back không?
            transitionOnUserGestures: false,
            // Tùy chỉnh đường bay
            // Mặc định, hero bay theo đường thẳng.
            // Bạn có thể tạo đường cong bằng cách override createRectTween.
            createRectTween: (begin, end) {
              return CustomRectTween(begin: begin!, end: end!);
            },
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Center(
                child: Icon(Icons.star, size: 80, color: Colors.yellow),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Màn hình 2'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Hero(
          tag: 'hero-image', // Tag giống với màn hình 1
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 10,
                  blurRadius: 20,
                ),
              ],
            ),
            child: Center(
              child: Icon(Icons.star, size: 160, color: Colors.yellow),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomRectTween extends RectTween {
  CustomRectTween({required Rect begin, required Rect end}) : super(begin: begin, end: end);

  @override
  Rect lerp(double t) {
    // Thay vì lerp tuyến tính, bạn có thể tính toán theo đường cong
    // Ví dụ: bay vòng cung
    final double x = begin!.left + (end!.left - begin!.left) * t;
    final double y = begin!.top + (end!.top - begin!.top) * t - 100 * t * (1 - t); // vòng cung
    final double width = begin!.width + (end!.width - begin!.width) * t;
    final double height = begin!.height + (end!.height - begin!.height) * t;
    return Rect.fromLTWH(x, y, width, height);
  }
}