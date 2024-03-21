import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';

class UserEditForm extends StatefulWidget {
  //tem como parâmetros um usuário e uma função
  final User user;
  final Function(String, String, String) onEdit;

  //pega a chave do pai e inicializa os parâmetros pedidos
  const UserEditForm({Key? key, required this.user, required this.onEdit})
      : super(key: key);

  @override
  //cria e retorna uma instância de state da classe de edição
  _UserEditFormState createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  /*
  cria uma chave global que permite acessar e manipular o estado de um widget
  de qualquer lugar do aplicativo. Basicamente define uma variável global para
  que possamos "brincar depois"
  */
  final _formKey = GlobalKey<FormState>();

  //cria "constantes" que podem ter valor atribuídos depos
  late String _name;
  late String _email;

  //sobrescreve um método da classe pai
  @override
  void initState() {
    /*
    é uma chamada ao método initState da classe pai, para garantir que qualquer
    inicialização necessária feita na classe pai seja executada
    */
    super.initState();
    /*
    inicializações de variáveis de estado com os valores do usuário passado
    para o widget. Nesse caso, serve para preencher os campos do formulário com
    os dados do usuário existente quando o formulário de edição é aberto
    */
    _name = widget.user.name;
    _email = widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User Form'),
      ),
      body: Form(
          //atribui como chave a chave global do formulário
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                //inicia com o valor passado pelo estado obtido do usuario
                initialValue: _name,
                //estilização simples
                decoration: InputDecoration(labelText: "Name"),
                //validador simples
                validator: (value) {
                  /*
                  não permite que o formulário seja alterado para um campo vazio
                  e "lança um erro"
                  */
                  if (value == null || value.isEmpty) {
                    return 'Insert a name';
                  }
                  return null;
                },
                /*
                quando for salvo (clicar em "Save"), repassa à variável o valor
                passado
                */
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                //inicia com o valor passado pelo estado obtido do usuario
                initialValue: _email,
                //estilização simples
                decoration: InputDecoration(labelText: "E-mail"),
                validator: (value) {
                  /*
                  não permite que o formulário seja alterado para um campo vazio
                  e "lança um erro"
                  */
                  if (value == null || value.isEmpty) {
                    return 'Insert an E-mail';
                  }
                  return null;
                },
                /*
                quando for salvo (clicar em "Save"), repassa à variável o valor
                passado
                */
                onSaved: (value) => _email = value!,
              ),
              ElevatedButton(
                //quando o botão de salvar for clicado
                onPressed: () {
                  /*
                  se o formulário for diferente do anterior e tiver sido
                  validado
                  */
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    //repassa os atributos coletados para a função onEdit do pai
                    widget.onEdit(_name, _email, widget.user.id);
                    //Navigator.of(context).pop();
                  }
                },
                child: Text('Save'),
              ),
            ],
          )),
    );
  }
}
