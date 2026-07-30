import 'package:meow_collector/models/favorite_cat.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._internal();

  static final _instance = DatabaseService._internal();

  factory DatabaseService() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _init();
    return _database!;
  }

  Future<Database> _init() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'meow_collector.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE favorites (
              id TEXT PRIMARY KEY, 
              breedName TEXT, 
              imageUrl TEXT,
              breedType TEXT, 
              createdAt INTEGER
            )
          ''',
        );
      },
    );
  }

  Future<void> insertFavoriteCat(FavoriteCat cat) async {
    final db = await database;
    await db.insert(
      'favorites',
      cat.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavoriteCat(String id) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'id=?',
      whereArgs: [id]
    );
  }

  Future<void>deleteAllFavorite() async {
    final db = await database;
    await db.delete('favorites');
  }

  Future<List<FavoriteCat>> getAllFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> queryRes = await db.query('favorites');
    return queryRes.map((map) => FavoriteCat.fromJson(map)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await database;
    final queryRes = await db.query(
      'favorites',
      where: 'id=?',
      whereArgs: [id]
    );
    return queryRes.isNotEmpty;
  }

  Future<void> closeDatabase() async {
    final db = await database;
    if (db.isOpen) {
      await db.close();
      _database = null;
    }
  }
}
