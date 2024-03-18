import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';

//como stateless, essa view é imutável (não dinâmico)
class UserListView extends StatelessWidget {
  /*
  criamos uma lista imutável e que pode ser atribuída posteriormente de nome
  users.
  Lembrando que final, são constantes que podem ter valores atribuídos
  posteriormente, mas sem reatribuição
  */
  final List<User> users;
  /*
  Aqui, definimos uma Função de nome "onDelete" que recebe um argumento do 
  tipo String
  */
  final Function(String) onDelete;
  /*
  Aqui, definimos uma Função de nome "onDelete" que recebe um argumento do 
  tipo String
  */
  final Function(String, String, String) onEdit;

  /*
  Aqui, definimos os parâmetros do construtor do widget, onde "super.key" é a
  chave do widget que é passada para o construtor da classe pai.
  "require this.users" define a propriedade users que é uma lista de objetos
  user que o widget UserListView usará para exibir os usuários (e pelo fato de 
  ser "required", é obrigatória).
  "require this.onDelete" define uma propriedade onDelete (obrigatória, 
  pelo "required"), que é uma função callback que será chamada quando o usuário
  solicitar a exclusão de um item na lista.
  "require this.onEdit", mesmo caso da propriedade onDelete, mas que nesse caso
  irá editar o item na lista. 
  */
  const UserListView(
      {super.key,
      required this.users,
      required this.onDelete,
      required this.onEdit});

  @override
  //construímos a interface do usuário do widget
  Widget build(BuildContext context) {
    /*
    cria uma lista de items eficiente construindo apenas os items que estão
    visíveis atualmente na tela, evitando o consumo de recursos (processamento)
    desnecessario.
    */
    return ListView.builder(
      //propriedade que especifica o número de itens na lista
      itemCount: users.length,
      /*
      função chamada para cada item na lista, dentro da função, definimos
      como cada item deve ser construído
      */
      itemBuilder: (context, index) {
        //obtém o usuário atual usando o index
        final user = users[index];
        /*
        ListTile é um widget que representa um item de lista como um título,
        subtítulo e um ícone de ação
        */
        return ListTile(
            //define os atributos a serem exibidos
            title: Text(user.email),
            subtitle: Text(user.email),
            /*
          adiciona um botão de ícone no final do ListTile que chama a função
          onDelete passada como argumento.
          */
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.delete),
                  /*
                  aciona a função onDelete quando pressionado passando id do
                  user como parâmetro
                  */
                  onPressed: () => onDelete(user.id),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  /*
                  aciona a função onEdit quando pressionado passando id do user 
                  como parâmetro
                  */
                  onPressed: () => onEdit(user.id, user.name, user.email),
                )
              ],
            ));
      },
    );
  }
}
