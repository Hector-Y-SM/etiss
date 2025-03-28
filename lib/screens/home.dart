import 'package:app/models/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(62, 75, 81, 1), // Fondo gris oscuro
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(62, 75, 81, 1),
        elevation: 0, // Sin sombra
      ),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centrar verticalmente
          children: [
            // Imagen decorativa
            Image.asset(
              'assets/images/home.png',
              height: 200, // Ajusta el tamaño de la imagen
            ),
            const SizedBox(height: 20), // Espaciado entre la imagen y el texto
            // Texto de bienvenida
            Text(
              'Bienvenido al nido',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 36, // Tamaño grande para destacar
                color: Colors.white, // Letras blancas
              ),
            ),
            const SizedBox(height: 10), // Espaciado entre las líneas de texto
            Text(
              '${authService.value.currentUser!.displayName}',
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 28, // Tamaño más pequeño para el nombre
                color: Colors.white70, // Letras en blanco tenue
              ),
            ),
          ],
        ),
      ),
    );
  }
}
