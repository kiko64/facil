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


class Registro {
  final String ejecutar, fecha, usuario, seguimiento, agenda, documento,
  cuenta, valor, observacion, archivo0, archivo1, archivo2, archivo3,
  descripcion, nombre, desSeguimiento, imagen;

  Registro( {
    this.ejecutar,
    this.fecha,
    this.usuario,
    this.seguimiento,
    this.agenda,
    this.documento,

    this.cuenta,
    this.valor,
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

  factory Registro.fromJson(Map<String, dynamic> jsonData) {
    return Registro(
      ejecutar:    jsonData['ejecutar'],
      fecha:       jsonData['fecha'],
      usuario:     jsonData['usuario'],
      seguimiento: jsonData['seguimiento'],
      agenda:      jsonData['agenda'],
      documento:   jsonData['documento'],

      cuenta:      jsonData['cuenta'],
      valor:       jsonData['valor'],
      observacion: jsonData['observacion'],
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


class Item {
  final String id, descripcion, tipo;

  Item( {
    this.id,
    this.descripcion,
    this.tipo,
  } );

  factory Item.fromJson(Map<String, dynamic> jsonData) {
    return Item(
      id:          jsonData['id'],
      descripcion: jsonData['descripcion'],
      tipo:        jsonData['tipo'],
      );
  }
}


