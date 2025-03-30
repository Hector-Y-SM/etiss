import 'package:app/models/auth_service.dart';
import 'package:app/widgets/input_file.dart';
import 'package:flutter/material.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  final _formKey = GlobalKey<FormState>();
  final _newName = TextEditingController();
  final _newLastName = TextEditingController();

  Future<void> _updateName() async {
    if (_formKey.currentState!.validate()) {
      try {
        await authService.value.updateUserName(
          name: _newName.text,
          lastName: _newLastName.text,
          username: '${_newName.text} ${_newLastName.text}'
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nombre actualizado correctamente')),
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
            "Cambiar nombre de usuario",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          inputFile(
            label: "Nuevo nombre",
            controller: _newName,
          ),
          inputFile(
            label: "Nuevo segundo nombre",
            controller: _newLastName,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _updateName,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black, 
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              minimumSize: const Size(double.infinity, 50),
            ),
            child: const Text("Actualizar nombre", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    ),
  );
}

}