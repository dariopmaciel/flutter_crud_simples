import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/data/dummy_user.dart';
import 'package:flutter_crud_simples/models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USER};

//CRIAÇÃO DE METODO GET
  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int index) {
    return _items.values.elementAt(index);
  }

  void put(User user) {
    if (user == null) {
      return;
    }
  }
}
