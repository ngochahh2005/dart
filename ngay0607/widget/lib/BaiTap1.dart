import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
    Bài tập: Xây dựng Form "Chào hỏi người dùng"
    Yêu cầu:
    1. Tạo một TextField để người dùng nhập tên.
    2. Một nút ElevatedButton để xác nhận.
    3. Khi nhấn nút, hiển thị tên vừa nhập vào một widget Text bên dưới.
    4. Xóa sạch nội dung trong TextField sau khi nhấn nút.
 */

class BaiTap1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BaiTap1State();
}

class _BaiTap1State extends State<BaiTap1> {
  final _textController = TextEditingController();
  String _inputText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text('Appbar bai tap 1'),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Ten nguoi dung',
                hintText: 'Hay nhap ten nguoi dung cua ban',
                border: OutlineInputBorder(),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                setState(() {
                  _inputText = _textController.text;
                  _textController.clear();
                });
              },
              child: Text('Xac nhan'),
            ),

            Text('Ten la: $_inputText'),
          ],
        ),
      ),
    );
  }
}
