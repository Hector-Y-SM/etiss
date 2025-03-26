import 'package:app/widgets/users/forgot_password_form.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('recuperar contraseña'),backgroundColor: const Color.fromRGBO(157, 169, 186, 1)),
      backgroundColor: const Color.fromRGBO(157, 169, 186, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ForgotPasswordForm(),
      ),
    );
  }
}