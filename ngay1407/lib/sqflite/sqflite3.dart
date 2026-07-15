import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*
  5. Các tính năng nâng cao
  5.1. Giao dịch (Transactions)
  - Khái niệm:
    Giao dịch giúp nhóm nhiều thao tác cơ sở dữ liệu thành một khối nguyên tử (atomic). Nghĩa là hoặc tất cả các
    thao tác đều thành công và được lưu (commit), hoặc nếu có bất kỳ lỗi nào, toàn bộ sẽ bị hủy bỏ (rollback).
    Điều này đảm bảo tính toàn vẹn dữ liệu.
  - Nguyên tắc quan trọng:
    Khi ở trong một giao dịch, chỉ sử dụng đối tượng Transaction (thường được đặt tên là txn) để thực hiện các truy vấn,
    không dùng đối tượng Database gốc. Nếu dùng db trong callback, chương trình sẽ bị deadlock vì SQLite không cho phép
    truy cập cùng một kết nối từ nhiều luồng trong khi giao dịch đang mở.
 */

class ProjectDatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database?> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'poject_app.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE projects(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, status TEXT)',
        );
        await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, project_id INTEGER, title TEXT, is_completed INTEGER DEFAULT 0, completed_at INTEGER)',
        );
      },
    );
  }

  Future<void> completeProject(int projectId) async {
    final db = await database;
    try {
      await db.transaction((txn) async {
        // cap nhat cac task thuoc project thanh completed = 1
        await txn.update(
          'tasks',
          {
            'is_completed': 1,
            'completed_at': DateTime.now().millisecondsSinceEpoch,
          },
          where: 'project_id = ?',
          whereArgs: [projectId],
        );

        // xoa cac task bi trung ten (giu lai task co id nho nhat)
        // Luu y: subquery chon MIN(id) can bao gom project_id de khong xoa nham project khac
        await txn.rawDelete(
          '''
          DELETE FROM tasks
          WHERE id NOT IN (
            SELECT MIN(id) FROM tasks
            WHERE project_id = ?
            GROUP BY title
          ) AND project_id = ?
        ''',
          [projectId, projectId],
        );

        // cap nhat trang thai project thanh done
        await txn.update(
          'projects',
          {'status': 'done'},
          where: 'id = ?',
          whereArgs: [projectId]
        );
      });
      print('Transaction thanh cong: Du an da hoan tat va du lieu da duoc lam sach');
    } catch (e) {
      print('Loi khi thuc hien transaction $e');
      // Transaction sẽ tự động rollback nếu có ngoại lệ xảy ra trong khối lệnh
      rethrow;
    }
  }
}

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String _log = "Đang chạy test...";

  @override
  void initState() {
    super.initState();
    runTest();
  }

  Future<void> runTest() async {
    try {
      final helper = ProjectDatabaseHelper();
      await helper.completeProject(1);
      setState(() => _log = "Thành công!");
    } catch (e) {
      setState(() => _log = "Lỗi: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Test Database")),
      body: Center(child: Text(_log)),
    );
  }
}

void main() async {
  // Cần thiết để khởi tạo Flutter engine cho các thao tác test
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: TestScreen()));
}