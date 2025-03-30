import 'package:app/screens/practices.dart';
import 'package:app/screens/residences.dart';
import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/offer_list.dart';
import 'package:flutter/material.dart';
class SocialServiceScreen extends StatefulWidget {
  const SocialServiceScreen({super.key});

  @override
  State<SocialServiceScreen> createState() => _SocialServiceScreenState();
}

class _SocialServiceScreenState extends State<SocialServiceScreen> {
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
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Servicios Sociales")),
      drawer: const CustomDrawer(),
      body: OfferList(coleccion: 'social'),
    );
  }
}
