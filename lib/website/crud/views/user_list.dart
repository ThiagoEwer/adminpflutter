import 'package:adminpflutter/website/crud/components/user_tile.dart';
import 'package:adminpflutter/website/crud/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
   late Users users;
//  final Users users = Provider.of<Users>(context);

  @override
  void initState() {
    super.initState();
    users = Provider.of<Users>(context, listen: false);
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    await users.fetch();
    setState(() {});
  }
//atualiza a tela sempre que há uma alteração de registro ou inclusão/exclusão
 @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    users = Provider.of<Users>(context);
  }
  
  @override
  Widget build(BuildContext context) {
    //foi colocado dentro do build para ser "consultado" posteriormente pelo o listviewbuilder.
  //  final Users users = Provider.of<Users>(context);
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
      body:
       ListView.builder(
        //usado para mostrar os usuários do map user, nesse caso só objeto name.
        itemBuilder: (context, i) => Usertile(users.byIndex(i)),
        itemCount: users.count,
      ), 
    );
  }
}