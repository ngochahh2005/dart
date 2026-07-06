import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget{
  const MyScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // Tra ve Scaffold - widget cung cap bo cuc Material design co ban
    // La 1 cai man hinh
    return Scaffold(
      // Tieu de cua ung dung
      appBar: AppBar(
        title: Text('App ve scaffold'),
      ),

      // Nen cua app
      backgroundColor: Colors.lightBlue,

      body: Center(child: Text('Noi dung chinh')),
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){print('pressed');},
        child: const Icon(Icons.add_ic_call),
      ),

      // Thanh dieu huong phia duoi
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chu'),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Tim kiem'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Ca nhan'),
      ]),
    );
  }
}