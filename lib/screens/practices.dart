import 'package:app/screens/residences.dart';
import 'package:app/screens/social_service_screen.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/offer_list.dart';
import 'package:flutter/material.dart';

class Practices extends StatefulWidget {
  const Practices({super.key});

  @override
  State<Practices> createState() => _PracticesState();
}

class _PracticesState extends State<Practices> {
  final List<Widget> pages = [
    const SocialServiceScreen(),
    const Residences(),
    const Practices()
  ];

  final List<IconData> sectionIcons = [
    Icons.room_service_outlined,
    Icons.reset_tv_outlined,
    Icons.playlist_add_check_circle_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Prácticas',
          style: TextStyle(
            color: Colors.black, // Letras negras
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // Fondo blanco
        elevation: 0, // Sin sombra
        iconTheme: const IconThemeData(color: Colors.black), // Iconos negros
      ),
      drawer: const CustomDrawer(),
      body: OfferList(coleccion: 'practicas'),
    );
  }
}