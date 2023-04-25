import 'package:adminpflutter/website/config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'website/security/loginpage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(const AdminPainelFlutter());
}

class AdminPainelFlutter extends StatelessWidget {
  const AdminPainelFlutter({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

// verificar video de conexão com real time DB
// se não der certo, verificar com FireStore DB
//Se não funcionar, usa o Firebase apenas para loggin e procura outro backend pra fazer