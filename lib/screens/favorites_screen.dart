import 'package:app/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app/models/ss_favorites.dart';
import 'package:app/models/social_service.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Favoritos",
          style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const CustomDrawer(),
      body: ValueListenableBuilder<SsFavorites>(
        valueListenable: firebase_service_social,
        builder: (context, ssFavorites, child) {
          if (ssFavorites.userFav.isEmpty) {
            return const Center(
              child: Text(
                "No tienes servicios favoritos aún.",
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: ssFavorites.userFav.length,
            itemBuilder: (context, index) {
              var service = ssFavorites.userFav[index];
              return _buildFavoriteCard(context, service);
            },
          );
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, SocialService service) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(service),
            const SizedBox(height: 10),
            _buildDetailRow(Icons.apartment, "Departamento", service.departamento),
            _buildDetailRow(Icons.person, "Responsable", service.responsable),
            _buildDetailRow(Icons.email, "Email", service.email),
            const SizedBox(height: 10),
            _buildRemoveFavoriteButton(context, service),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(SocialService service) {
    return Text(
      service.nombre,
      style: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "$label: $value",
              style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoveFavoriteButton(BuildContext context, SocialService service) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: () {
          firebase_service_social.value.removeFavorite(service);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("${service.nombre} eliminado de favoritos")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => FavoritesScreen()),
          );
        },
        icon: const Icon(Icons.remove_circle, color: Colors.white),
        label: Text(
          "Eliminar de Favoritos",
          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }
}
