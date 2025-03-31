import 'package:app/models/auth_service.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/widgets/input_file.dart';
import 'package:flutter/material.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newEmail = TextEditingController();
  final _password = TextEditingController();

  Future<void> _updateEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.value.updateEmailUser(
          oldEmail: authService.value.currentUser!.email as String,
          newEmail: _newEmail.text,
          password: _password.text,
        );

        _showSnackBar(
          'Correo actualizado correctamente',
          const Color.fromARGB(255, 26, 184, 31),
        );

        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfileData()),
        );
      } catch (e) {
        _showSnackBar(_getError(e.toString()), Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: color),
    );
  }

  String _getError(String errorCode) {
    switch (errorCode) {
      case 'Exception: error [firebase_auth/invalid-new-email] Error':
        return 'El correo electrónico no es válido.';
      case 'Exception: error [firebase_auth/too-many-requests]':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'Exception: error [firebase_auth/invalid-credential]':
        return 'Contraseña no válida. Se requiere al menos 6 caracteres.';
      default:
        return 'Error. Intenta más tarde nuevamente.';
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingrese un correo válido';
    }
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    if (!emailRegex.hasMatch(value)) {
      return 'El formato del correo no es válido';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == '') {
      return 'por favor ingresa tu contraseña';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const Text(
                "Cambiar correo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                readOnly: true,
                controller: TextEditingController(
                  text: authService.value.currentUser!.email,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
<<<<<<< HEAD
              const SizedBox(height: 10),
              InputFile(
                label: "Nuevo correo",
                controller: _newEmail,
                validator: _validateEmail,
              ),
              InputFile(
                label: "Contraseña",
                controller: _password,
                obscureText: true,
                validator: _validatePassword,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updateEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Actualizar correo",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
=======
            ),
          ),
        );
      },
>>>>>>> d733c0e (Resolviendo conflictos)
    );
  }
}
