import 'package:app/screens/login.dart';
import 'package:app/screens/social_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/models/auth_service.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/practices.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/screens/residences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Hola ${authService.value.currentUser!.displayName}'),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Página principal',
            onTap: () => _navigateTo(context, const Home()),
          ),
          _buildDrawerItem(
            icon: Icons.account_circle_rounded,
            text: 'Perfil',
            onTap: () => _navigateTo(context, const ProfileData()),
          ),
          _buildDrawerItem(
            icon: Icons.supervised_user_circle,
            text: 'Servicio social',
            onTap: () => _navigateTo(context, const SocialServiceScreen()),
          ),
          _buildDrawerItem(
            icon: Icons.precision_manufacturing_outlined,
            text: 'Prácticas',
            onTap: () => _navigateTo(context, const Practices()),
          ),
          _buildDrawerItem(
            icon: Icons.home_repair_service,
            text: 'Residencias',
            onTap: () => _navigateTo(context, const Residences()),
          ),
          _buildDrawerItem(
            icon: Icons.home_repair_service,
            text: 'cerrar sesion',
            onTap: () => _navigateTo(context, LoginScreen(), authService.value.signOut()),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String text, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }

  void _navigateTo(BuildContext context, Widget screen, [Future<void>? auth]) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
