class Actividad {
  final String id, descripcion, tipo;

  Actividad( {
    this.id,
    this.descripcion,
    this.tipo,
  } );

  factory Actividad.fromJson(Map<String, dynamic> jsonData) {
    return Actividad(
      id:          jsonData['id'],
      descripcion: jsonData['descripcion'],
      tipo:        jsonData['tipo'],
      );
  }
}