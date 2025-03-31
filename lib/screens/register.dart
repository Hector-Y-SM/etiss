import 'package:app/widgets/auth/register/register_form.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Fondo oscuro
      body: Stack(
        children: [
          // Formulario de registro
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: RegisterForm(
              nameDefault: "",
              lastDefault: "",
              email: "",
            ),
          ),
          // Flecha de regreso
          Positioned(
            top: 20,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Color.fromARGB(255, 0, 0, 0), // Color de la flecha
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
