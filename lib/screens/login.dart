import 'package:app/widgets/auth/signIn/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Sesión'),backgroundColor: const Color.fromRGBO(157, 169, 186, 1)),
      backgroundColor: const Color.fromRGBO(157, 169, 186, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LoginForm(),
      ),
    );
  }
}
