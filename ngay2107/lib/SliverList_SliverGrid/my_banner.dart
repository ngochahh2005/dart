import 'package:flutter/material.dart';

// 2.1. SliverToBoxAdapter: Banner quảng cáo

class MyBanner extends StatelessWidget {
  const MyBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Container(
          height: 150.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [Colors.pinkAccent[100]!, Colors.pink[100]!],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              Icon(Icons.whatshot, color: Colors.red,),
              Text(
                'SIÊU SALE 30/4 - 1/5',
                style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold, fontFamily: 'k2d'),
              ),
              Icon(Icons.whatshot, color: Colors.red,),
            ],
          ),
        ),
      ),
    );
  }
}