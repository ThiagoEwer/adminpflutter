// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'user.dart';
import 'package:flutter/material.dart';

class AdminPanelPage extends StatefulWidget {
  const AdminPanelPage({super.key});

  @override
  _AdminPanelPageState createState() => _AdminPanelPageState();
}

class _AdminPanelPageState extends State<AdminPanelPage> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    // Aqui, utilizamos a referência ao nó "users" no Realtime Database e adicionamos um listener
    // para atualizar a lista de usuários sempre que houver alguma alteração no banco de dados.
    
    FirebaseDatabase.instance.reference().child('users').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        final users = <User>[];
        data.forEach((key, value) {
          final email = value['EMAIL'] as String;
          final telefone = value['TELEFONE'] as int;
          final porta = value['PORTA'] as int;
          final empresas = (value['EMPRESAS'] as Map).cast<String, String>();
          final urls = (value['URLS'] as Map).cast<String, String>();
          users.add(User(
            email: email,
            telefone: telefone,
            porta: porta,
            empresas: empresas,
            urls: urls,
          ));
        });
        setState(() {
          _users = users;
        });
      }
    });
  }
  /*
   FirebaseDatabase.instance.reference().child('users/').once().then((DataSnapshot snapshot) {
    final data = snapshot.value;
    if (data != null) {
      final users = <User>[];
      data.forEach((key, value) {
        final email = value['EMAIL'] as String;
        final telefone = value['TELEFONE'] as int;
        final porta = value['PORTA'] as int;
        final empresas = (value['EMPRESAS'] as Map).cast<String, String>();
        final urls = (value['URLS'] as Map).cast<String, String>();
        users.add(User(
          email: email,
          telefone: telefone,
          porta: porta,
          empresas: empresas,
          urls: urls,
        ));
      });
      setState(() {
        _users = users;
      });
    }
  });
}
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Painel de Administração')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user.email),
            subtitle: Text('Telefone: ${user.telefone} - Porta: ${user.porta}'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Aqui, podemos navegar para uma nova tela que permita a edição do usuário.
              // Para isso, basta passar o objeto User para a nova tela.
            },
          );
        },
      ),
    );
  }
}