class MovimientoRepository {
  static List<Movimiento> parseMovimiento(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Movimiento>((json) => new Movimiento.fromJson(json))
        .toList();
  }

  static Future<String> getMovimiento(String consulta) async {
//    print('consulta: ${consulta}');

    try {
      var map = Map<String, dynamic>();
      map['action'] = _getData;
      map['consulta'] = consulta;

      final response = await http.post(servicioMovimiento, body: map);

      if (200 == response.statusCode && response.contentLength > 0) {
//        print('datos(R): ${response.body}');                                    // return a json's string
        return response.body;
      } else {
        print('datos(R): 0');
        return 'error';
      }
    } catch (e) {
      print('datos(R): error');
      return 'error'; // return an empty list on exception/error
    }
  }

  static Future<String> averiguarMovimientos(String id) async {
    String consulta =
        "select m.orden, m.cuenta, p.descripcion, v.favorito, FORMAT(m.valorDB,0)as valorDB, FORMAT(m.valorCR,0) as valorCR "
                "from movimiento m, puc p, v_auxiliar v "
                "where m.cuenta = p.cuenta and m.auxiliar = v.auxiliar "
                "and m.registro = " +
            id +
            " order by m.orden desc ";

//    print('consulta: ${consulta}');

    String movimientos;
    movimientos = await getMovimiento(consulta); // json's String
//    print('************ movimientos ************: ${movimientos}');

    return movimientos.toString();
  }
}
