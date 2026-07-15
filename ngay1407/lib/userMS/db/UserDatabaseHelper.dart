import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/User.dart';

class UserDatabaseHelper {
  static final UserDatabaseHelper instance = UserDatabaseHelper._init();
  static Database? _database;

  UserDatabaseHelper._init();
  
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase('app_database.db');
    return _database!;
  }

  Future<Database?> _initDatabase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute(
      '''
       CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        phone TEXT NOT NULL,
        avatar TEXT,
        dateOfBirth TEXT NOT NULL
       )
      '''
    );

    // tao san du lieu mau
    await _insertSampleData(db);
  }

  Future<void> _insertSampleData(Database db) async {
    // Danh sach du lieu mau
    final List<Map<String, dynamic>> sampleUsers = [
      {
        'name': 'Nguyen Van A',
        'email': 'anv@gmail.com',
        'phone': '0123456789',
        'avatar': null,
        'dateOfBirth': DateTime(1990, 5, 15).toIso8601String()
      },
      {
        'name': 'Tran Thi B',
        'email': 'btt@gmail.com',
        'phone': '0987654321',
        'avatar': null,
        'dateOfBirth': DateTime(1993, 8, 21).toIso8601String()
      },
      {
        'name': 'Le Van C',
        'email': 'clv@gmail.com',
        'phone': '0741852963',
        'avatar': null,
        'dateOfBirth': DateTime(1988, 3, 10).toIso8601String()
      },
      {
        'name': 'Pham Thi D',
        'email': 'dpt@gmail.com',
        'phone': '0369852147',
        'avatar': null,
        'dateOfBirth': DateTime(1995, 11, 25).toIso8601String()
      },
      {
        'name': 'Hoang Van E',
        'email': 'ehv@gmail.com',
        'phone': '0852147963',
        'avatar': null,
        'dateOfBirth': DateTime(1993, 7, 8).toIso8601String()
      },
    ];

    // chen tung nguoi dung vao csdl
    for (final userData in sampleUsers) {
      await db.insert('users', userData);
    }
  }

  // create - them user moi
  Future<void> insertUser(User user) async {
    final db = await instance.database;
    await db.insert('users', user.toMap());
  }

  // read - doc tat ca users
  Future<List<User>> getAllUser() async {
    final db = await instance.database;
    final res = await db.query('users');
    return res.map((map) => User.fromMap(map)).toList();
  }

  // read - doc user theo id
  Future<User?> getUserById(int id) async {
    final db = await instance.database;
    final maps = await db.query('users', where: 'id = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  // update - cap nhat user
  Future<int> updateUser(User user) async {
    final db = await instance.database;
    return await db.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id]
    );
  }

  // delete - xoa user
  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // delete - xoa tat ca users
  Future<int> deleteAllUser() async {
    final db = await instance.database;
    return await db.delete('users');
  }

  // dem so luong users
  Future<int> countUsers() async {
    final db = await instance.database;
    final res = await db.rawQuery('SELECT COUNT(*) FROM users');
    return Sqflite.firstIntValue(res) ?? 0;
  }
}