// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:adminpflutter/website/test/adminpanelpage.dart';
import 'package:adminpflutter/website/test/datascreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cadastropage.dart';
import 'dashboard.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  late String _email;
  late String _senha;
  String _errorMessage = '';

  void popUpNaofuncional(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Função Indisponível'),
        content: const Text('Função ainda inexistente no sistema'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  void popUpEsqueciSenha(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Esqueci a Senha'),
        content: const Text('Entre em contato com os administradores do sistema.'),
        actions: <Widget>[
          ElevatedButton(
            child: const Text('Fechar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue.shade700,
                Colors.blue.shade400,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'AdminPainelG',
                            style: TextStyle(
                              color: Colors.blue.shade700,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'E-mail',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Digite seu email';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Senha',
                              fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Digite a sua senha';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                _senha = value;
                              });
                            },
                          ),
                          Text(
                            _errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                          const SizedBox(height: 2),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  UserCredential userCredential =
                                      await _auth.signInWithEmailAndPassword(
                                    email: _email,
                                    password: _senha,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DashboardPage(userName: _email)
                                            ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    setState(() {
                                      _errorMessage = 'Usuário não encontrado.';
                                    });
                                  } else if (e.code == 'wrong-password') {
                                    setState(() {
                                      _errorMessage = 'Senha incorreta.';
                                    });
                                  }
                                }
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              padding: MaterialStateProperty.all(
                                  const EdgeInsets.symmetric(vertical: 15)),
                            ),
                            child: const Text('Login'),
                          ),
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Implement login com Google
                                      popUpNaofuncional(context);
                                    },
                                    icon: const Icon(Icons.mail_outline),
                                    label: const Text('Gmail'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.redAccent),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 15)),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      // Implement login com github
                                      popUpNaofuncional(context);
                                    },
                                    icon: const Icon(Icons.mail),
                                    label: const Text('Outlook'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(255, 7, 47, 248)),
                                      padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 15)),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      popUpEsqueciSenha(context);
                                      // Implement forgot password functionality
                                    },
                                    child: const Text(
                                      'Esqueceu a senha?',
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const CadastroPage()),
                                      );
                                    },
                                    child: const Text('Cadastre-se',
                                    style: TextStyle(
                                      color: Colors.blue
                                    ),),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
