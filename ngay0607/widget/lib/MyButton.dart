import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({super.key});

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
          SizedBox(height: 50),

          /// ElevatedButton la 1 button noi voi hieu ung do bong
          /// Thuong duoc sd cho cac hanh dong chinh trong ung dung
          ElevatedButton(
            onPressed: (){
              print('elevated button');
            } ,
            child: Text('Elevated Button', style: TextStyle(fontSize: 24),)
          ),

          SizedBox(height: 20),

          /// TextButton la 1 button phang, khong co do bong
          /// thuong dung cho cac hanh dong thu yeu hoac trong cac thanh phan nhu Dialog, Card
          TextButton(
            onPressed: (){},
            child: Text('Text Button', style: TextStyle(fontSize: 24),)
          ),

          SizedBox(height: 20),

          /// OutlinedButton la button co vien bao quanh, khong co mau nen
          /// phu hop cho cac thay the
          OutlinedButton(
            onPressed: (){},
            child: Text('Outlined Button', style: TextStyle(fontSize: 24),)
          ),

          SizedBox(height: 20),

          /// IconButton la button chi gom icon, khong co van ban
          /// thuong dung trong Appbar, Toolbar
          IconButton(
            onPressed: (){},
            icon: Icon(Icons.favorite)
          ),

          SizedBox(height: 20),

          /// FLoatingActionButton la button hinh tron, noi tren giao dien
          /// thuogn dung cho cac hanh dong chinh cua man hinh
          FloatingActionButton(
            onPressed: (){},
            child: Icon(Icons.add),
          ),
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
