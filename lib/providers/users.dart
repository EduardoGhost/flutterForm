import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/data/UserRepository.dart';
import '../models/user.dart';
import 'package:flutter/foundation.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {};
  final UserRepository _userRepository = UserRepository();

  Users() {
    _loadUsers();
  }

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  Future<void> _loadUsers() async {
    final users = await _userRepository.getUsers();
    _items.clear();
    for (var user in users) {
      _items[user.id] = user;
    }
    notifyListeners();
  }

  Future<void> put(User user) async {
    if (user == null) return;

    if (user.id.isNotEmpty && _items.containsKey(user.id)) {
      _items.update(user.id, (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
        age: user.age,
        password: user.password,
      ));

      await _userRepository.updateUser(user);
    } else {
      final id = Random().nextDouble().toString();
      final newUser = User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
        age: user.age,
        password: user.password,
      );
      _items[id] = newUser;
      await _userRepository.insertUser(newUser);
    }
    notifyListeners();
  }

  Future<void> remove(User user) async {
    if (user != null && user.id.isNotEmpty) {
      _items.remove(user.id);
      await _userRepository.deleteUser(user.id);
      notifyListeners();
    }
  }
}