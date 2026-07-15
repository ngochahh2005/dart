import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/*
  4. Thao tác với dữ liệu (CRUD)
  4.1. Định nghĩa Model
  Trước khi thao tác, hãy định nghĩa một lớp Model để đại diện cho dữ liệu.
 */

// Bước 1: Model
class Dog {
  final int id;
  final String name;
  final int age;

  const Dog({required this.id, required this.name, required this.age});

  // Chuyen doi tu Map (tu databse) sang doi tuong Dog
  Dog.fromMap(Map<String, Object?> map)
    : id = map['id'] as int,
      name = map['name'] as String,
      age = map['age'] as int;

  // Chuyen doi tu Dog sang Map (de insert/update)
  Map<String, Object?> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }
}

// Buoc 2: Class quan ly (CRUD)
class DogProvider {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // tao bang (create)
  Future<Database?> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'dog_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE dogs(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  // them du lieu (insert)
  Future<void> _insertDog(Dog dog) async {
    final db = await database;
    await db.insert(
      'dogs',
      dog.toMap(),
      // Nếu ID đã tồn tại: Nó sẽ xóa dòng cũ đang có ID đó đi và thay thế bằng dòng mới mà bạn vừa gửi vào.
      /// Một số lựa chọn thay thế (Conflict Algorithms)
      /// - ConflictAlgorithm.replace: Xóa dòng cũ, ghi đè dòng mới (thường dùng nhất).
      /// - ConflictAlgorithm.ignore: Bỏ qua, không thêm dòng mới, không làm gì cả.
      /// - ConflictAlgorithm.abort: Hủy bỏ giao dịch (transaction) và báo lỗi (mặc định nếu không chỉ định).
      /// - ConflictAlgorithm.rollback: Quay lui (rollback) toàn bộ giao dịch hiện tại về trạng thái trước đó.
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // truy van du lieu (read)
  Future<List<Dog>> getAllDogs() async {
    final db = await database;
    final List<Map<String, Object?>> queryResult = await db.query(
      'dogs',
    ); // tương ứng với câu SQL: SELECT * FROM dogs).
    return queryResult.map((map) => Dog.fromMap(map)).toList();
  }

  // truy van co dieu kien
  Future<Dog?> getDog(int id) async {
    final db = await database;
    final List<Map<String, Object?>> map = await db.query(
      'dogs',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (map.isNotEmpty) {
      return Dog.fromMap(map.first);
    }
    return null;
  }

  // cap nhat du lieu (update)
  Future<void> updateDog(Dog dog) async {
    final db = await database;
    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  // xoa du lieu (delete)
  Future<void> deleteDog(int id) async {
    final db = await database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }
}
