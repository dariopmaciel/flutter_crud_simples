import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/models/user.dart';
import 'package:flutter_crud_simples/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
  UserForm({super.key});

  //criação de chave do formulário
  final _form = GlobalKey<FormState>();
  //como os dados a serem acrescentados são todos finais, será feito um MAP vazio
  final Map<String, String> _formData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Usuário"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                //necessário colocar um listen false no provider
                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData["id"].toString(),
                    name: _formData["name"].toString(),
                    email: _formData["email"].toString(),
                    avatarUrl: _formData["avatarUrl"].toString(),
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
            key: _form,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo inválido!";
                    }
                    //trim só pode ser usado após validação de campo vazio
                    if (value.trim().length <= 3) {
                      return "Mínimo de 5 caracteres.";
                    }
                    //se estiver OK retornará null, salvará e retornará o POP
                    return null;
                  },
                  onSaved: (value) => _formData["name"] = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "E-mail"),
                  onSaved: (value) => _formData["email"] = value!,
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: "URL do Avatar"),
                  onSaved: (value) => _formData["avatarUrl"] = value!,
                ),
              ],
            )),
      ),
    );
  }
}
