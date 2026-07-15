import 'package:flutter/material.dart';
import 'package:ngay1407/baitap/bai_1/model/Task.dart';

class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final task = args != null ? (args as Task) : Task(name: '', isCompleted: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết công việc'),
        backgroundColor: Colors.lime,
      ),
      body: Center(
        child: Column(
          spacing: 24,
          children: [
            Row(
              spacing: 8,
              children: [
                Text(task.name, style: TextStyle(fontSize: 24),),

                if (task.isCompleted) const Icon(Icons.check_circle, color: Colors.lightGreen,)
              ],
            ),
            Text(task.detail ?? '', style: TextStyle(fontSize: 18),)
          ],
        ),
      ),
    );
  }
}