import 'package:flutter/material.dart';
import 'package:user_mvc/controller/user.dart';
import 'package:user_mvc/model/user.dart';
import 'package:user_mvc/view/user_form.dart';
import 'package:user_mvc/view/user_list_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Crud with MVC')),
        body: Column(
          children: [
            UserForm(onSubmit: (name, email, id) {
              setState(() {
                _userController.addUser(User(id: id, name: name, email: email));
              });
            }),
            Expanded(
                child: UserListView(
              users: _userController.users,
              onDelete: (id) {
                setState(() {
                  _userController.removeUser(id);
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
