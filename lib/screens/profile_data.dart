import 'package:app/models/auth_service.dart';
import 'package:app/screens/home.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo gris oscuro
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
      ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                elevation: 8, // Sombra del card
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20), // Bordes redondeados
                ),
                color: const Color.fromRGBO(62, 75, 81, 0.8), // Fondo translúcido
                child: Padding(
                  padding: const EdgeInsets.all(20.0), // Espaciado interno del card
                  child: isEditingPassword ? _buildPasswordChangeView() : _buildProfileView(),
                ),
              ),
            ),
    );
  }

  Widget _buildProfileView() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Título "Perfil"
          Text(
            "Datos de la cuenta",
            style: GoogleFonts.roboto(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white, // Letras blancas
            ),
          ),
          const SizedBox(height: 20),
          // Campo de nombre
          inputFile(
            label: "Nombre",
            controller: _nameController,
          ),
          const SizedBox(height: 16),
          // Campo de apellido
          inputFile(
            label: "Apellido",
            controller: _lastNameController,
          ),
          const SizedBox(height: 16),
          // Campo de correo electrónico (solo lectura)
          inputFile(
            label: "Correo electrónico",
            controller: _emailController,
            readOnly: true,
          ),
          const SizedBox(height: 24),
          // Botón de actualizar
          MaterialButton(
            minWidth: double.infinity,
            height: 60,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                try {
                  await authService.value.updateUserProfile(
                    name: _nameController.text,
                    lastName: _lastNameController.text,
                    email: _emailController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perfil actualizado correctamente'),
                    ),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const Home()),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.toString())),
                  );
                }
              }
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white), // Borde blanco
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              "Actualizar",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white, // Letras blancas
              ),
            ),
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
        inputFile(
          label: "antigua contraseña",
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

  // Widget para los campos de entrada
  Widget inputFile({
    required String label,
    required TextEditingController controller,
    bool readOnly = false,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
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
            readOnly: readOnly,
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