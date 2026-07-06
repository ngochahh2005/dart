import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyConstrainedBox extends StatelessWidget {
  const MyConstrainedBox({super.key});

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

        /// Dùng để áp đặt các ràng buộc (constraints) về kích thước tối thiểu hoặc tối đa lên widget con.
        /// Thuộc tính: constraints (sử dụng BoxConstraints để set minWidth, maxWidth, minHeight, maxHeight).
        child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 80,
              minHeight: 50,
              maxWidth: 200,
              maxHeight: 200
            ),
          child: Container(
            color: Colors.lightBlueAccent,
            child: Text('Nut bam', style: TextStyle(fontSize: 24),),
          ),
        )
      ),
    );
  }
}
