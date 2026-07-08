/*
  Bài 3.3: Danh sách có phân cách (separator) và nhấn giữ hiển thị dialog
  Yêu cầu: Dùng ListView.separated tạo danh sách 20 item,
  mỗi item là một ListTile với tiêu đề là "Item $index".
  Phân cách là một đường kẻ ngang màu xám.
  Khi nhấn vào item, hiển thị SnackBar thông báo index.
  Khi nhấn giữ (long press), hiển thị AlertDialog hỏi "Bạn có muốn xóa item này không?"
  (không cần xóa thật, chỉ in log).
 */

import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  MyListView({super.key});
  
  final listItem = List.generate(20, (x) => 'Item $x');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bài tập 3.3'),
        backgroundColor: Colors.lightBlueAccent[200],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Bạn đã chọn item $index'))
                );
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Xóa item'),
                      content: Text('Bạn có chắc chắn muốn xóa item này không?'),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Hủy')
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              print('Bạn đã xóa item $index');
                            },
                            child: Text('Xóa')
                        )
                      ],
                    )
                );
              },
              child: ListTile(
                title: Text(listItem[index]),
              ),
            );
          }, 
          separatorBuilder: (context, index) => Divider(color: Colors.grey),
          itemCount: listItem.length
      ),
    );
  }
}