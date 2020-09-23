class Registro {
  final String registro, desRegistro, nombre, completo;

  Registro( {
    this.registro,
    this.desRegistro,
    this.nombre,
    this.completo,
  } );

  factory Registro.fromJson(Map<String, dynamic> jsonData) {
    return Registro(
      registro:    jsonData['registro'],
      desRegistro: jsonData['desRegistro'],
      nombre:      jsonData['nombre'],
      completo:    jsonData['completo'],
    );
  }

}