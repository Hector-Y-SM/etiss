import 'package:app/models/auth_service.dart';
import 'package:app/screens/change_email_screen.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/change_password.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/navigation_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
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
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  bool isLoading = true;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
      ),
      drawer: const CustomDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.amberAccent,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildProfileView(),
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
          Text(
            "Datos de la cuenta",
            style: GoogleFonts.roboto(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          inputFile(label: "Nombre", controller: _nameController),
          const SizedBox(height: 16),
          inputFile(label: "Apellido", controller: _lastNameController),
          const SizedBox(height: 16),
          inputFile(
            label: "Correo electrónico",
            controller: _emailController,
            readOnly: true,
          ),
          const SizedBox(height: 24),
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
                    const SnackBar(content: Text('Perfil actualizado correctamente')),
                  );

                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              }
            },
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(50),
            ),
            child: const Text(
              "Actualizar",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
            ),
          ),
          const SizedBox(height: 16),
            NavigationButtons(
                  pages: pages,
                  icons: sectionIcons,
                  currentIndex: 0,
            )
        ],
      ),
    );
  }

 Widget inputFile({
  required String label,
  required TextEditingController controller,
  bool obscureText = false,
  bool readOnly = false, 
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? 'Por favor ingresa $label' : null,
    ),
  );
}

}
