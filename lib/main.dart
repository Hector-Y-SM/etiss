import 'package:app/screens/login.dart';
import 'package:app/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo oscuro
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Bienvenido albatro",
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.white, // Letras blancas
                    ),
                  ),
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/albatro_bienvenida.png"),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "Elige una opción para continuar.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: Colors.white70, // Letras blancas con opacidad
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Botón de Iniciar Sesión
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
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
                  // Botón de Registrarse
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      );
                    },
                    color: const Color(0xFF1B396A), // Azul oscuro
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Text(
                      "Registrarse",
                      style: TextStyle(
                        color: Colors.white, // Letras blancas
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
