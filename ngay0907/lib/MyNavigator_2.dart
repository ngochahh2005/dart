import 'package:flutter/material.dart';

/*
  2. NHẬN KẾT QUẢ TRẢ VỀ (RETURN DATA)
  Khi bạn mở một màn hình mới để chọn thứ gì đó (ví dụ: chọn ngôn ngữ)
  và muốn nhận dữ liệu khi đóng màn hình đó, bạn dùng async/await.
 */

// Màn hình 1 - Chờ kết quả
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Doi ket qua tra ve tu man 2
                final res = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Bạn đã chọn: $res')));
              },
              child: Text('Chọn màu sắc'),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình 2 - Trả kết quả
class SecondPage extends StatelessWidget {
  SecondPage({super.key});
  final List<String> colors = ['Đỏ', 'Xanh', 'Vàng', 'Tím', 'Cam'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chọn màu'),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: ListView.builder(
        itemCount: colors.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(colors[index]),
              onTap: () {
                Navigator.pop(context, colors[index]);
              },
            );
          }
      )
    );
  }
}
