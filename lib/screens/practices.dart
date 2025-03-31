import 'package:app/widgets/custom_drawer.dart';
import 'package:app/widgets/offer_list.dart';
import 'package:flutter/material.dart';

class Practices extends StatefulWidget {
  const Practices({super.key});

  @override
  State<Practices> createState() => _PracticesState();
}

class _PracticesState extends State<Practices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('practicas'),),
      drawer: const CustomDrawer(), 
      body: OfferList(coleccion: 'practicas'),
    );
  }
}