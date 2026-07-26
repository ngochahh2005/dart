import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ngay2107/firebase_options.dart';
import 'package:ngay2107/on_tap/ui/screens/login_screen.dart';

void main() async {
  // Đảm bảo các binding của Flutter đã được khởi tạo trước khi gọi Native code
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'k2d'
      ),
      home: LoginScreen(),
    );
  }
}