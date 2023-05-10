// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously

import 'package:adminpflutter/website/crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/users.dart';

class UserForm extends StatefulWidget {
  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;

  final Map<String, String> _formData = {};

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['empresa'] = user.empresa;
      _formData['avatarUrl'] = user.avatarUrl;
      _formData['apiUrl'] = user.apiUrl;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final User? user = ModalRoute.of(context)?.settings.arguments as User?;
    if (user != null) {
      _loadFormData(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            //se o formulário for validado, vai salvar e chamar o pop(retornar a tela inicial)
            onPressed: () async {
              if (_form.currentState?.validate() == true) {
                _form.currentState?.save();

                setState(() {
                  _isLoading = true;
                });

                await Provider.of<Users>(context, listen: false).put(
                  User(
                      id: _formData['id'] ?? '',
                      name: _formData['name'] ?? '',
                      email: _formData['email'] ?? '',
                      empresa: _formData['empresa'] ?? '',
                      avatarUrl: _formData['avatarUrl'] ?? '',
                      apiUrl: _formData['apiUrl'] ?? ''),
                );

                setState(() {
                  _isLoading = false;
                });

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                  key: _form,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: _formData['name'],
                        decoration: const InputDecoration(labelText: 'Nome'),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Nome inválido';
                          }
                          if (value.trim().length < 3) {
                            return 'Mínimo 3 letras.';
                          }
                          return null;
                        },
                        onSaved: (value) => _formData['name'] = value!,
                      ),
                      TextFormField(
                          initialValue: _formData['email'],
                          decoration: const InputDecoration(labelText: 'Email'),
                          onSaved: (value) => _formData['email'] = value!),
                      TextFormField(
                          initialValue: _formData['empresa'],
                          decoration:
                              const InputDecoration(labelText: 'Empresa'),
                          onSaved: (value) => _formData['empresa'] = value!),
                      TextFormField(
                          initialValue: _formData['avatarUrl'],

                          decoration:
                              const InputDecoration(labelText: 'URL Avatar'),
                          onSaved: (value) => _formData['avatarUrl'] = value!),
                      TextFormField(
                          initialValue: _formData['apiUrl'],
                          decoration: const InputDecoration(labelText: 'API'),
                          onSaved: (value) => _formData['apiUrl'] = value!),
                    ],
                  )),
            ),
    );
  }
}
