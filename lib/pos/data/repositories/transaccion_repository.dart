class TransaccionRepository {
  static Future<List<Transaccion>> downloadTransaccion(
      String value, String query) async {
    if (query.length == 0)
      return Buscar.parseTransaccion(
          value); // Cambio, pasa el string --> objeto
    else {
      transacciones =
          Buscar.parseTransaccion(value); // Lo carga con el de todos
      return transacciones
          .where((registro) =>
              registro.descripcion.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  static List<Transaccion> parseTransaccion(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Transaccion>((json) => new Transaccion.fromJson(json))
        .toList();
  }

  static Future<String> transaccion(String consulta) async {
    try {
      var map = Map<String, dynamic>();
      map['action'] = _getData;
      map['consulta'] = consulta;

      final response = await http.post(servicioTransaccion, body: map);

      if (200 == response.statusCode && response.contentLength > 0) {
//        print('datos(R): ${response.body}');
        return response.body;
      } else {
        print('datos(R): 0');
        return 'error';
      }
    } catch (e) {
//      print('datos(R): error');
      return 'error'; // return an empty list on exception/error
    }
  }

  static Future<String> averiguarTransacciones() async {
    String consulta =
        "select e.ejecutar, DATE_FORMAT(e.fecha,'%d %b %Y') as fecha, e.usuario, e.seguimiento, e.agenda, e.documento, " +
            "e.cuenta, format(e.valor,0) as valor, e.observacion, e.registro, e.mascara, e.archivo0, e.archivo1, e.archivo2, e.archivo3, " +
            "a.descripcion, d.nombre as nombre, concat('assets\/',e.seguimiento,'.png') as imagen, concat(' (', r.descripcion, ')') as desSeguimiento " +
            "from  g_ejecutar e, g_agenda a, v_documento d, g_registro r " +
            "where e.agenda = a.agenda and e.documento = d.documento and e.seguimiento = r.registro " +
            "order by e.ejecutar ";

    String registros;
    registros = await transaccion(consulta); // Consulta de registros
//    print('actividades: ${registros}');

    return registros.toString();
  }
}
