import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/components/user_tile.dart';
import 'package:flutter_crud_simples/provider/users.dart';
import 'package:flutter_crud_simples/routs/app_routs.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  UserList({super.key});

  @override
  Widget build(BuildContext context) {
    //não é mais necessário pois usar o 'Provider'
    //final users = {...DUMMY_USER};

    final Users users = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Lista de Usuários"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRouts.USER_FORM);
              //criado como exemplo
              /*users.put(
                const User(
                  id: "",
                  name: "Teste",
                  email: "Aluno@ddd.com.br",
                  avatarUrl: "",
                ),
              );*/
              /*//deletado como exemplo
              users.remove(users.byIndex(0));*/
              /*//editado como exemplo
              users.put(
                User(
                  id: "20",
                  name: "Rafa",
                  email: "Rafa@RAFA",
                  avatarUrl: "",
                ),
              );*/
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: users.count,
        itemBuilder: (context, index) => UserTile(user: users.byIndex(index)),
      ),
    );
  }
}
