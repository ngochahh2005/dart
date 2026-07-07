import 'package:flutter/material.dart';

/// ListView là widget hiển thị danh sách các thành phần con theo chiều dọc (hoặc ngang) và hỗ trợ cuộn.
/// Nó tự động quản lý việc hiển thị chỉ các item nằm trong vùng nhìn thấy (lazy loading) để tối ưu hiệu năng.

class MyListView extends StatelessWidget {
  MyListView({super.key});

  final List<String> items = List.generate(100, (i) => 'Item $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List view'),
        backgroundColor: Colors.yellow[200],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Expanded(
            //   //ListView thường (danh sách cố định)
            //   child: ListView(
            //     padding: EdgeInsets.all(8),
            //     children: [
            //       ListTile(title: Text('Item 1')),
            //       ListTile(title: Text('Item 2')),
            //       ListTile(title: Text('Item 3')),
            //       ListTile(title: Text('Item 4')),
            //       ListTile(title: Text('Item 5')),
            //       ListTile(title: Text('Item 6')),
            //       ListTile(title: Text('Item 7')),
            //       ListTile(title: Text('Item 8')),
            //       ListTile(title: Text('Item 9')),
            //       ListTile(title: Text('Item 10')),
            //     ],
            //   ),
            // ),
            //
            // Expanded(
            //   child:
            //       //ListView.builder (dùng 99% thực tế)
            //       ListView.builder(
            //         itemCount: items.length,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             leading: Icon(Icons.label),
            //             title: Text(items[index]),
            //             onTap: () => print('Chon ${items[index]}'),
            //           );
            //         },
            //       ),
            // ),
            //
            // Expanded(
            //   // ListView.separated (có phân cách)
            //   child: ListView.separated(
            //     itemBuilder: (context, index) =>
            //         ListTile(title: Text(items[index])),
            //     separatorBuilder: (context, index) =>
            //         Divider(color: Colors.pinkAccent[200]),
            //     itemCount: items.length,
            //   ),
            // ),
            //
            // Expanded(
            //   //ListView ngang (horizontal)
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     itemCount: 20,
            //     itemBuilder: (context, index) => Container(
            //       width: 100,
            //       margin: EdgeInsets.all(8),
            //       color: Colors.primaries[index % Colors.primaries.length],
            //       child: Center(child: Text('$index')),
            //     ),
            //   ),
            // ),

            //ListView trong Column
            //Khi đặt ListView bên trong Column, cần set shrinkWrap: true và physics: NeverScrollableScrollPhysics() để tránh xung đột cuộn.
            Text('Tieu de'),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),  // Vo hieu hoa cuon rieng
                itemCount: items.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text('Item $index')),
              ),
            ),
            ElevatedButton(onPressed: () {}, child: Text('Nut bam')),
          ],
        ),
      ),
    );
  }
}
