/*
  Bài 3.2: GridView hiển thị ảnh từ mạng
  Yêu cầu: Tạo một GridView.builder với số cột là 3,
  khoảng cách giữa các ảnh là 4px.
  Mỗi ô là một ảnh từ https://loremflickr.com/200/200?lock=$id
  (thay $index bằng số thứ tự), với fit: BoxFit.cover.
  Có 50 ảnh. Khi nhấn vào ảnh, in ra index.
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyGridView extends StatelessWidget {
  const MyGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập 3.2'),
        backgroundColor: Colors.lightBlueAccent[200],
      ),

      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(4),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  childAspectRatio: 1
              ),
              itemCount: 50,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => print('Bạn đã chọn ảnh $index'),
                  child: CachedNetworkImage(
                    imageUrl: 'https://loremflickr.com/200/200?lock=$index',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset('assets/images/loading_img.jpg'),
                  )
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
