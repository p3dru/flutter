import 'package:flutter/material.dart';
import 'package:user_mvc/model/user.dart';

class UserForm extends StatefulWidget {
  final Function(String, String, String) onSubmit;

  const UserForm({super.key, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) => setState(() => _name = value),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) => setState(() => _email = value),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  widget.onSubmit(_name, _email, DateTime.now().toString());
                }
              },
              child: Text('Add'),
            )
          ],
        ));
  }
}
