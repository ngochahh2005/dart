import 'package:flutter/material.dart';

class MyButton_InkWell extends StatelessWidget {
  const MyButton_InkWell({super.key});

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

      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50,),

            ElevatedButton(
              onPressed: null,    // vo hieu hoa nut nhan
              child: Text('Elevated Button', style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                // mau nen
                backgroundColor: Colors.amber,

                // mau cua cac noi dung ben trong
                foregroundColor: Colors.green,

                // bo goc button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(10)
                ),

                // padding - khoang cach body so voi le
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15
                ),

                // elevate - do bong
                elevation: 15,
              ),
            ),

            SizedBox(height: 50,),

            /// InkWell
            /// InkWell lhong phai la button
            /// nhung no cho phep tao hieu ung gon song (ripple effect)
            /// khi nhan vao bat ky widget nao
            InkWell(
              onTap: () {
                print('InkWell duoc nhan');
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.lightBlueAccent)
                ),
                child: Text('Button tuy chinh voi InkWell'),
              ),
            )
          ],
        ),
      ),

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
