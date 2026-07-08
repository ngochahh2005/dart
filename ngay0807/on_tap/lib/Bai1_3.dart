/*
  Bài 1.3: Ảnh đại diện (Avatar) với hình tròn và bo góc, kết hợp GestureDetector
  Yêu cầu:
  - Tạo một CircleAvatar với bán kính 60, hiển thị ảnh từ URL (có xử lý lỗi).
  - Nếu ảnh chưa tải xong, hiển thị chữ cái đầu của tên (dùng backgroundImage: NetworkImage và child: Text).
  - Thêm bo góc khác nhau: một ảnh vuông bo tròn (dùng ClipRRect) và một ảnh tròn (dùng CircleAvatar).
  - Bọc trong GestureDetector để bắt sự kiện tap và in ra console.
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bai tap 1.3'),
        backgroundColor: Colors.blue[200],
      ),

      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //Circle avatar
          MyCircleAvatar(),

          //ClipRRect Avatar
          MyClipRRectAvatar()
        ],
      ),
    );
  }
}

class MyClipRRectAvatar extends StatelessWidget {
  const MyClipRRectAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.teal,
          width: 4
        ),
        color: Colors.white
      ),
      child: GestureDetector(
        onTap: () => print('ClipRRect Avatar duoc nhan'),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text('A', style: TextStyle(fontSize: 40, color: Colors.teal),),
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(24),
              child: Image.network(
                  'https://img.magnific.com/hinh-chup-cao-cap/bieu-tuong-cam-xuc-memoji-nguoi-dan-ong-tuoi-cuoi-dep-trai-tren-nen-trang_826801-6987.jpg',
              ),
            )
          ],
        )
      ),
    );
  }
}

class MyCircleAvatar extends StatelessWidget {
  const MyCircleAvatar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => print('Circle avatar da duoc nhan!'),
      child: Container(
        width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.blue,
              width: 4
            ),
            color: Colors.white
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text('A', style: TextStyle(fontSize: 40, color: Colors.blue[900]),),

              ClipOval(
                child: Image.network(
                  'https://img.magnific.com/hinh-chup-cao-cap/bieu-tuong-cam-xuc-memoji-nguoi-dan-ong-tuoi-cuoi-dep-trai-tren-nen-trang_826801-6987.jpg',
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset('assets/images/error_img.jpg');
                  },
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) return SizedBox.shrink();
                    return child;
                  },
                ),
              )
            ],
          )
      )
    );
  }
}
