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
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo gris oscuro
      body: Stack(
        children: [
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
          // Formulario de recuperación de contraseña
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ForgotPasswordForm(),
          ),
        ],
      ),
    );
  }
}