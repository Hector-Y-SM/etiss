import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/offer_list.dart';
import 'package:flutter/material.dart';
class SocialServiceScreen extends StatefulWidget {
  const SocialServiceScreen({super.key});

  @override
  State<SocialServiceScreen> createState() => _SocialServiceScreenState();
}

class _SocialServiceScreenState extends State<SocialServiceScreen> {

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
