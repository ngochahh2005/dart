import 'package:flutter/material.dart';

/*
  3. ĐIỀU HƯỚNG CÓ TÊN (NAMED ROUTES)
  Khi ứng dụng phức tạp, việc khai báo sẵn danh sách route trong MaterialApp giúp quản lý tập trung.
 */

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page 3'),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final res = await Navigator.pushNamed(
                  context,
                  '/second',
                  arguments: 'Tham so duoc truyen tu man home -> man 2',
                );

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Bạn đã chọn: $res')));
              },
              child: Text('go to second page'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  SecondPage({super.key});

  final List<String> colors = ['Đỏ', 'Xanh', 'Vàng', 'Tím', 'Cam'];

  @override
  Widget build(BuildContext context) {
    // Lấy arguments\
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final data = args != null ? (args as String) : 'Khong co du lieu';

    return Scaffold(
      appBar: AppBar(
        title: Text('Second page'),
        backgroundColor: Colors.pinkAccent[100],
      ),
      body: Text('Tham so nhan duoc tu man hinh home: $data'),
    );
  }
}
