import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImagePiker extends StatefulWidget {
  const MyImagePiker({super.key});

  @override
  State<StatefulWidget> createState() => _MyImagePikerState();
}

class _MyImagePikerState extends State<MyImagePiker> {
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Picker'), backgroundColor: Colors.teal),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imageFile != null
                ? Image.file(
                    _imageFile!,
                    width: 300,
                    height: 300,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) {
                      return Text('Khong the doc file anh');
                    },
                  )
                : Container(
                    width: 300,
                    height: 300,
                    color: Colors.grey[300],
                    child: Icon(Icons.image, size: 50),
                  ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Chon anh tu thu vien'),
            ),
          ],
        ),
      ),
    );
  }
}
