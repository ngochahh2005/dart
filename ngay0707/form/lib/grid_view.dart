import 'package:flutter/material.dart';

///GridView hiển thị danh sách dưới dạng lưới (nhiều cột), thường dùng cho ảnh, sản phẩm, icon, v.v.
///Cũng hỗ trợ lazy loading tương tự ListView.

class MyGridView extends StatelessWidget {
  MyGridView({super.key});

  final List<String> _items = List.generate(50, (i) => 'Image $i');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grid view'),
        backgroundColor: Colors.yellow[200],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          children: [
            // Chỉ định số cột cố định
            // MyGridViewCount(),
            SizedBox(height: 20),

            // Chỉ định chiều rộng tối đa mỗi item, tự động tính số cột phù hợp
            // MyGridViewExtent(),
            SizedBox(height: 20),

            // Tạo item động với itemBuilder, cần chỉ định gridDelegate
            MyGridViewBuilder(items: _items),
          ],
        ),
      ),
    );
  }
}

class MyGridViewBuilder extends StatelessWidget {
  const MyGridViewBuilder({
    super.key,
    required this._items,
  });

  final List<String> _items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        //Xac dinh so luong cot trong luoi (VD: 2)
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.75,
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          Color backgroundColor = Colors.primaries[index % Colors.primaries.length];
          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                _items[index],
                style: TextStyle(color: backgroundColor.invert()),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MyGridViewExtent extends StatelessWidget {
  const MyGridViewExtent({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.extent(
        maxCrossAxisExtent: 300,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        // childAspectRatio: 0.8,
        children: [
          _MyContainer(color: Colors.blue),
          _MyContainer(color: Colors.blue),
          _MyContainer(color: Colors.blue),
          _MyContainer(color: Colors.blue),
          _MyContainer(color: Colors.blue),
        ],
      ),
    );
  }
}

class MyGridViewCount extends StatelessWidget {
  const MyGridViewCount({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        // so cot
        crossAxisSpacing: 20,
        // khoang cach giua cac cot
        mainAxisSpacing: 20,
        // khoang cach giua cac hang
        childAspectRatio: 0.8,
        // ti le chieu cao/chieu rong (1 = vuong)
        children: [
          _MyContainer(),
          _MyContainer(),
          _MyContainer(),
          _MyContainer(),
        ],
      ),
    );
  }
}

class _MyContainer extends StatelessWidget {
  final Color color;

  const _MyContainer({super.key, this.color = Colors.lightGreen});

  @override
  Widget build(BuildContext context) {
    return Container(color: color);
  }
}

extension ColorInvert on Color {
  Color invert() {
    return Color.fromARGB(alpha, 255 - red, 255 - green, 255 - blue);
  }
}
