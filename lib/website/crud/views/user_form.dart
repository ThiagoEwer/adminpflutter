// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:adminpflutter/website/crud/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/users.dart';

class UserForm extends StatelessWidget {
   UserForm({super.key});

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de usuário'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            //se o formulário for validado, vai salvar e chamar o pop(retornar a tela inicial)
            onPressed: () {
              if (_form.currentState?.validate() == true) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                      id: _formData['id']?? '',
                      name: _formData['name']?? '',
                      email: _formData['email']?? '',
                      empresa: _formData['empresa']?? '',
                      avatarUrl: _formData['avatarUrl']?? '',
                      apiUrl: _formData['apiUrl']?? ''),
                );

                Navigator.of(context).pop();
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
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
                    decoration: const InputDecoration(labelText: 'Email'),
                    onSaved: (value) => _formData['email'] = value!),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Empresa'),
                    onSaved: (value) => _formData['empresa'] = value!),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'URL Avatar'),
                    onSaved: (value) => _formData['avatarUrl'] = value!),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'API'),
                    onSaved: (value) => _formData['apiUrl'] = value!),
              ],
            )),
      ),
    );
  }
}
