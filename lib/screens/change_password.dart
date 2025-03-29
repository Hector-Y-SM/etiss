import 'package:app/models/auth_service.dart';
import 'package:app/screens/change_email_screen.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final List<Widget> pages = [
    const ProfileData(),
    const ChangePasswordScreen(),
    const ChangeEmailScreen()
  ];

  final List<IconData> sectionIcons = [
    Icons.person,
    Icons.lock,
    Icons.mail
  ];
  
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

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Contraseña actualizada correctamente')),
        );

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cambiar Contraseña")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              inputFile(
                label: "Antigua contraseña",
                controller: _oldPasswordController,
                obscureText: true,
              ),
              inputFile(
                label: "Nueva contraseña",
                controller: _newPasswordController,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _updatePassword,
                child: const Text("Actualizar contraseña"),
              ),
              const SizedBox(height: 16),
              NavigationButtons(
                    pages: pages,
                    icons: sectionIcons,
                    currentIndex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget inputFile({
    required String label,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) => value == null || value.isEmpty ? 'Por favor ingresa $label' : null,
      ),
    );
  }
}
