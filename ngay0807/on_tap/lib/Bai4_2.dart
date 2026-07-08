/*
  Bài 4.2: Form cập nhật ảnh đại diện với xem trước
  Yêu cầu:
  - Tạo một form có trường nhập URL ảnh, nút "Tải ảnh" và một vòng tròn hiển thị ảnh đại diện.
  - Khi nhấn nút, ảnh từ URL sẽ được tải và hiển thị trong CircleAvatar.
  - Sử dụng TextEditingController để lấy URL.
  - Thêm chức năng "Xóa ảnh" (đặt lại avatar về mặc định).
  - Xử lý lỗi khi URL không hợp lệ (hiển thị thông báo).
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadAvatar extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  File? _image;
  final _urlController = TextEditingController();
  final _keyForm = GlobalKey<FormState>();

  Future<void> _uploadImage() async {
    final pikedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pikedImage != null) {
      setState(() {
        _image = File(pikedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product manager app',
          style: TextStyle(
            fontSize: 36,
            color: Colors.lightGreen[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen[100],
      ),

      body: Form(
        key: _keyForm,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.lime, width: 4),
              ),
              child: ClipOval(
                child: _image != null
                    ? Image.file(_image!, fit: BoxFit.cover, height: 200, width: 200,)
                    : Image.asset('assets/images/loading_img.jpg', fit: BoxFit.cover, height: 200, width: 200,),
              ),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload image'),
            ),

            ElevatedButton(onPressed: () {
              setState(() {
                _image = null;
              });
            }, child: Text('Delete avatar'))
          ],
        ),
      ),
    );
  }
}
