/*
  Bài 1.1: Hiển thị ảnh từ Assets và tối ưu với nhiều mật độ (2x, 3x)
    Yêu cầu:
    - Tạo thư mục assets/images/ và đặt vào đó một file ảnh tên logo.png.
    - Khai báo trong pubspec.yaml để sử dụng asset.
    - Hiển thị ảnh với kích thước 100x100, căn giữa màn hình.
    - Thêm các biến thể 2x, 3x (đặt tên logo.png, logo_2x.png, logo_3x.png hoặc dùng thư mục con 2.0x/, 3.0x/).
    - Sử dụng Image.asset để Flutter tự động chọn ảnh phù hợp với độ phân giải thiết bị.
 */
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bai tap 1.1'),
        backgroundColor: Colors.blue[200],
      ),

      body: Center(
        child: Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}