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

  /*
  definição dos controladores dos TextField, eles dizem o que o campo de fazer
  após uma ação específica (mais informações abaixo)
  */
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        //a chave do widget é a do form
        key: _formKey,
        child: Column(
          children: <Widget>[
            //cria textfields
            TextFormField(
              //o responsável por gerenciar o textField
              controller: _nameController,
              //estilizações
              decoration: InputDecoration(labelText: 'Name'),
              //validadores
              validator: (value) {
                /*
                se o valor dentro do campo for vazio no momento da
                submissão (clicar no botão add), ele impede o prosseguimento e
                lança essa "mensagem de erro", é um aviso básico
                */
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onChanged: (value) => setState(() => _name = value),
            ),
            TextFormField(
              //responsável por gerenciar esse campo
              controller: _emailController,
              //estilização (simples)
              decoration: InputDecoration(labelText: 'Email'),
              //validador
              validator: (value) {
                /*
                se o valor dentro do campo for vazio no momento da
                submissão (clicar no botão add), ele impede o prosseguimento e
                lança essa "mensagem de erro", é basicamente um aviso
                */
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
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
                /*
                limpa os TextFields, isso e os validadores, evitam que caso
                cliquemos em "add" ele replique os valores guardados no state 
                */
                _nameController.clear();
                _emailController.clear();
              },
              //apenas um "label"
              child: Text('Add'),
            )
          ],
        ));
  }
}
