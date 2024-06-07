import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {

  // Singleton pattern
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  // Getter for the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initializes the database.
  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT, avatarUrl TEXT, age INT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  // Inserts a record into the specified table.
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    print("Dados inseridos ${data}");
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Queries all rows in the specified table.
  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    final db = await database;
    return await db.query(table);
  }

  // Updates a record in the specified table.
  Future<int> update(String table, Map<String, dynamic> data, String id) async {
    final db = await database;
    print("Dados atualizados ${data}");
    return await db.update(table, data, where: 'id = ?', whereArgs: [id]);
  }

  // Deletes a record from the specified table.
  Future<int> delete(String table, String id) async {
    final db = await database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }
}


