import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'meals.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE favorite_meals (
        id TEXT PRIMARY KEY,
        categories TEXT,
        title TEXT,
        imageUrl TEXT,
        ingredients TEXT,
        steps TEXT,
        duration INTEGER,
        complexity INTEGER,
        affordability INTEGER,
        isGlutenFree INTEGER,
        isLactoseFree INTEGER,
        isVegan INTEGER,
        isVegetarian INTEGER
      )
      ''',
    );
  }

  // Insert a new record
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert(tableName, row);
  }

  // Query all rows
  Future<List<Map<String, dynamic>>> queryAllRows(String tableName) async {
    Database db = await database;
    return await db.query(tableName);
  }

  // Query specific rows
  Future<List<Map<String, dynamic>>> queryRows(
    String tableName,
    String where,
    List<dynamic> whereArgs,
  ) async {
    Database db = await database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  // Update a record
  Future<int> update(
    String tableName,
    String columnId,
    Map<String, dynamic> row,
  ) async {
    Database db = await database;
    int id = row[columnId];
    return await db.update(
      tableName,
      row,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Delete a record
  Future<int> delete(String tableName, String columnId, int id) async {
    Database db = await database;
    return await db.delete(
      tableName,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }

  // Close the database
  Future<void> close() async {
    Database db = await database;
    await db.close();
  }
}
