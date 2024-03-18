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
  //cria um estado que permite retornar o resultado de uma expressão diretamente
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /*
  Cria uma instância de UserController e armazena na final _userController 
  */
  final UserController _userController = UserController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        //título presente na appBar
        appBar: AppBar(title: Text('Crud with MVC')),
        body: Column(
          children: [
            //cria um widget UseForm, passando a função e os parâmetros dela
            UserForm(onSubmit: (name, email, id) {
              //Altera o state
              setState(() {
                /*
                passa os dados (id, name, email) solicitados no modal para o 
                controller (_userController), onde ele adiciona um novo usuário
                devido chamar método ".addUser"
                */
                _userController.addUser(User(id: id, name: name, email: email));
              });
            }),
            Expanded(
                //
                child: UserListView(
              //recebe os todos os usuários
              users: _userController.users,
              /*
                define o método onDelete solicitado na UserListView na linha
                final Function(String) onDelete no arquivo user_list_view.dart
                */
              onDelete: (id) {
                setState(() {
                  //exclui o usuário, baseado no id
                  _userController.removeUser(id);
                });
              },
              /*
                define o método onEdit solicitado na UserListView da view criado
                em final Function(String, String, String) onEdit no arquivo
                user_list_view.dart
                */
              onEdit: (id, name, email) {
                setState(() {
                  //atualiza o usuário baseado no id
                  _userController.updateUser(id, name, email);
                });
              },
            ))
          ],
        ),
      ),
    );
  }
}
