class AuxiliarRepository {
  static Future<List<Auxiliar>> downloadAuxiliar(String value) async {
//    return Buscar.parseAuxiliar( value );                                     // Cambio, pasar el JsonString --> List<Auxiliar>
    List<Auxiliar> auxiliares; // defino la variable auxiliares globalmente
    auxiliares = Buscar.parseAuxiliar(
        value); // Cambio, pasar el JsonString --> List<Auxiliar>
    return auxiliares
        .where((auxiliar) => auxiliar.tipo.contains(globals.tipoSaved))
        .toList();
  }

  static List<Auxiliar> parseAuxiliar(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Auxiliar>((json) => new Auxiliar.fromJson(json)).toList();
  }

  static Future<String> averiguarAuxiliares( String cadena, String actividades) async {
    // <-- 'actividad,valor,nombre', '[{"id":"14422","descripcion":"Factura honorarios","tipo":"14000"}]'

    int i =
        actividades.toString().indexOf('\"id\"'); // Buscar la primera Actividad
    int j = actividades.toString().indexOf('\"descripcion\"');
    globals.actividadSaved =
        int.parse(actividades.substring(i + 6, j - 2)); // <-- 14422

    i = actividades.toString().indexOf('\"tipo\"');
    globals.actividadNamed =
        actividades.substring(j + 15, i - 2); // <- Factura honorarios

    String provisional =
        ""; // Sacar la lista de auxiliares posibles            i
    while (actividades.toString().indexOf('\"tipo\"') != -1) {
      // [{"id":"14422","descripcion":"Factura honorarios","tipo":"14000"}]'
      i = actividades.toString().indexOf(
          '\"tipo\"'); //                                                  |
      if (provisional.length == 0) {
        provisional = actividades.substring(i + 8, i + 13);
        globals.tipoSaved =
            provisional; // Cual tipo de documento esta activo, se seleciona el primero
      } else
        provisional += ',' + actividades.substring(i + 8, i + 13);
      actividades = actividades.substring(0, i) +
          actividades.substring(i + 13, actividades.length);
    }

    provisional = '(' + provisional + ')';
    List lista = cadena.split(",");

    String consulta0 =
        "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo " +
            "from g_auxiliar a, documento d, tercero t " +
            "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND a.favorito like '" +
            lista[2] +
            "' AND d.tipo in " +
            provisional; // limit 1

    String consulta1 =
        "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo " +
            "from g_auxiliar a, documento d, tercero t " +
            "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND a.favorito like '%" +
            lista[2] +
            "%' AND d.tipo in " +
            provisional +
            " order by a.favorito desc"; // limit 1

    lista[2] = lista[2].toUpperCase();
    String consulta2 =
        "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo, levenshtein('\$" +
            lista[2] +
            "', UPPER(a.favorito)) " +
            "from g_auxiliar a, documento d, tercero t " +
            "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND d.tipo in " +
            provisional +
            " order by 4 desc, 3 limit 10";

    String auxiliares;
    auxiliares = await getConsulta(
        consulta0, consulta1, consulta2, 'D'); // Consulta de auxiliares
//    print('auxiliares: ${auxiliares}');

    i = auxiliares.toString().indexOf('\"id\"'); // Buscar el primer Auxiliar
    j = auxiliares.toString().indexOf('\"descripcion\"');
    globals.auxiliarSaved =
        int.parse(auxiliares.substring(i + 6, j - 2)); // <-- 14

    i = auxiliares.toString().indexOf('\"tipo\"');
    globals.auxiliarNamed =
        auxiliares.substring(j + 15, i - 2); // <- Kiko Cárdenas

    return auxiliares.toString();
  }
}
