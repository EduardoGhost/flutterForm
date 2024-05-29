import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/users.dart';

class userForm extends StatelessWidget{

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  userForm({super.key});

  void _loadFormData(User? user) {
    if (user != null) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)?.settings.arguments as User?;
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Usuários"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final isValid = _form.currentState!.validate();

              if (isValid) {
                _form.currentState?.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'] ?? '',
                    name: _formData['name'] ?? '',
                    email: _formData['email'] ?? '',
                    avatarUrl: _formData['avatarUrl'] ?? '',
                  ),
                );

                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
              TextFormField(
                initialValue: _formData['name'],
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Nome inválido";
                  }
                  if (value.trim().length < 3) {
                    return 'Nome muito curto';
                  }
                  return null;
                },
                onSaved: (value) => _formData['name'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Email inválido";
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return "Email inválido";
                  }
                  return null;
                },
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarUrl'],
                decoration: InputDecoration(labelText: "URL do Avatar"),
                onSaved: (value) => _formData['avatarUrl'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
