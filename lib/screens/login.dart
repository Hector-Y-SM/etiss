import 'package:app/widgets/auth/signIn/login_form.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo oscuro
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LoginForm(),
          ),
          // Flecha de regreso
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white, // Color de la flecha
              ),
              onPressed: () {
                Navigator.pop(context); // Regresa a la pantalla anterior
              },
            ),
          ),
        ],
      ),
    );
  }
}
