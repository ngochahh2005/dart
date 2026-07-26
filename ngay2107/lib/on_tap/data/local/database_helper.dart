import 'package:ngay2107/on_tap/models/dto/book_dto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._internal();

  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'book_app.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favourites(
      id TEXT PRIMARY KEY,
      title TEXT NOT NULL,
      status TEXT NOT NULL
    )
    ''');
  }

  Future<void> insertFavourite(Map<String, dynamic> bookData) async {
    final db = await database;
    db.insert(
      'favourites',
      bookData,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAllFavourites() async {
    final db = await database;
    return await db.query('favourites');
  }

  Future<void> deleteFavourite(String id) async {
    final db = await database;
    await db.delete(
      'favourites',
      where: 'id=?',
      whereArgs: [id]
    );
  }
}
