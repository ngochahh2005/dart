/*
  Bài 3.1: Danh sách 100 item với số thứ tự và màu nền xen kẽ
  Yêu cầu: Sử dụng ListView.builder hiển thị 100 item,
  mỗi item là một Container có chiều cao 50,
  màu nền xen kẽ giữa hai màu (ví dụ xanh dương và xanh lá),
  hiển thị số thứ tự ở giữa.
  Khi nhấn vào item, in ra console số thứ tự đã nhấn.
 */

import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  MyListView({super.key});

  final list = List.generate(100, (x) => 'items $x');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập 3.1'),
        backgroundColor: Colors.lightBlueAccent[200],
      ),

      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Expanded(child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => print('Bạn đã nhấn vào items số $index'),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      color: index % 2 == 0 ? Colors.lightBlue : Colors.lime,
                      child: Text(list[index]),
                    )
                  );
                }
            ))
          ],
        ),
      ),
    );
  }
}
