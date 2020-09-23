class Transaccion {
  final String ejecutar, fecha, usuario, seguimiento, agenda, documento,
  cuenta, valor, registro, mascara, observacion, archivo0, archivo1, archivo2, archivo3,
  descripcion, nombre, desSeguimiento, imagen;

  Transaccion( {
    this.ejecutar,
    this.fecha,
    this.usuario,
    this.seguimiento,
    this.agenda,
    this.documento,

    this.cuenta,
    this.valor,
    this.registro,
    this.mascara,
    this.observacion,
    this.archivo0,
    this.archivo1,
    this.archivo2,
    this.archivo3,

    this.descripcion,
    this.nombre,
    this.desSeguimiento,
    this.imagen,
  } );

  factory Transaccion.fromJson(Map<String, dynamic> jsonData) {
    return Transaccion(
      ejecutar:    jsonData['ejecutar'],
      fecha:       jsonData['fecha'],
      usuario:     jsonData['usuario'],
      seguimiento: jsonData['seguimiento'],
      agenda:      jsonData['agenda'],
      documento:   jsonData['documento'],

      cuenta:      jsonData['cuenta'],
      valor:       jsonData['valor'],
      observacion: jsonData['observacion'],
      registro:    jsonData['registro'],
      mascara:    jsonData['mascara'],

      archivo0:    jsonData['archivo0'],
      archivo1:    jsonData['archivo1'],
      archivo2:    jsonData['archivo2'],
      archivo3:    jsonData['archivo3'],

      descripcion: jsonData['descripcion'],
      nombre:      jsonData['nombre'],
      desSeguimiento: jsonData['desSeguimiento'],
      imagen:      jsonData['imagen'],
    );
  }

}