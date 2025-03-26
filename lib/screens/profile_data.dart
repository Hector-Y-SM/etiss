import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class ProfileData extends StatefulWidget {
  const ProfileData({super.key});

  @override
  State<ProfileData> createState() => _ProfileDataState();
}

class _ProfileDataState extends State<ProfileData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const CustomDrawer(), 
      body: Center(child: Text("datos del usuario")),
    );
  }
}