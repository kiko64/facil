class ProductoRepository {
  static Future<List<Producto>> searchloadProducto(
      String value, String query) async {
    if (query.length == 0)
      return Buscar.parseProducto(value); // Cambio, pasa el string --> objeto
    else {
      productos = Buscar.parseProducto(value);
      return productos
          .where((registro) =>
              registro.completo.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  Future<List<Producto>> downloadProductoOld(String value) async {
    // Ya no se usa era para la prueba inicial que selecionaba agendas como productos
    String sJson = await Buscar.averiguarActividades(
        value); // value = 'todos,0,todos' -> Busca en la BD -> StringJson
    return Buscar.parseProducto(
        sJson); // Cambio, pasa el StringJson --> List<Producto>
  }

  static Future<List<Producto>> downloadProducto(
      String value, String query) async {
    if (query.length == 0)
      return Buscar.parseProducto(value); // Cambio, pasa el string --> objeto
    else {
      productos = Buscar.parseProducto(value); // Lo carga con el de todos
      return productos
          .where((registro) =>
              registro.completo.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  static List<Producto> parseProducto(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Producto>((json) => new Producto.fromJson(json)).toList();
  }

  static Future<String> getProducto() async {
//    print('consulta: ${consulta}');

    try {
//      var map = Map<String, dynamic>();
//      map['action']   = _getData;
//      map['consulta'] = consulta;

      final response = await http.post(servicioProducto);

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

  static Future<String> averiguarProductos() async {
    String consulta = "SELECT r.referencia AS id, r.descripcion, r.estado AS tipo, " +
        "v.unidad, v.equivalencia, v.ventaUnitario, v.ventaValor, u.descripcion AS desUnidad, u.valor_i, " +
        "CONCAT( g.descripcion, ' ', r.descripcion ) AS completo " +
        "FROM p_referencia r, p_referencia g, p_valor v, g_registro u " +
        "WHERE r.estado = 10601 " +
        "AND SUBSTRING(r.referencia, 1, 2) = g.referencia " +
        "AND r.referencia = v.referencia AND v.orden = 1 AND v.unidad = u.registro " +
        "ORDER BY 1 Desc";

    String productos;
    productos =
        await getProducto(); // La consulta esta en: consultaProducto.php
//    print('actividades: ${productos}');

    return productos.toString();
  }
}
