import 'package:flutter/material.dart';

class MyAssetsImage extends StatelessWidget {
  const MyAssetsImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets Image'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Image.asset(
          'assets/images/loading_img.jpg',
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}