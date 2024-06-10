import 'package:flutter/material.dart';
import '../data/UserRepository.dart';
import '../models/user.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  void _submitLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      String email = _emailController.text;
      String password = _passwordController.text;

        //Login de usuario padrao
      if (email == 'edu@bol.com' && password == 'senha123') {
        // Login bem-sucedido
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Verificar no banco de dados
        User? user = await _userRepository.getUserByEmail(email);
        if (user != null && user.password == password) {
          // Login bem-sucedido
          Navigator.of(context).pushReplacementNamed('/home');
        } else {
          // Mensagem de erro
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text('Erro de Login'),
              content: Text('Usuário ou senha incorretos'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                ),
              ],
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira seu email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Por favor, insira um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira sua senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitLogin,
                child: Text('Login'),
              ),
              TextButton(
                //ir para formulario
                onPressed: () {
                  Navigator.of(context).pushNamed('/user-form');
                },
                child: Text('Não tem uma conta? Registre-se'),
              ),
              TextButton(
                //ir para formulario
                onPressed: () {
                  Navigator.of(context).pushNamed('/home');
                },
                child: Text('Entrar como visitante'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
