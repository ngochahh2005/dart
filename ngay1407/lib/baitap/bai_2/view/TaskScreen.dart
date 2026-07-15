/*
  Bài tập 1 (setState & Adaptive/Responsive):
  - Tạo màn hình danh sách công việc.
  - Sử dụng LayoutBuilder hoặc MediaQuery để thay đổi giao diện: Trên điện thoại hiển thị dạng danh sách, trên máy tính bảng hiển thị dạng lưới (Grid).
  - Sử dụng setState để xử lý trạng thái "hoàn thành" cho một task (checkbox).
 */

import 'package:flutter/material.dart';
import 'package:ngay1407/baitap/bai_1/model/Task.dart';

import 'TaskDetailScreen.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final tasks = [
    Task(
      name: 'Mua sắm',
      isCompleted: false,
      detail: 'Mua thực phẩm cho cả tuần và bột giặt',
    ),
    Task(
      name: 'Học Flutter',
      isCompleted: true,
      detail: 'Hoàn thành bài học về State Management',
    ),
    Task(
      name: 'Đi bộ 30 phút',
      isCompleted: false,
      detail: 'Đi bộ tại công viên gần nhà vào lúc 18h',
    ),
    Task(
      name: 'Đọc sách',
      isCompleted: false,
      detail: 'Đọc tiếp chương 4 cuốn "Đắc Nhân Tâm"',
    ),
    Task(
      name: 'Viết báo cáo',
      isCompleted: true,
      detail: 'Gửi báo cáo doanh thu quý 2 cho quản lý',
    ),
    Task(
      name: 'Gọi cho mẹ',
      isCompleted: false,
      detail: 'Hỏi thăm sức khỏe và lịch trình cuối tuần',
    ),
    Task(
      name: 'Dọn dẹp nhà cửa',
      isCompleted: false,
      detail: 'Lau dọn phòng khách và hút bụi phòng ngủ',
    ),
    Task(
      name: 'Tập yoga',
      isCompleted: true,
      detail: 'Thực hiện bài tập giãn cơ 20 phút',
    ),
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
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTaskCard(int index) {
    final task = tasks[index];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TaskDetailScreen(),
            settings: RouteSettings(arguments: task),
          ),
        );
      },
      child: Card(
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
      ),
    );
  }
}
