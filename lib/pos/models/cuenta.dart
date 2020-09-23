class Cuenta {
  final String id, descripcion, tipo;

  Cuenta( {
    this.id,
    this.descripcion,
    this.tipo,
  } );

  factory Cuenta.fromJson(Map<String, dynamic> jsonData) {
    return Cuenta(
      id:          jsonData['id'],
      descripcion: jsonData['descripcion'],
      tipo:        jsonData['tipo'],
      );
  }
}