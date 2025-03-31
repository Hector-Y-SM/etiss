import 'package:app/screens/login.dart';
import 'package:app/screens/social_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/models/auth_service.dart';
import 'package:app/screens/home.dart';
import 'package:app/screens/favorites_screen.dart';
import 'package:app/screens/practices.dart';
import 'package:app/screens/profile_data.dart';
import 'package:app/screens/residences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white, 
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.transparent, 
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: Column(
              children: <Widget>[
                Text(
                  'Bienvenido ${authService.value.currentUser!.displayName}',
                  style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                _buildDrawerItem(
                  icon: Icons.edit,
                  text: 'Editar perfil',
                  onTap: () => _navigateTo(context, const ProfileData()),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.home,
            text: 'Página principal',
            onTap: () => _navigateTo(context, const Home()),
          ),
          _buildDrawerItem(
            icon: Icons.room_service_outlined,
            text: 'Servicio Social',
            onTap: () => _navigateTo(context, const SocialServiceScreen()),
          ),
          _buildDrawerItem(
            icon: Icons.playlist_add_check_circle_outlined,
            text: 'Prácticas',
            onTap: () => _navigateTo(context, const Practices()),
          ),
          _buildDrawerItem(
            icon: Icons.reset_tv_outlined,
            text: 'Residencias',
            onTap: () => _navigateTo(context, const Residences()),
          ),
          _buildDrawerItem(
            icon: Icons.star,
            text: 'Favoritos',
            onTap: () => _navigateTo(context, FavoritesScreen()),
          ),
          const Divider(
            color: Colors.black26,
            height: 20,
            thickness: 0.5,
            indent: 20,
            endIndent: 20,
          ),
          _buildDrawerItem(
            icon: Icons.logout_outlined,
            text: 'Cerrar sesión',
            onTap: () => _navigateTo(context, LoginScreen(), authService.value.signOut()),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.black,
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget screen, [Future<void>? action]) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
