/*
  5.2. Xử lý theo lô (Batch)
  - Khái niệm:
    Batch cho phép gom nhiều thao tác lại và gửi chúng trong một lần gọi đến native code,
    giúp giảm số lần truyền thông qua method channel giữa Dart và nền tảng, từ đó cải thiện
    hiệu năng đáng kể khi có nhiều câu lệnh.
  - Đặc điểm:
    + Các thao tác trong batch được thực thi theo thứ tự.
    + Mặc định, nếu một thao tác thất bại, batch sẽ dừng lại và không commit các thao tác trước đó.
      Bạn có thể thay đổi hành vi này với tham số continueOnError.
    + Bạn có thể yêu cầu trả về kết quả từng thao tác (mặc định) hoặc bỏ qua kết quả (noResult: true) để tăng tốc.
 */

// Ví dụ chi tiết: Đồng bộ danh sách công việc (Task Sync)
// Giả sử bạn nhận được danh sách 500 công việc từ API và cần lưu vào cơ sở dữ liệu.
// Sử dụng batch sẽ giúp giảm đáng kể số lần truyền dữ liệu giữa Flutter và SQLite.

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// dinh nghia 1 Model Task don gian
class Task {
  final int id;
  final String title;

  Task(this.id, this.title);

  Map<String, Object?> toMap() => {'id': id, 'title': title};
}

// class helper quan ly database va batch
class TaskDatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'tasks_app.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT)');
    });
  }

  // Phuong thuc dong bo su dung Batch
  Future<void> syncTasksFromServer(List<Task> remoteTasks) async {
    Database db = await database;
    // khoi tao batch tu doi tuong database
    final batch = db.batch();

    // gom tat ca cac lenh insert vao batch
    for (var task in remoteTasks) {
      batch.insert(
          'tasks',
          task.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace
      );
    }

    // thuc thi batch
    try {
      // noResult: true giúp tăng tốc vì không cần nhận lại ID
      // continueOnError: false giúp đảm bảo toàn vẹn: nếu lỗi, dừng batch
      final res = await batch.commit(continueOnError: false, noResult: true);
      print('Da chen thanh cong ${remoteTasks.length} task.');
    } catch (e) {
      print('Dong bo that bai: Khong co task nao duoc luu do loi xay ra');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: BatchTestScreen()));
}

class BatchTestScreen extends StatefulWidget {
  @override
  _BatchTestScreenState createState() => _BatchTestScreenState();
}

class _BatchTestScreenState extends State<BatchTestScreen> {
  String status = "Đang chạy đồng bộ...";

  @override
  void initState() {
    super.initState();
    runSync();
  }

  Future<void> runSync() async {
    final helper = TaskDatabaseHelper();
    List<Task> serverTasks = [
      Task(1, 'Học Flutter'),
      Task(2, 'Tìm hiểu Batch SQLite'),
      Task(3, 'Tối ưu hóa Database'),
    ];

    await helper.syncTasksFromServer(serverTasks);

    // CẬP NHẬT GIAO DIỆN Ở ĐÂY
    setState(() {
      status = "Đã hoàn thành! Kiểm tra Console để xem chi tiết.";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Batch Test")),
      body: Center(child: Text(status)),
    );
  }
}