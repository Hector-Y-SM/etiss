import 'package:app/models/auth_service.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/widgets/input_file.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  Future<void> _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.value.updateUserPassword(
          currentPassword: _oldPasswordController.text,
          newPassword: _newPasswordController.text,
        );

        _showSnackBar(
          'Contraseña actualizada correctamente',
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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: color));
  }

  String _getError(String errorCode) {
    switch (errorCode) {
      case 'Exception: error [firebase_auth/invalid-credential] The supplied auth credential is incorrect, malformed or has expired.':
        return 'Contraseña antigua incorrecta.';
      case 'Exception: error [firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'Exception: error [firebase_auth/weak-password] Password should be at least 6 characters':
        return 'La nueva contraseña debe tener al menos 6 caracteres.';
      default:
        return 'Error. Intenta más tarde nuevamente.';
    }
  }

  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Ingresa tu contraseña actual.';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.length < 6) {
      return 'La nueva contraseña debe tener al menos 6 caracteres.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,
      ),
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
              "Cambiar Contraseña",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            inputFile(
              label: "Antigua contraseña",
              controller: _oldPasswordController,
              obscureText: true,
              validator: _validateOldPassword,
            ),
            inputFile(
              label: "Nueva contraseña",
              controller: _newPasswordController,
              obscureText: true,
              validator: _validateNewPassword,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updatePassword,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                "Actualizar contraseña",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
