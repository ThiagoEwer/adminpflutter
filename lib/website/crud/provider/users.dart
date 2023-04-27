// ignore_for_file: unnecessary_null_comparison

import 'dart:math';

import 'package:adminpflutter/website/crud/data/dammy_users.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  //verifica se passou um usuário nullo
  // se for diferente de nullo, ele vai:
  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
          user.id,
          (_) => User(
                id: user.id,
                name: user.name,
                email: user.email,
                empresa: user.empresa,
                avatarUrl: user.avatarUrl,
                apiUrl: user.apiUrl,
              ));
    } else {
      // ------ CREATE---------// adicionar

      //adicionando ID de forma randomica
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(
          id,
          () => User(
              id: id,
              name: user.name,
              email: user.email,
              empresa: user.empresa,
              avatarUrl: user.avatarUrl,
              apiUrl: user.apiUrl));

      // ------ CREATE---------//
    }

    //ou alterar(um existente)

//nofityListerners é avisado que houve uma mundança e assim, ele altera a Interface Gráfica.
    notifyListeners();
  }

     // ------ REMOVE---------//

     void remove(User user){
      if(user != null && user.id != null) {
        _items.remove(user.id);
        notifyListeners();
      }
     }

  
}
