import 'package:adminpflutter/website/crud/components/user_tile.dart';
import 'package:adminpflutter/website/crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

  @override
  Widget build(BuildContext context) {
    //foi colocado dentro do build para ser "consultado" posteriormente pelo o listviewbuilder.
    final Users users = Provider.of<Users>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Usuários Homologados'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: ListView.builder(
        //usado para mostrar os usuários do map user, nesse caso só objeto name.
        itemBuilder: (context, i) => Usertile(users.byIndex(i)),
        itemCount: users.count,
      ),
    );
  }
}
