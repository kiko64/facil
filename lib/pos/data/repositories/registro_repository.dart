class RegistroRepository {
  static Future<List<Registro>> downloadRegistro(
      String value, String query) async {
    if (query.length == 0) {
      return Buscar.parseRegistro(
          value); // Retorma Registro.fromJson(json)).toList() <- JSon ya que query = ''
    } else {
      registros = Buscar.parseRegistro(value); // Lo carga con el de todos
      return registros
          .where((registro) =>
              registro.completo.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  static List<Registro> parseRegistro(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Registro>((json) => new Registro.fromJson(json)).toList();
  }

  static Future<String> registro(String consulta) async {
//    print('************ CONSULTA ************: ${consulta}');

    try {
      var map = Map<String, dynamic>();
      map['action'] = _getData;
      map['consulta'] = consulta;

      final response = await http.post(servicioRegistro, body: map);

      if (200 == response.statusCode && response.contentLength > 0) {
//        print('datos(R): ${response.body}');
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

  static Future<String> averiguarRegistros(String id) async {
    String consulta;
    if (id.trim().length != 0)
      consulta =
          "select v.registro, v.t_comprobante as desRegistro, CONCAT (v.nombre, nombreAdicional( v.documento ), ' ( \$', FORMAT(v.valor,0), ' )' ) AS nombre, " +
              "CONCAT ( v.t_comprobante, ' ', v.nombre ) as completo " +
              "from v_registro v " +
              "where v.valor != 0 " +
              "and v.registro in (" +
              id.toString() +
              ") " +
              "union " +
              "select v.registro, v.t_comprobante as desRegistro, CONCAT (v.nombre, nombreAdicional( v.documento ) ) AS nombre, " +
              "CONCAT ( v.t_comprobante, ' ', v.nombre ) as completo " +
              "from v_registro v " +
              "where v.valor = 0 " +
              "and v.registro in (" +
              id.toString() +
              ") " +
              "order by 1";
    else
      consulta =
          "select v.registro, v.t_comprobante as desRegistro, CONCAT (v.nombre, nombreAdicional( v.documento ), ' ( \$', FORMAT(v.valor,0), ' )' ) AS nombre, " +
              "CONCAT ( v.t_comprobante, ' ', v.nombre ) as completo " +
              "from v_registro v " +
              "where v.valor != 0 " +
              "union " +
              "select v.registro, v.t_comprobante as desRegistro, CONCAT (v.nombre, nombreAdicional( v.documento ) ) AS nombre, " +
              "CONCAT ( v.t_comprobante, ' ', v.nombre ) as completo " +
              "from v_registro v " +
              "where v.valor = 0 " +
              "order by 1";

//    print('************ Consulta ************: ${consulta}');
    String registros;
    registros = await registro(consulta); // Consulta de registros
//    print('actividades: ${registros}');

    return registros.toString();
  }
}
