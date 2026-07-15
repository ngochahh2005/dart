/*
  Bài tập 1 (setState & Adaptive/Responsive):
  - Tạo màn hình danh sách công việc.
  - Sử dụng LayoutBuilder hoặc MediaQuery để thay đổi giao diện: Trên điện thoại hiển thị dạng danh sách, trên máy tính bảng hiển thị dạng lưới (Grid).
  - Sử dụng setState để xử lý trạng thái "hoàn thành" cho một task (checkbox).
 */

import 'package:flutter/material.dart';
import '../model/Task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final tasks = [
    Task(name: 'Mua sắm', isCompleted: false),
    Task(name: 'Học Flutter', isCompleted: true),
    Task(name: 'Đi bộ 30 phút', isCompleted: false),
    Task(name: 'Đọc sách', isCompleted: false),
    Task(name: 'Viết báo cáo', isCompleted: true),
    Task(name: 'Gọi cho mẹ', isCompleted: false),
    Task(name: 'Dọn dẹp nhà cửa', isCompleted: false),
    Task(name: 'Tập yoga', isCompleted: true),
  ];

  void _toggleCompletion(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách công việc'),
        backgroundColor: Colors.lime,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isTablet = constraints.maxWidth >= 600;

          if (isTablet) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                return _buildTaskCard(index);
              },
              itemCount: tasks.length,
            );
          } else {
            return ListView.builder(
              itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return _buildTaskCard(index);
                }
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskCard(int index) {
    final task = tasks[index];
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (context) => _toggleCompletion(index),
              activeColor: Colors.lime,
            ),
            Expanded(
              child: Text(
                task.name,
                style: TextStyle(
                  fontSize: 18,
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  color: task.isCompleted ? Colors.grey : Colors.black87,
                ),
              ),
            ),

            if (task.isCompleted)
              const Icon(
                Icons.check_circle,
                color: Colors.lightGreen,
                size: 28,
              ),
          ],
        ),
      ),
    );
  }
}
