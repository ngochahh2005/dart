import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyExpanded extends StatelessWidget {
  const MyExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App ve widget'),
        backgroundColor: Colors.lightGreen,
        elevation: 4,
        actions: [
          IconButton(
            onPressed: () {
              print('b1');
            },
            icon: Icon(Icons.search),
          ),

          IconButton(
            onPressed: () {
              print('b2');
            },
            icon: Icon(Icons.abc),
          ),

          IconButton(
            onPressed: () {
              print('b3');
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 16),

        /// Được sử dụng bên trong Row hoặc Column
        /// buộc widget con mở rộng ra chiếm toàn bộ không gian trống còn lại trên trục chính.
        // Khong co Expanded
        // child: Row(
        // children: [
        //   Container(width:100, color: Colors.lightBlueAccent,),
        //   Container(width:100, color: Colors.amberAccent),
        // ],

        // co Expanded
        // Container thứ hai sẽ chiếm toàn bộ phần còn lại.
        // child: Row(
        //   children: [
        //     Container(width: 100, color: Colors.lightBlueAccent),
        //     Expanded(child: Container(color: Colors.amberAccent)),
        //   ],
        // ),

        /// Thuộc tính: flex (tỉ lệ phân bổ không gian, mặc định là 1).
        /// Tỉ lệ màu trong ví dụ: xanh chiếm 3 phần - Vàng chiếm 1 phần
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(color: Colors.green,)
            ),

            Expanded(
              flex: 1,
              child: Container(color: Colors.yellowAccent,)
            )
          ],
        ),
      ),
    );
  }
}
