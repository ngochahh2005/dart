import 'package:flutter/material.dart';

/// CustomScrollView là một widget rất mạnh mẽ trong Flutter,
/// cho phép bạn kết hợp nhiều loại danh sách khác nhau (gọi là các Slivers) vào trong cùng một vùng cuộn duy nhất.
/// Trong khi ListView hay GridView thông thường giới hạn bạn chỉ được dùng một loại cấu trúc duy nhất,
/// CustomScrollView cho phép bạn "xếp chồng" các thành phần này lại với nhau để tạo ra các giao diện phức tạp,
/// ví dụ như trang cá nhân có ảnh bìa cuộn theo danh sách.

class MyListGridView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyListGridViewState();
}

class _MyListGridViewState extends State<MyListGridView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List - Grid view'),
        backgroundColor: Colors.lime[300],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Text('Tieu de', style: TextStyle(fontSize: 24)),
            ]),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Container(color: Colors.red),
              childCount: 10,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10
            ),
          ),
        ],
      ),
    );
  }
}
