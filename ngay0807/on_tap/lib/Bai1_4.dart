/*
  Bài 1.4: Tối ưu danh sách ảnh – sử dụng CachedNetworkImage
  Yêu cầu:
  - Thêm package cached_network_image vào project.
  - Tạo một ListView.builder hiển thị 50 ảnh từ https://media-cdn-v2.laodong.vn/storage/newsportal/2024/8/22/1383302/Canhdep_Vietnam-1.jpg.
  - Sử dụng CachedNetworkImage thay vì Image.network để cache ảnh, tránh tải lại khi cuộn.
  - Hiển thị CircularProgressIndicator trong lúc tải và một icon lỗi nếu thất bại.
  - Kết hợp với GridView để hiển thị dạng lưới với 3 cột.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  const MyImage({super.key});

  final _imgUrl =
      'https://media-cdn-v2.laodong.vn/storage/newsportal/2024/8/22/1383302/Canhdep_Vietnam-1.jpg';

  @override
  Widget build(BuildContext context) {
    CachedNetworkImage.evictFromCache(_imgUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text('Bai tap 1.4'),
        backgroundColor: Colors.blue[200],
      ),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: _imgUrl,
                  // height: 120,
                  // width: 120,
                  httpHeaders: const {
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
                  },
                  fadeInDuration: Duration(milliseconds: 500),
                  // placeholder: (context, url) => Image.asset('assets/images/loading_img.jpg'),
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
