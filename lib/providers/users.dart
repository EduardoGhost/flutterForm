import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_project/data/users.dart';
import '../models/user.dart';


class Users with ChangeNotifier{
  final Map<String, User> _items = {...USERSDATA};

  List<User> get all{
    return [..._items.values];
  }
  int get count{
    return _items.length;
  }

  User byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(User user){
    if(user == null){
      return;
    }
    if(user.id != null &&
        user.id.trim().isEmpty &&
    _items.containsKey(user.id)){
      _items.update(user.id, (_) => User(
          user.id,
          user.name,
          user.email,
          user.avatarUrl,
      ));
    }else{
    final id = Random().nextDouble().toString();
    _items.putIfAbsent(id, () => User(
        id,
        user.name,
        user.email,
        user.avatarUrl));

  }
    notifyListeners();
  }
  void remove(User user){
    if(user != null && user.id != null){
      _items.remove(user.id);
      notifyListeners();
    }
  }
}