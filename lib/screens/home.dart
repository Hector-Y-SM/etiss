import 'package:app/auth_service.dart';
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
      backgroundColor: Color.fromRGBO(62, 75, 81, 1),
      appBar: AppBar(backgroundColor: Color.fromRGBO(62, 75, 81, 1)),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          children: [
            Image.asset('assets/images/home.png'),
            Text(
              'Bienvenido al nido ${authService.value.currentUser!.displayName}',
              style: GoogleFonts.dancingScript(
                fontWeight: FontWeight.bold,
                fontSize: 40, // Tamaño más grande para destacar
                color: Colors.white, // Letras blancas
              ),
            ),
          ],
        ),
      ),
    );
  }
}
