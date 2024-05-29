import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'user_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE users(id TEXT PRIMARY KEY, name TEXT, email TEXT, avatarUrl TEXT)",
      );
    },
      version: 1,
  );
}

