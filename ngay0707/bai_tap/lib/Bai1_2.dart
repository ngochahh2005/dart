import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

///Bài 1.2: Chọn ảnh từ thư viện và hiển thị
/// Yêu cầu: Tạo màn hình có một nút "Chọn ảnh".
/// Khi nhấn, mở thư viện ảnh (dùng image_picker) và
/// hiển thị ảnh đã chọn lên màn hình (kích thước 200x200, bo tròn).
/// Nếu chưa chọn ảnh, hiển thị một hình nền xám với biểu tượng máy ảnh.

class MyImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyImageState();
}

class _MyImageState extends State<MyImage> {
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bai 1.2'), backgroundColor: Colors.lime),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: _pickImage, child: Text('Chon anh')),
            _image != null
                ? Image.file(
                    _image!,
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
              width: 200,
              height: 200,
              color: Colors.grey,
              child: Icon(Icons.camera_alt_outlined, color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
