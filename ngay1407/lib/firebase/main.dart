import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:ngay1407/firebase_options.dart';
import '../firebase/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi tạo Firebase với cấu hình tự động cho nền tảng hiện tại
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(home: TestUploadScreen()));
}

class TestUploadScreen extends StatefulWidget {
  const TestUploadScreen({super.key});

  @override
  _TestUploadScreenState createState() => _TestUploadScreenState();
}

class _TestUploadScreenState extends State<TestUploadScreen> {
  String _message = "Chưa upload";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Firebase Storage")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message, textAlign: TextAlign.center),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                setState(() => _message = "Đang upload...");
                final url = await UploadService().uploadImage();
                setState(() => _message = url != null ? "Thành công: $url" : "Thất bại");
              },
              child: Text("Chọn và Upload ảnh"),
            ),
          ],
        ),
      ),
    );
  }
}