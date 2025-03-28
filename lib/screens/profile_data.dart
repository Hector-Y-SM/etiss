import 'package:app/models/auth_service.dart';
import 'package:app/screens/home.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  bool isLoading = true;
  bool isEditingPassword = false;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    var profile = await authService.value.getUserProfile();
    if (profile != null) {
      setState(() {
        _nameController.text = profile['name'];
        _lastNameController.text = profile['lastName'];
        _emailController.text = profile['email'];
        isLoading = false;
      });
    }
  }

  Future<void> _updatePassword() async {
    try {
      await authService.value.updateUserPassword(
        currentPassword: _oldPasswordController.text,
        newPassword: _newPasswordController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contraseña actualizada correctamente')),
      );
      setState(() {
        isEditingPassword = false; 
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Perfil")),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) 
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: isEditingPassword ? _buildPasswordChangeView() : _buildProfileView(),
            ),
    );
  }

  Widget _buildProfileView() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) => value == null || value.isEmpty ? 'Por favor ingresa tu nombre' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Apellido',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            validator: (value) => value == null || value.isEmpty ? 'Por favor ingresa tu apellido' : null,
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Correo electrónico',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            readOnly: true, 
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await authService.value.updateUserProfile(
                    name: _nameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                  );
                  
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Perfil actualizado correctamente')),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
            child: const Text("Actualizar"),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () {
              setState(() {
                isEditingPassword = true; 
              });
            },
            child: const Text("Cambiar contraseña"),
          ),
        ],
      ),
    );
  }


  Widget _buildPasswordChangeView() {
    return Column(
      children: [
        TextFormField(
          controller: _oldPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'antigua contraseña',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Ingresa una contraseña' : null,
        ),
        TextFormField(
          controller: _newPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Nueva contraseña',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          validator: (value) => value == null || value.isEmpty ? 'Ingresa una contraseña' : null,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _updatePassword,
          child: const Text("Actualizar contraseña"),
        ),
        const SizedBox(height: 16),
        TextButton(
          onPressed: () {
            setState(() {
              isEditingPassword = false; 
            });
          },
          child: const Text("Volver"),
        ),
      ],
    );
  }
}