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

  Future<void> _updateName() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.value.updateEmailUser(
          oldEmail: authService.value.currentUser!.email as String,
          newEmail: _newEmail.text,
          password: _password.text
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('revisa tu correo para continuar con el cambio'))
        );

        Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProfileData()),
          );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.toString()}')),
        );
      }
    }
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
            "Cambiar correo",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: authService.value.currentUser!.email),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0), 
              ),
            ),
          ),
          inputFile(
            label: "nuevo correo",
            controller: _newEmail,
          ),
          inputFile(
            label: "contraseña",
            controller: _password,
            obscureText: true
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _updateName,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Actualizar correo", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}
}