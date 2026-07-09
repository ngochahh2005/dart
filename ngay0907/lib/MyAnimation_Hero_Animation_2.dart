import 'package:flutter/material.dart';
import 'dart:math' as math;

class MyAnimation extends StatelessWidget {
  final List<String> imageUrls = [
    'https://loremflickr.com/200/200?lock=1',
    'https://loremflickr.com/200/200?lock=2',
    'https://loremflickr.com/200/200?lock=3',
    'https://loremflickr.com/200/200?lock=4',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DetailScreen(imageUrl: imageUrls[index], index: index),
                ),
              );
            },
            child: Hero(
              tag: 'image-$index',
              child: Image.network(
                imageUrls[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String imageUrl;
  final int index;

  const DetailScreen({required this.imageUrl, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: 'image-$index',
            flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
              // Thêm hiệu ứng fade cho nền khi bay
              return FadeTransition(
                opacity: animation,
                child: fromContext.widget,
              );
            },
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}