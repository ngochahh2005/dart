import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  const MyText({super.key});

  @override
  Widget build(BuildContext context) {
    // Tra ve Scaffold - widget cung cap bo cuc Material design co ban
    // La 1 cai man hinh
    return Scaffold(
      // Tieu de cua ung dung
      appBar: AppBar(
        // tieu de
        title: Text('App ve scaffold'),
        // nen cua appbar
        backgroundColor: Colors.lightGreen,
        // do nang/do bong cua appbar
        elevation: 4,
        // cac nut nhan
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

      body: Center(child: Column(
        children: [
          // Tao 1 khoang cach (tuong tu Spacer trong Kotlin)
          const SizedBox(height: 50,),
          const Text('Nguyen Van A'),
          const SizedBox(height: 20,),

          const Text(
            'Xin chao cac ban dang hoc lap trinh Flutter',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent
            ),
          ),

          const SizedBox(height: 20,),
          const Text(
            'Container là một widget có dạng hình hộp, có thể được tạo hình, tô màu và thay đổi kích thước theo nhu cầu của bạn. Trong phần này, bạn sẽ học cách sử dụng widget Container, tạo kiểu cho nó, thêm viền, khoảng đệm (padding), lề (margin) và màu nền.',
            textAlign: TextAlign.left,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: Colors.deepPurple,
              letterSpacing: 1.5
            ),
          )
        ]
      )),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
        },
        child: const Icon(Icons.add_ic_call),
      ),

      // Thanh dieu huong phia duoi
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chu'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tim kiem'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Ca nhan'),
        ],
      ),
    );
  }
}
