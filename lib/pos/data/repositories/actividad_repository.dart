class ActividadRepository {
  static Future<List<Actividad>> downloadActividad(String value) async {
    return Buscar.parseActividad(value); // Cambio, pasa el string --> objeto
  }

  static List<Actividad> parseActividad(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Actividad>((json) => new Actividad.fromJson(json))
        .toList();
  }

  static Future<String> getConsulta(
      String consulta0, consulta1, consulta2, cual) async {
    //    print('consulta0: ${consulta0}');
    //    print('consulta1: ${consulta1}');
    //    print('consulta2: ${consulta2}');

    try {
      var map = Map<String, dynamic>();
      map['action'] = _getData;
      map['consulta0'] = consulta0;
      map['consulta1'] = consulta1;
      map['consulta2'] = consulta2;

      final response = await http.post(servicioDato, body: map);

      if (200 == response.statusCode && response.contentLength > 0) {
//       print('datos(${cual}): ${response.body}');
        return response.body;
      } else {
        print('datos(${cual}): 0');
        return 'error';
      }
    } catch (e) {
      print('datos(${cual}): error');
      return 'error'; // return an empty list on exception/error
    }
  }

  static Future<String> averiguarActividades(String cadena) async {
    // <-- actividad,valor,nombre

    List lista = cadena.split(",");

    String consulta0 =
        "select a.agenda as id, a.descripcion, c.documento as tipo " + // Se relaciona con clase para saber cual es el documento
            "from g_agenda a, g_parametro p, clase c " + // agenda.actividad = 33006 Dictadas
            "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
            "and a.descripcion like '" +
            lista[0] +
            "' "; // limit 1
    String consulta1 =
        "select a.agenda as id, a.descripcion, c.documento as tipo " +
            "from g_agenda a, g_parametro p, clase c " +
            "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
            "and a.descripcion like '%" +
            lista[0] +
            "%' order by a.descripcion desc"; // limit 1

    lista[0] = lista[0].toUpperCase();
    String consulta2 =
        "select a.agenda as id, a.descripcion, c.documento as tipo, levenshtein('\$" +
            lista[0] +
            "', UPPER(a.descripcion)) " +
            "from g_agenda a, g_parametro p, clase c " +
            "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
            "order by 4 desc, 3 limit 10";

//    List<Actividad> _actividades = parseActividad( await getConsulta( consulta0, consulta1, consulta2, 'A' ) );   // Pasarlo al objeto

    String actividades;
    actividades = await getConsulta(
        consulta0, consulta1, consulta2, 'A'); // Consulta de actividad
//    print('actividades: ${actividades}');

    return actividades.toString();
  }
}
