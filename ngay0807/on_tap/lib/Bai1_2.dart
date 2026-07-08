/*
  Bài 1.2: Hiệu ứng FadeInImage khi tải ảnh mạng (có placeholder)
  Yêu cầu:
  - Sử dụng FadeInImage.network để tải ảnh từ URL https://img.magnific.com/premium-vector/low-poly-initial-letter-logo-design-template-vector-illustration_898869-702.jpg.
  - Trong lúc tải, hiển thị một placeholder là ảnh asset (hoặc một CircularProgressIndicator dạng tĩnh).
  - Có hiệu ứng mờ dần (fade) khi ảnh xuất hiện (mặc định đã có).
  - Thêm xử lý lỗi: nếu tải thất bại, hiển thị một Image.asset fallback (ảnh lỗi).
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bai tap 1.2'),
        backgroundColor: Colors.blue[200],
      ),

      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        itemCount: 100,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(18),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading_img.jpg',
              // image: 'https://img.magnific.com/premium-vector/low-poly-initial-letter-logo-design-template-vector-illustration_898869-702.jpg',
              image: 'https://example.com/anh-khong-ton-tai.jpg',
              fadeInDuration: Duration(milliseconds: 1000),
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/error_img.jpg', fit: BoxFit.cover);
              },
            ),
          );
        },
      ),
    );
  }
}
