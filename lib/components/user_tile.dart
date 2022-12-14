import 'package:flutter/material.dart';
import 'package:flutter_crud_simples/models/user.dart';
import 'package:flutter_crud_simples/provider/users.dart';
import 'package:flutter_crud_simples/routs/app_routs.dart';
import 'package:provider/provider.dart';

class UserTile extends StatelessWidget {
  const UserTile({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    final avatar = user.avatarUrl.isEmpty
        ? const CircleAvatar(child: Icon(Icons.person))
        : CircleAvatar(backgroundImage: NetworkImage(user.avatarUrl));

    return ListTile(
      leading: avatar,
      title: Text(user.name),
      subtitle: Text(user.email),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              color: Colors.blue,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AppRouts.USER_FORM, arguments: user);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: ((context) => AlertDialog(
                        title: Text("Excluir usuário ${user.name}!"),
                        content: const Text("Tem certeza?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Não"),
                          ),
                          TextButton(
                            onPressed: () {
                              Provider.of<Users>(context, listen: false)
                                  .remove(user);
                              Navigator.of(context).pop();
                            },
                            child: const Text("Sim"),
                          ),
                        ],
                      )),
                );
                //Provider.of<Users>(context, listen: false).remove(user);
              },
            ),
          ],
        ),
      ),
    );
  }
}
