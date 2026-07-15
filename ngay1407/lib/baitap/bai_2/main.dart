/*
  Bài tập 2 (Navigator & Routing):
  Sử dụng Navigator 1.0 để chuyển từ danh sách sang màn hình chi tiết công việc.
  Truyền dữ liệu (object task) qua lại giữa các màn hình bằng RouteSettings.
 */
import 'package:flutter/material.dart';
import '../bai_2/view/TaskScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager Navigator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TaskScreen(),
    );
  }
}
