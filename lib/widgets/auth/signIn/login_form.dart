import 'package:app/auth_service.dart';
import 'package:app/screens/home.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _errorMessage;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
      });

      try {
        await authService.value.signIn(
          email: _emailController.text,
          password: _passwordController.text,
        );

        setState(() {
          _errorMessage = 'Inicio de sesión exitoso';
        });

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        });
      } catch (e) {
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
            decoration: const InputDecoration(labelText: 'Correo electrónico'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu correo electrónico';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Contraseña'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa tu contraseña';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: _login, child: const Text('Iniciar sesión')),
          if (_errorMessage != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                _errorMessage!,
                style: TextStyle(
                  color: _errorMessage == 'Inicio de sesión exitoso'
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
