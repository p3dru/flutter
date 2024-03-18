import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';

class UserForm extends StatefulWidget {
  //cria uma função de nome onSubmit, que recebe 3 argumentos do tipo String
  final Function(String, String, String) onSubmit;

  /*
  cria um formulário de usuário onde passa a super.key e a função onSubmit
  */
  const UserForm({super.key, required this.onSubmit});

  @override
  /*
  "createState()" é um método abstrato que retorna uma instância de State que é
  usada pelo flutter para construir a interface de usuário do widget. O tipo
  genérico state<UserForm> indica que o estado retornado por esse método é 
  específico para o widget UserForm.
  "=> _UserFormState()", permite retornar o resultado de uma expressão
  diretamente. Nesse caso, ele está retornando uma nova instância de 
  _UserFromState().
  */
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  /*
  Cria uma chave global para o formulário. GlobalKey<FromState> é usado para
  identificar um Form widget na árvore de widgets. É útil para acessar o estado
  do formulário de fora do widget Form, como por exemplo para validar o
  formulário ou para obter os valores dos campos do formulário.
  */
  final _formKey = GlobalKey<FormState>();
  //declaração de variáveis e instância
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        //a chave do widget é a do form
        key: _formKey,
        child: Column(
          children: <Widget>[
            //cria textfields
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) => setState(() => _name = value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => setState(() => _email = value),
            ),
            //cria um ElevatedButton
            ElevatedButton(
              onPressed: () {
                /*
                verifica se o formulário é válido Se todos os campos dos
                formulário passarem nas validações, executa o bloco if
                */
                if (_formKey.currentState!.validate()) {
                  /*
                  Função passada pelo pai para o formulário e é usado para
                  processar os dados do formulário. 
                  */
                  widget.onSubmit(_name, _email, DateTime.now().toString());
                }
              },
              child: Text('Add'),
            )
          ],
        ));
  }
}
