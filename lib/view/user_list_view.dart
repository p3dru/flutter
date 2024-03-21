import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';
import 'package:user_mvc/view/user_edit_form.dart';

//como stateless, essa view é imutável (não dinâmico)
class UserListView extends StatefulWidget {
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
      {Key? key,
      required this.users,
      required this.onDelete,
      required this.onEdit})
      : super(key: key);

  @override
  /*
  "createState()" é um método abstrato que retorna uma instância de State que é
  usada pelo flutter para construir a interface de usuário do widget. O tipo
  _UserListViewState indica que o estado retornado por esse método é 
  específico para o widget UserListView.
  "=> _UserListViewState()", permite retornar o resultado de uma expressão
  diretamente. Nesse caso, ele está retornando uma nova instância de 
  _UserListViewState().
  */
  _UserListViewState createState() => _UserListViewState();
}

class _UserListViewState extends State<UserListView> {
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
      itemCount: widget.users.length,
      /*
      função chamada para cada item na lista, dentro da função, definimos
      como cada item deve ser construído
      */
      itemBuilder: (context, index) {
        //obtém o usuário atual usando o index
        /*
        "widget." é uma referência ao widget pai que permite acessar seus
        objetos e métodos visto que esses métodos estão inacessíveis para a 
        classe atual
        */
        final user = widget.users[index];
        /*
        ListTile é um widget que representa um item de lista como um título,
        subtítulo e um ícone de ação
        */
        return ListTile(
            //define os atributos a serem exibidos
            title: Text(user.name),
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
                  onPressed: () => widget.onDelete(user.id),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  /*
                  aciona a função onEdit quando pressionado passando id do user 
                  como parâmetro
                  */
                  onPressed: () {
                    //cria uma caixa de diálogo quando o botão for pressionado
                    showDialog(
                        //passamos o contexto atual
                        context: context,
                        builder: (BuildContext context) {
                          //Cria uma caixa de diálogo (dentro da outra)
                          return AlertDialog(
                            //passando o widget/classe UserEditForm como content
                            content: UserEditForm(
                              /*
                              recebe o usuário atual e a função (solicitadas 
                              como parâmetro) 
                              */
                              user: user,
                              onEdit: (name, email, id) {
                                //acessa a função onEdit do widget pai
                                widget.onEdit(id, name, email);
                                /*print(
                                  'Name: ${user.name}\nEmail: ${user.email}',
                                );*/
                                /*
                                retorna para o contexto anterior (
                                user_list_view), uma vez que quando pressionamos
                                o ícone de edição, uma nova view se abriu
                                (user_edit_form), empilhando-se sobre a
                                user_list_view e para voltar para a tela atual,
                                precisamos desempilhar e a linha abaixo faz isso 
                                */
                                Navigator.of(context).pop();
                              },
                            ),
                          );
                        });
                  },
                )
              ],
            ));
      },
    );
  }
}
