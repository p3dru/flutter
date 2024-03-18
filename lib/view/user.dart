import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';

class UserListView extends StatelessWidget {
  final List<User> users;
  final Function(String) onDelete;

  const UserListView({super.key, required this.users, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          title: Text(user.email),
          subtitle: Text(user.email),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => onDelete(user.id),
          ),
        );
      },
    );
  }
}
