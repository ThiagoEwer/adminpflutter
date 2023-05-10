// ignore_for_file: unnecessary_null_comparison

import 'package:adminpflutter/website/crud/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../routes/app_routes.dart';

class Usertile extends StatelessWidget {
  const Usertile(this.user, {super.key});

  final User user;

  @override
  Widget build(BuildContext context) {
    //usado para buscar o avatar e posiciona-lo no leading do LisTile
    final avatar = user.avatarUrl == null || user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(
            backgroundImage: NetworkImage(user.avatarUrl),
          );
    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 120,
        child: Row(children: [
          IconButton(
              onPressed: () {
              },
              icon: const Icon(
                Icons.remove_red_eye,
                color: Colors.blue,
              )),
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.USER_FORM,
                  arguments: user,
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.orange,
              )),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Excluir usuário'),
                          content: const Text('Tem certeza ?'),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  //fecha a tela e volta pra anterior.
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Não')),
                            ElevatedButton(
                                onPressed: () {
                                  //chama o provider para apagar o registro
                                  Provider.of<Users>(context, listen: false)
                                      .remove(user);
                                  // e volta para a tela anterior.
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Sim')),
                          ],
                        ));
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ]),
      ),
    );
  }
}
