class Movimiento {
  final String orden, cuenta, descripcion, favorito, valorDB, valorCR;

  Movimiento( {
    this.orden,
    this.cuenta,
    this.descripcion,
    this.favorito,

    this.valorDB,
    this.valorCR,
  } );

  factory Movimiento.fromJson(Map<String, dynamic> jsonData) {
    return Movimiento(
      orden:       jsonData['orden'],
      cuenta:      jsonData['cuenta'],
      descripcion: jsonData['descripcion'],
      favorito:    jsonData['favorito'],

      valorDB:     jsonData['valorDB'],
      valorCR:     jsonData['valorCR'],
      );
  }

}