import 'package:flutter/material.dart';

// 1. SliverAppBar: Thanh tìm kiếm + Background hình ảnh (thu nhỏ khi cuộn).

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 150,
      pinned: true,
      // neu true: thanh UD dinh co dinh tren cung MH khi user cuon xuong
      snap: false,
      // chi hd khi floating: true. Neu la true -> thanh UD tu dong MR toan bo/an di ma khong bi lung lo khi user tha tay
      floating: false,
      // neu true: thanh UD ngay lap tuc hien lai khi user cuon nhe len tren
      backgroundColor: Color(0xffea7ba1),
      title: Text(
        'Shop Online',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 36,
          color: Colors.lightGreen,
          fontFamily: 'k2d',
        ),
      ),
      centerTitle: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset('assets/images/img.png', fit: BoxFit.fill),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search, size: 36),
          color: Colors.lightGreen,
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_active_outlined, size: 36),
          color: Colors.lightGreen,
        ),
      ],
    );
  }
}
