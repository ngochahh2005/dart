import 'package:flutter/material.dart';
import 'MyGetX.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      // Route (Điều hướng - "Nơi áp dụng")
      // Tại đây, bạn gắn Binding vào GetPage. Khi người dùng điều hướng tới trang /products,
      // GetX sẽ tự động chạy ProductBinding để "inject" controller vào bộ nhớ.
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => HomeView()
        ),
        GetPage(
          name: '/products',
          page: () => ProductView(),
          binding: ProductBinding(), // Binding duoc dung o day
        ),
      ],
    );
  }
}
