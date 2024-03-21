import 'dart:collection';
import 'package:user_mvc/model/user.dart';

//aqui criamos a classe que irá gerenciar os métodos da model
class UserController {
  /*
  Aqui criamos uma lista/array de usuários vazios;
  "final" é utilizado para variáveis imutáveis que podem ser
  atribuídas depois.
  */
  final List<User> _users = [];

  /*
  A linha abaixo, cria uma propriedade "getter" de nome users
  que retorna uma lista imutável dos usuários armazenados na
  variável _users.
  "UnmodifiableListView" é uma classe Flutter que cria uma lista
  imutável a partir de uma lista existente. A lista retornada é
  uma cópia somente de leitura da lista original, garantindo que os
  dados não possam ser diretamente modificados.
  "get users", é um método que permite acessar o valor de uma variável
  de maneira mais direta. Nesse exemplo, retorna uma lista imutável de
  usuários.
  "=>" é um operador que permite retornar o resultado de uma expressão
  diretamente.
  "=> UnmodifiableListView(_users)", aqui, basicamente está retornando 
  a lista imutável (somente leitura) para a propriedade "getter" users.
  */
  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  /*
  aqui adicionamos um usuário à lista de usuários, utilizando o modal
  user, criado anteriormente
  */
  void addUser(User user) {
    _users.add(user);
  }

  /*
  aqui, excluímos o usuário com uma cláusula where exclusiva de deleção
  Dart.
  */
  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);
  }

  /*
  Reatribuição de valores à um usuário específico, primeiramente pesquisando 
  o id do elemento e depois, reatribuindo valores. passados.
  */
  void updateUser(String id, String name, String email, Function callback) {
    //encontra o index do usuário na lista de usuários pelo id
    final index = _users.indexWhere((user) => user.id == id);
    //se encontrado
    if (index != -1) {
      //o usuário encontrado tem os dados substituídos pelos passados
      _users[index] = User(id: id, name: name, email: email);
      /*
      função callback para atualização do usuário. Útil para executar ações
      adicionais como atualizar a interface do usuário
      */
      callback();
    }
  }
}
