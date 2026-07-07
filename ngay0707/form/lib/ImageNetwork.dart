import 'package:flutter/material.dart';

class MyImageNetWork extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyImageState();
}

class _MyImageState extends State<MyImageNetWork> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Tai anh tu URL
          Image.network(
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxw9Ki8Py7UdhrlUkg58-eQVOU6H9EZpWh15rQYXWQkCA2Cj1jC9wJ5Js&s=10',
            width: 300,
            height: 300,
            fit: BoxFit.cover,

            // Xu ly loading
            loadingBuilder: (context, child, loadingProgress) {
              // Neu da tai xong -> return
              if (loadingProgress == null) return child;
              // Neu chua tai xong -> hien thanh progress
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded/loadingProgress.expectedTotalBytes! : null,
                ),
              );
            },
          ),

          // Tai anh tu thu muc assets trong project

        ]
      )
    );
  }
}