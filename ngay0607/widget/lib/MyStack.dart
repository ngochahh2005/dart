import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStack extends StatelessWidget {
  const MyStack({super.key});
  
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
        /// Cho phép các Widget con chồng lên nhau
        /// Khác Container vì Container chỉ có 1 widget con (không có thuộc tính children) --> không thể cho các widget con chồng lên nhau
        child: Stack(
          children: [
            Container(color: Colors.amberAccent, width: 100, height: 100,),
            ///Khi bạn đặt một widget vào trong Stack, mặc định nó sẽ nằm ở góc trên bên trái ($x=0, y=0$).
            ///Positioned giúp bạn "bóc tách" widget đó ra khỏi luồng sắp xếp mặc định và đặt nó vào bất kỳ vị trí nào bạn muốn dựa trên các cạnh của Stack cha.
            Positioned(
              top: 50,  //Khoảng cách từ cạnh trên của Stack đến cạnh trên của widget
              left: 30, //Khoảng cách từ cạnh trái của Stack đến cạnh trái của widget
              child: Text('Nam tren cung'),
            ),
          ],
        ),
      ),
    );
  }
}