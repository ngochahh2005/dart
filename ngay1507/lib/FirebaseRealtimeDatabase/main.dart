/*
  1. Khái niệm
  - Realtime Database là cơ sở dữ liệu NoSQL dạng JSON, lưu trữ trên cloud của Google.
  - Dữ liệu được đồng bộ thời gian thực tới tất cả client đang kết nối.
  - Hoạt động dựa trên cơ chế WebSocket, đảm bảo độ trễ thấp, phù hợp cho chat.
  - Tất cả dữ liệu được tổ chức dưới dạng cây JSON (JSON tree), không có bảng hay record như SQL.

  2. Đặc điểm nổi bật
  - Real-time sync: Dữ liệu đồng bộ tự động tới mọi client khi có thay đổi
  - Offline support: Tự động lưu hàng đợi ghi khi mất mạng, đồng bộ lại khi có kết nối
  - Low latency: Phù hợp cho ứng dụng chat, game, bảng điều khiển
  - JSON tree: Dữ liệu được tổ chức dạng cây, dễ truy xuất theo đường dẫn
  - Security Rules: Kiểm soát truy cập bằng ngôn ngữ khai báo giống JavaScript

  3. Cấu hình và Sử dụng (Flutter)
  - Thêm dependency:
    dependencies:
      firebase_core: ^2.24.0
      firebase_database: ^10.5.0
      firebase_auth: ^4.17.0
  - Khởi tạo Firebase: await Firebase.initializeApp().
  - Tạo instance database: FirebaseDatabase.instance.
  - Lấy instance: FirebaseDatabase.instance.ref().

  4. Thao tác CRUD trên Realtime Database
 */

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ngay1507/firebase_options.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/services/auth_service.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/view/chat_list_screen.dart';
import 'package:ngay1507/FirebaseRealtimeDatabase/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // bat luu tru offline (chi can goi 1 lan)
  FirebaseDatabase.instance.setPersistenceEnabled(true);
  // giu dong bo giu lieu quan trong (neu can)
  FirebaseDatabase.instance.ref('users').keepSynced(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 18,
            color: Colors.lightGreen[900],
            fontFamily: 'k2d',
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            color: Colors.lightGreen[900],
            fontFamily: 'k2d',
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24)),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(
            color: Colors.lightGreen[900],
            fontSize: 18,
            fontFamily: 'k2d',
            fontWeight: FontWeight.bold,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.lightGreen, width: 3),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide(color: Colors.lightGreen, width: 2),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          prefixIconColor: Color(0xffe487aa),
          suffixIconColor: Color(0xffae6883),
          hintStyle: TextStyle(
            color: Colors.lightGreen[400],
            fontSize: 18,
            fontFamily: 'k2d',
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      home: StreamBuilder(
        stream: AuthService().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return ChatListScreen();
          }
          return const LoginScreen();
        },
      ),
    );
  }
}
