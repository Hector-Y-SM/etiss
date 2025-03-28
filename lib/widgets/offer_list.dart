import 'package:app/models/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:app/models/social_service.dart';
import 'package:app/models/ss_favorites.dart';

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
    _getDataSS('${widget.coleccion}');
  }

  Future<void> _getDataSS(String categoria) async {
    try {
      final data = await authService.value.firestore.collection(categoria).get();
      List<SocialService> newList = data.docs.map((x) => SocialService.fromMap(x.data())).toList();
      
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
          itemCount: ssFavorites.list.length,
          itemBuilder: (context, index) {
            var service = ssFavorites.list[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("📌 ${service.nombre}",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text("🎯 Objetivo: ${service.objetivo}"),
                    Text("🏢 Departamento: ${service.departamento}"),
                    Text("👤 Responsable: ${service.responsable}"),
                    Text("📧 Email: ${service.email}"),
                    Text("👥 Tipo de Alumnos: \n${service.tipoAlumnos.join('\n')}"),
                    Text(service.categoria),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Icon(Icons.star),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
