// ignore_for_file: unnecessary_null_comparison
import 'dart:convert';
import 'package:adminpflutter/website/crud/data/dammy_users.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  static const _baseUrl = 'https://adminpainelg-default-rtdb.firebaseio.com/';
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

//usado para ler os registros do firebase.
  Future<void> fetch() async {
    final response = await http.get(Uri.parse("$_baseUrl/users.json"));
    Map<String, dynamic>? data = json.decode(response.body);

    if (data != null) {
      _items.clear();
      data.forEach((id, userData) {
        _items.putIfAbsent(
          id,
          () => User(
            id: id,
            name: userData['name'],
            email: userData['email'],
            empresa: userData['empresa'],
            avatarUrl: userData['avatarUrl'],
            apiUrl: userData['apiUrl'],
          ),
        );
      });
      notifyListeners();
    }
  }

  //verifica se passou um usuário nullo
  // se for diferente de nullo, ele vai:
  Future<void> put(User user) async {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      //await para com patch para alterar os registros no firebase.
      await http.patch(Uri.parse("$_baseUrl/users/${user.id}.json"),
          body: json.encode({
            'name': user.name,
            'email': user.email,
            'empresa': user.empresa,
            'avatarUrl': user.avatarUrl,
            'apiUrl': user.apiUrl
          }));

      _items.update(
        user.id,
        (_) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          empresa: user.empresa,
          avatarUrl: user.avatarUrl,
          apiUrl: user.apiUrl,
        ),
      );
    } else {
      //post para enviar os registros ao firebase.
      final response = await http.post(
        Uri.parse("$_baseUrl/users.json"),
        body: json.encode({
          'name': user.name,
          'email': user.email,
          'empresa': user.empresa,
          'avatarUrl': user.avatarUrl,
          'apiUrl': user.apiUrl
        }),
      );

      //recebendo Id do firebase
      final id = json.decode(response.body)['name'];
      _items.putIfAbsent(
        id,
        () => User(
            id: id,
            name: user.name,
            email: user.email,
            empresa: user.empresa,
            avatarUrl: user.avatarUrl,
            apiUrl: user.apiUrl),
      );
    }
    notifyListeners();
  }

 //excluir os registros
  Future<void> removeItem(User user) async {
    if (user != null && user.id != null) {
          await http.delete(Uri.parse("$_baseUrl/users/${user.id}.json"));
      _items.remove(user.id);
      notifyListeners();
    }
  }

  void remove(User user) {
    removeItem(user);
  }
}
