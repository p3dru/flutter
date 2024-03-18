import 'dart:collection';
import 'package:user_mvc/model/user.dart';

class UserController {
  final List<User> _users = [];

  UnmodifiableListView<User> get users => UnmodifiableListView(_users);

  void addUser(User user) {
    _users.add(user);
  }

  void removeUser(String id) {
    _users.removeWhere((user) => user.id == id);
  }

  void updateUser(String id, String name, String email) {
    final index = _users.indexWhere((user) => user.id == id);
    if (index != -1) {
      _users[index] = User(id: id, name: name, email: email);
    }
  }
}
