import 'package:app/models/auth_service.dart';
import 'package:app/models/social_service.dart';
import 'package:app/models/ss_favorites.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfferList extends StatefulWidget {
  final String coleccion;
  const OfferList({super.key, required this.coleccion});

  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getDataSS(widget.coleccion);
  }

  Future<void> _getDataSS(String categoria) async {
    try {
      final data = await authService.value.firestore.collection(categoria).get();
      List<SocialService> newList =
          data.docs.map((x) => SocialService.fromMap(x.data())).toList();

      firebase_service_social.value.list.clear();
      firebase_service_social.value.list.addAll(newList);
      firebase_service_social.notifyListeners();
    } catch (e) {
      print("Error al obtener datos: $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<SsFavorites>(
      valueListenable: firebase_service_social,
      builder: (context, ssFavorites, child) {
        if (_isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (ssFavorites.list.isEmpty) {
          return const Center(child: Text("No hay servicios disponibles."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: ssFavorites.list.length,
          itemBuilder: (context, index) {
            var service = ssFavorites.list[index];
            return _buildServiceCard(service);
          },
        );
      },
    );
  }

  Widget _buildServiceCard(SocialService service) {
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
            _buildDetailRow(Icons.flag, "Objetivo", service.objetivo),
            _buildDetailRow(Icons.apartment, "Departamento", service.departamento),
            _buildDetailRow(Icons.person, "Responsable", service.responsable),
            _buildDetailRow(Icons.email, "Email", service.email),
            _buildDetailRow(Icons.people, "Tipo de Alumnos", service.tipoAlumnos.join(', ')),
            const SizedBox(height: 10),
            _buildInteractionButton(service),
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

  Widget _buildInteractionButton(SocialService service) {
    return Align(
      alignment: Alignment.centerRight,
      child: ElevatedButton.icon(
        onPressed: () => _showInteractionModal(service),
        icon: const Icon(Icons.touch_app, color: Colors.white),
        label: const Text(""),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        ),
      ),
    );
  }

  void _showInteractionModal(SocialService service) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text("Nombre: ${service.nombre}", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
              Text("Departamento: ${service.departamento}", style: GoogleFonts.poppins(fontSize: 16)),
              Text("Responsable: ${service.responsable}", style: GoogleFonts.poppins(fontSize: 16)),
              Text("Email: ${service.email}", style: GoogleFonts.poppins(fontSize: 16, color: Colors.blueAccent)),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLikeButton(service),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLikeButton(SocialService service) {
  return ElevatedButton.icon(
    onPressed: () {
      firebase_service_social.value.addFavorite(service); 
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${service.nombre} agregado a favoritos")),
      );
    },
    icon: const Icon(Icons.thumb_up, color: Colors.white), 
    label: const Text(
      "agregar a favoritos",
      style: TextStyle(color: Colors.white),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.green, 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    ),
  );
}

}
