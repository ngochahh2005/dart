import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/meal.dart';

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
    final path = join(dbPath, 'recipeify.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String ingredientColumns = '';
        for (int i = 1; i <= 20; i++) {
          ingredientColumns += 'strIngredient$i TEXT,\n';
          ingredientColumns += 'strMeasure$i TEXT,\n';
        }
        db.execute('''
              CREATE TABLE favorites (
                idMeal TEXT,
                userId TEXT,
                strMeal TEXT,
                strMealThumb TEXT,
                strInstructions TEXT,
                strCategory TEXT,
                strArea TEXT,
                strYoutube TEXT,
                strTags TEXT,
                $ingredientColumns
                PRIMARY KEY (idMeal, userId)
              )
            ''');
      },
    );
  }

  Future<void> insertFavorite(Meal meal, String userId) async {
    final db = await database;
    final map = meal.toMap();
    map['userId'] = userId;

    await db.insert(
      'favorites',
      meal.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteFavorite(String idMeal, String userId) async {
    final db = await database;
    await db.delete(
      'favorites',
      where: 'idMeal=? AND userId=?',
      whereArgs: [idMeal, userId],
    );
  }

  Future<List<Meal>> getAllFavorites(String userId) async {
    final db = await database;
    final List<Map<String, dynamic>> queryRes = await db.query(
      'favorites',
      where: 'userId=?',
      whereArgs: [userId],
    );
    return queryRes.map((map) => Meal.fromJson(map)).toList();
  }

  Future<bool> isFavorite(String idMeal, String userId) async {
    final db = await database;
    final queryRes = await db.query(
      'favorites',
      where: 'idMeal=? AND userId=?',
      whereArgs: [idMeal, userId],
    );
    return queryRes.isNotEmpty;
  }
}
