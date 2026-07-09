import 'package:flutter/material.dart';

/*
  1. ĐIỀU HƯỚNG CƠ BẢN (KHÔNG DÙNG TÊN ROUTE)
  Đây là cách căn bản nhất: dùng MaterialPageRoute và constructor của Widget.
 */

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.pinkAccent[75],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // cach 1: push khong co tham so
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );

            // cach 2: Push co tham so (truyen qua constructor)
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const SecondPage(title: 'Title truyen tu man Home -> man 2',)));
          },
          child: Text('Go to Second page'),
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final String? title;

  const SecondPage({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Title mac dinh cua man 2'),
        backgroundColor: Colors.pinkAccent[75],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back'),
        ),
      ),
    );
  }
}
