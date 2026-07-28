import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // lay id duoc truyen sang tu ham dieu huong
    final String? id = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Screen'),),
      body: Center(child: Text('Day la man hinh chi tiet cua id: $id'),),
    );
  }
}