import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/components/user_tile.dart';
import 'package:flutter_crud_simples/models/user.dart';
import 'package:flutter_crud_simples/provider/users.dart';
import 'package:provider/provider.dart';

class UserList extends StatelessWidget {
  const UserList({super.key});

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
            onPressed: () {
              users.put(User(
                name: "Teste",
                email: "Aluno@ddd.com.br",
                avatarUrl: "",
              ));
            },
            icon: const Icon(Icons.add),
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
