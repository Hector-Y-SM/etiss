import 'package:app/models/auth_service.dart';
import 'package:app/screens/forgot_password.dart';
import 'package:app/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      } on FirebaseAuthException catch (e) {
        print('error ${e.code}');
        setState(() {
          _errorMessage = _getError(e.code);
        });
      } catch (errorCode) {
        setState(() {
          _errorMessage = 'Error inesperado.Intente mas tarde por favor';
        });
      }
    }
  }

  String _getError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'user-not-found':
        return 'No se encontró una cuenta con este correo.';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'invalid-credential':
        return 'Contraseña incorrecta';
      default:
        return 'Error al iniciar sesión. Intenta nuevamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 8, // Sombra del card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados
        ),
        color: const Color.fromRGBO(
          62,
          75,
          81,
          0.8,
        ), // Fondo gris con transparencia
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Espaciado interno del card
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Título "Iniciar sesión"
                Text(
                  "Iniciar sesión",
                  style: GoogleFonts.roboto(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Letras blancas
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de correo electrónico
                inputFile(
                  label: "Correo electrónico",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Campo de contraseña
                inputFile(
                  label: "Contraseña",
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                // Centrar el enlace de "¿Olvidaste tu contraseña?"
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      "¿Olvidaste tu contraseña?",
                      style: TextStyle(
                        color: Colors.white, // Color blanco
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Botón de Iniciar Sesión
                MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: _login,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white), // Borde blanco
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white, // Letras blancas
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Mensaje de _errorMessage o éxito
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(
                        color:
                            _errorMessage == 'Inicio de sesión exitoso'
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
    );
  }

  // Widget para los campos de entrada
  Widget inputFile({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: GoogleFonts.roboto(
              color: Colors.white70, // Letras blancas con opacidad
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Colors.white,
            ), // Texto dentro del campo en blanco
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[400]!),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingresa $label';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
