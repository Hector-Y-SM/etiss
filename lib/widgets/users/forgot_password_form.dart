import 'dart:core';

import 'package:app/models/auth_service.dart';
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;
  
  void _forgotPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
    });

    try {
      await authService.value.resetPassword(
        email: _emailController.text,
      );
      
      setState(() {
        _errorMessage = 'enlace enviado';
      });
      
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      });
    } catch(e) {
      setState(() {
        _errorMessage = 'Error al iniciar sesión. Verifica tus credenciales.';
      });
    }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black54),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _forgotPassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(215, 204, 254, 1),
              foregroundColor: const Color.fromRGBO(254, 254, 255, 1),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              'Enviar recuperacion',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: _errorMessage == 'enlace enviado correctamente'
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            ),
        ],
      ),
    );
  }


}