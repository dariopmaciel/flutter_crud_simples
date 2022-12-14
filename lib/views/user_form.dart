import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/models/user.dart';
import 'package:flutter_crud_simples/provider/users.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {
//  UserForm({super.key});
  //criação de chave do formulário
  final _form = GlobalKey<FormState>();
  //como os dados a serem acrescentados são todos finais, será feito um MAP vazio
  final Map<String, String> _formData = {};

  void _loadFormData(User user) {
    if (user.id.isNotEmpty) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarURL'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      final User user = ModalRoute.of(context)!.settings.arguments as User;
      _loadFormData(user);
    } catch (e) {}

    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulário de Usuário"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                //chama casa um dos filhos o metodo 'Save'
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
                  //adicionado 'initialValue' para quando editar carregar valor
                  initialValue: _formData['name'],
                  decoration: const InputDecoration(labelText: "Nome"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Campo inválido!";
                    }
                    //trim só pode ser usado após validação de campo vazio
                    if (value.trim().length <= 3) {
                      return "Mínimo 5 caracteres.";
                    }
                    //se estiver OK retornará null, salvará e retornará o POP
                    return null;
                  },
                  onSaved: (value) => _formData["name"] = value!,
                ),
                TextFormField(
                  initialValue: _formData["email"],
                  decoration: const InputDecoration(labelText: "E-mail"),
                  onSaved: (value) => _formData["email"] = value!,
                ),
                TextFormField(
                  initialValue: _formData["avatarURL"],
                  decoration: const InputDecoration(labelText: "URL do Avatar"),
                  onSaved: (value) => _formData["avatarUrl"] = value!,
                ),
              ],
            )),
      ),
    );
  }
}
