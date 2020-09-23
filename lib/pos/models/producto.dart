class Producto {
  final String id, descripcion, tipo, unidad, equivalencia, ventaUnitario, ventaValor, desUnidad, desUnidadCorto, completo;

  Producto( {
    this.id,
    this.descripcion,
    this.tipo,
    this.unidad,

    this.equivalencia,
    this.ventaUnitario,
    this.ventaValor,
    this.desUnidad,
    this.desUnidadCorto,

    this.completo,
  } );

  factory Producto.fromJson(Map<String, dynamic> jsonData) {
    return Producto(
      id:             jsonData['id'],
      descripcion:    jsonData['descripcion'],
      tipo:           jsonData['tipo'],

      unidad:         jsonData['unidad'],

      equivalencia:   jsonData['equivalencia'],
      ventaUnitario:  jsonData['ventaUnitario'],
      ventaValor:     jsonData['ventaValor'],
      desUnidad:      jsonData['desUnidad'],
      desUnidadCorto: jsonData['desUnidadCorto'],

      completo:       jsonData['completo'],
    );
  }
}