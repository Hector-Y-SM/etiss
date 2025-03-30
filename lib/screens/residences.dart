import 'package:app/screens/practices.dart';
import 'package:app/screens/social_service_screen.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/offer_list.dart';
import 'package:flutter/material.dart';

class Residences extends StatefulWidget {
  const Residences({super.key});

  @override
  State<Residences> createState() => _ResidencesState();
}


class _ResidencesState extends State<Residences> {
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
      appBar: AppBar(title: const Text("residencias")),
      drawer: const CustomDrawer(),
      body: OfferList(coleccion: 'residencias'),
    );
  }
}