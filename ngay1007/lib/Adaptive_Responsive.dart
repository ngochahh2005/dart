import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePage();
}

/*
  1. Các công cụ chính để xây dựng Responsive & Adaptive UI
 */

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // 1.1. MediaQuery – Lấy thông tin màn hình
    // MediaQuery cung cấp kích thước, hướng, padding, tỷ lệ… của toàn bộ màn hình.

    // lay kich thuoc man hinh
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    // lay huong man hinh
    final orientation = MediaQuery.of(context).orientation;

    // lay safe area padding
    final padding = MediaQuery.of(context).padding;

    // return Scaffold(
    //   body: Padding(
    //     padding: padding,
    //     child: Container(
    //       width: width,
    //       height: height,
    //       color: Colors.lime,
    //     ),
    //   ),
    // );

    // 1.2. LayoutBuilder – Lấy constraints của widget cha
    // LayoutBuilder cung cấp kích thước thực tế mà widget cha cấp phát cho widget con.
    // Khác với MediaQuery (lấy toàn bộ màn hình), LayoutBuilder cho biết chính xác không gian dành riêng cho widget đó.
    // return LayoutBuilder(
    //   builder: (context, constraint) {
    //     // constraints.maxWidth: chiều rộng tối đa được cấp
    //     // constraints.maxHeight: chiều cao tối đa được cấp
    //     // constraints.minWidth, constraints.minHeight
    //
    //     if (constraint.maxWidth > 600) {
    //       return _buildLargeLayout(); // bo cuc cho man hinh lon
    //     } else {
    //       return _buildSmallLayout(); // bo cuc cho man hinh nho
    //     }
    //   },
    // );

    // 1.3. OrientationBuilder – Phản ứng với hướng màn hình
    // OrientationBuilder tự động rebuild khi hướng màn hình thay đổi (portrait ↔ landscape)
    // return OrientationBuilder(
    //   builder: (context, orientation) {
    //     return GridView.count(
    //       crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
    //       children: List.generate(
    //         100,
    //         (index) => Card(child: Text('Item $index')),
    //       ),
    //     );
    //   },
    // );

    // 1.4. FittedBox & AutoSizeText – Tỷ lệ co giãn nội dung
    return Scaffold(
      body: Column(
        children: [
          // FittedBox: co giãn widget con để vừa với không gian
          FittedBox(
            fit: BoxFit.contain,
            child: Image.asset('assets/images/img.png'),
          ),

          // AutoSizeText: tự động điều chỉnh kích thước chữ
          AutoSizeText(
            'Khi nói đến AutoSizeText trong Flutter, thường có hai cách tiếp cận chính: sử dụng thư viện bên ngoài (phổ biến nhất) hoặc sử dụng các widget có sẵn trong SDK của Flutter.',
            maxLines: 3,
            minFontSize: 12,
            maxFontSize: 24,
          )
        ],
      )
    );
  }

  Widget _buildSmallLayout() {
    return Container();
  }

  Widget _buildLargeLayout() {
    return Container();
  }
}
