/*
  1. Giới thiệu về sqflite
  sqflite là plugin phổ biến và được khuyến nghị chính thức để làm việc với cơ sở dữ liệu SQLite trong Flutter.
  Nó hỗ trợ hầu hết các nền tảng phổ biến:
  - Hỗ trợ chính thức: iOS, Android và macOS.
  - Hỗ trợ bổ sung: Linux, Windows và DartVM thông qua package sqflite_common_ffi.
  - Hỗ trợ Web (thử nghiệm): Thông qua package sqflite_common_ffi_web.
  Ưu điểm nổi bật:
  - Hỗ trợ giao dịch (transactions) và xử lý theo lô (batches).
  - Tự động quản lý phiên bản cơ sở dữ liệu khi mở.
  - Cung cấp các hàm helper cho các thao tác insert, query, update, delete.
  - Các thao tác cơ sở dữ liệu được thực thi trên luồng nền (background thread) trên iOS và Android.

  2. Cài đặt
  - Thêm dependency vào file pubspec.yaml:
    dependencies:
      sqflite: ^2.4.3
      path: ^1.9.1
  - Import các package cần thiết:
      import 'package:sqflite/sqflite.dart';
      import 'package:path/path.dart';

  3. Lý thuyết cơ bản
  3.1. Kiểu dữ liệu hỗ trợ
  SQLite hỗ trợ một số kiểu dữ liệu cơ bản. Khi sử dụng sqflite, bạn cần ánh xạ chúng với kiểu dữ liệu trong Dart:
            Kiểu SQLite     Kiểu Dart	            Ghi chú
            INTEGER	        int	                  Giá trị từ -2^63 đến 2^63 - 1
            REAL	          num	                  Số thực (double)
            TEXT	          String	              Chuỗi văn bản
            BLOB	          Uint8List	            Dữ liệu nhị phân
  Lưu ý quan trọng:
  - DateTime không được hỗ trợ trực tiếp. Bạn nên lưu trữ dưới dạng int (milliseconds since epoch)
  hoặc String (chuỗi ISO 8601).
  - bool không được hỗ trợ. Sử dụng INTEGER với giá trị 0 (false) và 1 (true).

  3.2. Mở và đóng cơ sở dữ liệu
  Một cơ sở dữ liệu SQLite là một file trên hệ thống. Bạn cần xác định đường dẫn đến file đó.
 */

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // bien tinh de giu instance cua database
  Database? _database;

  // phuong thuc lay database
  Future<Database> get database async {
    if (_database != null) return _database!;

    // neu chua co, tien hanh khoi tao
    _database = await _initDatabase2();
    return _database!;
  }

  // Ham mo va khoi tao database
  // Future<Database> _initDatabse() async {
  //   // 1. Lay duong dan thu muc database mac dinh
  //   final dbPath = await getDatabasesPath();
  //
  //   // 2. Tao duong dan day du den file 'my_app.db'
  //   final path = join(dbPath, 'my_app.db');
  //
  //   // 3. Mo database
  //   return await openDatabase(
  //     path,
  //     // version: Số nguyên định danh phiên bản của schema database.
  //     // Mỗi khi bạn thay đổi cấu trúc bảng, bạn phải tăng con số này lên.
  //     version: 1,
  //     // onCreate: Chỉ chạy một lần duy nhất khi database lần đầu tiên được tạo trên điện thoại người dùng.
  //     onCreate: (db, version) async {
  //       // Tao bang ngay khi khoi tao database lan dau
  //       await db.execute('CREATE TABLE users(id INTEGER KEY, nam TEXT)');
  //     },
  //     // onUpgrade: Chạy khi số version hiện tại trong file database trên điện thoại nhỏ hơn số version
  //     // bạn truyền vào hàm openDatabase. Đây là nơi bạn thực hiện "Migration" (chuyển đổi cấu trúc).
  //
  //     // onDowngrade: (Tùy chọn) Chạy khi bạn giảm số version. Thông thường ít dùng, hoặc dùng để khôi phục
  //     // cấu trúc về phiên bản cũ hơn.
  //   );

  Future<Database> _initDatabase2() async {
    final path = join(await getDatabasesPath(), 'my_app.db');

    return await openDatabase(
        path,
        version: 2, // tang version len 2 vi da co thay doi cau truc
        // chi chay neu file chua ton tai
        onCreate: (db, version) async {
          await db.execute(
              'CREATE TABLE users(id INTEGER PRIMARY KEY, name TEXT)');
        },
        // chay neu version trong file cu < version hien tai (2)
      onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            // Migration: them cot 'email' vao bang 'users'
            await db.execute('ALTER TABLE users ADD COLUMN email TEXT');
          }
      }
    );
  }

  // Ham dong database khi can thiet
  // Thông thường, bạn không cần đóng database vì nó sẽ tự động đóng khi ứng dụng kết thúc.
  // Tuy nhiên, nếu muốn giải phóng tài nguyên, bạn có thể đóng:
  Future<void> closeDatabase() async {
    final db = await _database;
    if (db != null && db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}
