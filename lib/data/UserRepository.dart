import '../models/user.dart';
import 'DatabaseHelper.dart';

class UserRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Add user
  Future<void> insertUser(User user) async {
    await _databaseHelper.insert('users', user.toMap());
  }

  // Get user
  Future<List<User>> getUsers() async {
    final List<Map<String, dynamic>> maps = await _databaseHelper.queryAllRows('users');
    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  // Update user
  Future<void> updateUser(User user) async {
    await _databaseHelper.update('users', user.toMap(), user.id);
  }

  // Delete user
  Future<void> deleteUser(String id) async {
    await _databaseHelper.delete('users', id);
  }

  Future<User?> getUserByEmail(String email) async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
