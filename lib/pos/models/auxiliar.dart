class Auxiliar {
  final String id, descripcion, tipo;

  Auxiliar( {
    this.id,
    this.descripcion,
    this.tipo,
  } );

  factory Auxiliar.fromJson(Map<String, dynamic> jsonData) {
    return Auxiliar(
      id:          jsonData['id'],
      descripcion: jsonData['descripcion'],
      tipo:        jsonData['tipo'],
      );
  }
}