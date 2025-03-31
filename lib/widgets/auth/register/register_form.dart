import 'package:app/widgets/input_file.dart';
import 'package:flutter/material.dart';
import 'package:app/screens/login.dart';
import 'package:app/models/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterForm extends StatefulWidget {
  final String nameDefault;
  final String lastDefault;
  final String email;

  const RegisterForm({super.key, required this.nameDefault, required this.lastDefault, required this.email});

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _errorMessage;
  @override
  void initState() {
    super.initState();
    _nameController.text = widget.nameDefault;
    _lastNameController.text = widget.lastDefault;
    _emailController.text = widget.email;
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _errorMessage = null;
      });

      try {
        await authService.value.createAccount(
          email: _emailController.text,
          password: _passwordController.text,
          name: _nameController.text,
          lastName: _lastNameController.text,
        );

        setState(() {
          _errorMessage = 'Usuario creado exitosamente';
        });

        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _errorMessage = null;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        });
      } on FirebaseAuthException catch (e) {
        print('error ${e.code}');
        setState(() {
          _errorMessage = _getError(e.code);
        });
      }
    }
  }

  String _getError(String errorCode) {
    switch (errorCode) {
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'email-already-in-use':
        return 'El correo electrónico ya esta registrado en otra cuenta';
      case 'too-many-requests':
        return 'Demasiados intentos. Intenta más tarde.';
      case 'weak-password':
        return 'Contraseña no valida. Se requiere al menos 6 caracteres';
      default:
        return 'Error. Intenta mas tarde nuevamente.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Card(
          elevation: 8, // Sombra del card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Bordes redondeados
          ),
          color: const Color.fromARGB(204, 255, 255, 255), // Fondo blanco con transparencia
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Espaciado interno del card
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Título "Registrar"
                  Text(
                    "Registrar",
                    style: GoogleFonts.roboto(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Letras negras
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Campo de nombre
                  InputFile(
                    label: "Nombre",
                    controller: _nameController,
                  ),
                  const SizedBox(height: 12),
                  // Campo de apellido
                  InputFile(
                    label: "Apellido",
                    controller: _lastNameController,
                  ),
                  const SizedBox(height: 12),
                  // Campo de correo electrónico
                  InputFile(
                    label: "Correo electrónico",
                    controller: _emailController,
                  ),
                  const SizedBox(height: 12),
                  // Campo de contraseña
                  InputFile(
                    label: "Contraseña",
                    controller: _passwordController,
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  // Botón de Registrar
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: _register,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black), // Borde negro
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Registrar",
                      style: TextStyle(
                        color: Colors.black, // Letras negras
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Mensaje de error o éxito
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: _errorMessage == 'Usuario creado exitosamente'
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
              color: Colors.black, // Letras negras
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            style: const TextStyle(
              color: Colors.black, // Texto dentro del campo en negro
            ),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 10,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Borde negro
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black), // Borde negro
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
