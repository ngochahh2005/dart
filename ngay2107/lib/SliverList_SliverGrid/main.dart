/*
  Xây dựng một Màn hình Trang chủ Thương mại điện tử (Shopee/Tiki) với bố cục sau:
  1. SliverAppBar: Thanh tìm kiếm + Background hình ảnh (thu nhỏ khi cuộn).
  2. SliverToBoxAdapter: Banner quảng cáo + danh mục hàng ngang (Horizontal ListView).
  3. SliverToBoxAdapter: Tiêu đề "Ưu đãi cho bạn".
  4. SliverList: Danh sách các mã giảm giá (mỗi item là 1 hàng).
  5. SliverToBoxAdapter: Tiêu đề "Gợi ý hôm nay".
  6. SliverGrid: Lưới sản phẩm (2 cột).
 */

import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom scroll view app',
      theme: ThemeData(
        fontFamily: 'k2d',
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}