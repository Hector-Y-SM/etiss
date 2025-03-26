import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class Residences extends StatefulWidget {
  const Residences({super.key});

  @override
  State<Residences> createState() => _ResidencesState();
}

class _ResidencesState extends State<Residences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(), 
      body: Center(child: Text("residencias")),
    );
  }
}