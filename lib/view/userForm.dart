import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/users.dart';

class userForm extends StatelessWidget{

  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  userForm({super.key});

  void _loadFormData(User user){
    if(user != null){
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatarUrl'] = user.avatarUrl;
    }
  }

  @override
  Widget build(BuildContext context){
   final user = ModalRoute.of(context)?.settings.arguments as User;
        // != null ? null:ModalRoute.of(context)?.settings.arguments as User;
   //  final arguments = ModalRoute.of(context)!.settings.arguments;
   //  final user = arguments as User;
     // print(user);
    _loadFormData(user);

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de Usuarios"),
        actions: <Widget>[IconButton(
          icon: Icon(Icons.save),
            onPressed: () {
          final isValid = _form.currentState!.validate();

          if(isValid){
            _form.currentState?.save();

            Provider.of<Users>(context, listen: false).put(
                User(
                  _formData['id'] != null ? _formData['id']! : '',
                  _formData['name'] != null ? _formData['name']! : '',
                  _formData['email'] != null ? _formData['email']! : '',
                  _formData['avatarUrl'] != null ? _formData['avatarUrl']! : '',
            ),
            );
            Navigator.of(context).pop();
          }
            },
            ),
        ],
      ),
      body:  Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: <Widget>[
            TextFormField(
              initialValue: _formData['name'],
              decoration: InputDecoration(labelText: "Nome"),
              validator: (value){
                if(value == null || value.trim().isEmpty){
                  return "Nome invalido";
                }
                if(value.trim().length < 3){
                  return 'Nome curto';
                }
                return null;
    },
              onSaved: (value) => _formData['name'] = value!,
            ),
            TextFormField(
              initialValue: _formData['email'],
              decoration: InputDecoration(labelText: "Email"),
              onSaved: (value) => _formData['email'] = value!,
            ),
            TextFormField(
              initialValue: _formData['avatarUrl'],
              decoration: InputDecoration(labelText: "URL de avatar"),
              onSaved: (value) => _formData['avatarUrl'] = value!,
            ),
          ],
        ),
    ),
      ),
    );

  }

}