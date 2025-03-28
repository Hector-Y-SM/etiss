import 'dart:core';

import 'package:app/models/auth_service.dart';
import 'package:app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      } catch (e) {
        setState(() {
          _errorMessage = 'Error al iniciar sesión. Verifica tus credenciales.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: const Color.fromRGBO(62, 75, 81, 1), // Fondo gris oscuro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 8.0,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Título "Recuperar contraseña" dentro del Card
                  Center(
                    child: Text(
                      "Recuperar contraseña",
                      style: GoogleFonts.roboto(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Letras blancas
                      ),
                    ),
                  ),
                  const SizedBox(height: 24), // Más espacio debajo del título
                  // Label y subtítulo
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                
                        const SizedBox(height: 8.0), // Más espacio entre el label y el subtítulo
                        Text(
                          'Ingresa tu correo electrónico',
                          style: const TextStyle(
                            color: Colors.white70, // Texto en blanco tenue
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0), // Espaciado entre el subtítulo y el campo de texto
                  // Campo de texto
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo gris oscuro
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white), // Bordes blancos
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white), // Bordes blancos al estar habilitado
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white), // Bordes blancos al enfocar
                      ),
                    ),
                    style: const TextStyle(color: Colors.white), // Texto del input en blanco
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor ingresa tu correo electrónico';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24), // Más espacio antes del botón
                  // Botón de recuperación
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: _forgotPassword,
                    color: const Color(0xFF1B396A), // Azul oscuro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      'Enviar recuperación',
                      style: TextStyle(
                        color: Colors.white, // Letras blancas
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: _errorMessage == 'enlace enviado'
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}