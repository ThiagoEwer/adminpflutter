import 'package:adminpflutter/website/config/firebase_options.dart';
import 'package:adminpflutter/website/crud/provider/users.dart';
import 'package:adminpflutter/website/crud/views/user_form.dart';
import 'package:adminpflutter/website/crud/views/user_list.dart';
import 'package:adminpflutter/website/security/loginpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './website/crud/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const AdminPainelFlutter());
}

class AdminPainelFlutter extends StatelessWidget {
  const AdminPainelFlutter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //o material está envolvido com o Provider Users, para atualizar todo o material.
    // se não funcionar, colocar o Provider apenas no APP raiz após o login, no caso, o PainelGeral.
    return ChangeNotifierProvider(
      create: (context) => Users(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      //home desabilitado para usar o routes.  
     // home: const UserList(),
        routes: {
          AppRoutes.LOGIN:(context) => const LoginPage(),
          AppRoutes.HOME:(context) => const UserList(),
          AppRoutes.USER_FORM:(context) => const UserForm()
     //     AppRoutes.USER_DETAILS: (_) => UserDetails(),
        }
      ),
    );
  }
}

