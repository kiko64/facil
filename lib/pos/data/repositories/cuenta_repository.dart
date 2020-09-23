class CuentaRepository {
  static Future<List<Cuenta>> downloadCuenta(String value) async {
    return Buscar.parseCuenta(value); // Cambio, pasa el string --> objeto
  }

  static List<Cuenta> parseCuenta(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cuenta>((json) => new Cuenta.fromJson(json)).toList();
  }

  static Future<String> getCuenta(String consulta) async {
//    print('consulta: ${consulta}');

    try {
      var map = Map<String, dynamic>();
      map['action'] = _getData;
      map['consulta'] = consulta;

      final response = await http.post(servicioCuenta, body: map);

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

  static Future<String> averiguarCuentas() async {
    String consulta =
        "SELECT cuenta as id, desCuenta as descripcion, tipo FROM v_cuenta ORDER BY cuenta desc ";

    String cuentas;
    cuentas = await getCuenta(consulta); // Consulta de cuentas
//    print('cuentas: ${cuentas}');

    int i = cuentas.toString().indexOf('\"id\"'); // Buscar el primer Auxiliar
    int j = cuentas.toString().indexOf('\"descripcion\"');
    int k = cuentas.toString().indexOf('\"tipo\"');
    // i  i+6   j          j+15                                  k
    globals.cuentaSaved = int.parse(cuentas.substring(i + 6,
        j - 2)); // "id":"8","descripcion":"Colombia Aho. No 80705461011","tipo":"22001"
    globals.cuentaNamed = cuentas.substring(j + 15, k - 2); // <- Kiko Cárdenas
    return cuentas.toString();
  }
}
