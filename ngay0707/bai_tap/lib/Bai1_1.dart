import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///BÀI TẬP 1: IMAGE
/// Bài 1.1: Hiển thị ảnh từ mạng có loading và xử lý lỗi
/// Yêu cầu: Tạo một màn hình đơn giản hiển thị ảnh từ URL https://hanoidep.vn/wp-content/uploads/2025/11/anh-avatar-hoa-huong-duong.webp.
/// Trong khi tải, hiển thị một vòng tròn tiến trình.
/// Nếu tải lỗi, hiển thị một biểu tượng lỗi.
/// Ảnh có kích thước 300x300, bo góc và căn giữa màn hình.

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bai 1.1'),
        backgroundColor: Colors.lime,
      ),

      body: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Image.network(
            'https://hanoidep.vn/wp-content/uploads/2025/11/anh-avatar-hoa-huong-duong.webp',
            width: 300,
            height: 300,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              );
            },
            errorBuilder: (context, error, stackStrace) {
              return Icon(Icons.error, size: 50,);
            },
          ),
        ),
      ),
    );
  }
}