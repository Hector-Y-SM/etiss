import 'package:app/models/auth_service.dart';
import 'package:app/models/social_service.dart';
import 'package:app/models/ss_favorites.dart';
import 'package:app/widgets/custom_drawer.dart';
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
    _getDataSS(); 
  }

  Future<void> _getDataSS() async {
    final data = await authService.value.firestore.collection('services').get();

    List<SocialService> newList = data.docs.map((x) => SocialService.fromMap(x.data())).toList();
    firebase_service_social.value.list.addAll(newList);
    firebase_service_social.value = firebase_service_social.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Servicios Sociales")),
      drawer: const CustomDrawer(),
      body: ValueListenableBuilder<SsFavorites>(
        valueListenable: firebase_service_social,
        builder: (context, ssFavorites, child) {
          return ListView.builder(
            itemCount: ssFavorites.list.length,
            itemBuilder: (context, index) {
            if (ssFavorites.list.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
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
                      Text("📌 ${service.nombre}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text("🎯 Objetivo: ${service.objetivo}"),
                      Text("🏢 Departamento: ${service.departamento}"),
                      Text("👤 Responsable: ${service.responsable}"),
                      Text("📧 Email: ${service.email}"),
                      Text("👥 Tipo de Alumnos: \n${service.tipoAlumnos.join('\n')}"),
                      ElevatedButton(
                        onPressed: (){}, 
                        child: Icon(Icons.star)
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
