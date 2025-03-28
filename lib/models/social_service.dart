class SocialService {
  final String departamento;
  final String email;
  final int id;
  final String nombre;
  final String objetivo;
  final String responsable;
  final List<String> tipoAlumnos;
  final String categoria;

  SocialService({
    required this.departamento, 
    required this.email, 
    required this.id, 
    required this.nombre, 
    required this.objetivo, 
    required this.responsable, 
    required this.tipoAlumnos, 
    required this.categoria,
  });  

  factory SocialService.fromMap(Map<String, dynamic> data) {
    return SocialService(
      categoria: data['categoria']?? '',
      departamento: data['departamento'] ?? '',
      email: data['email'] ?? '',
      id: data['id'] ?? 0,
      nombre: data['nombre'] ?? '',
      objetivo: data['objetivo'] ?? '',
      responsable: data['responsable'] ?? '',
      tipoAlumnos: List<String>.from(data['tipoAlumnos'] ?? []),
    );
  }
}
