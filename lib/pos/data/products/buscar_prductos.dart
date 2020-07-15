import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Producto {
  final String id, title, tipo, image, unidad, equivalencia, price, ventaValor, desUnidad, desUnidadCorto, completo;

  Producto( {
    this.id,
    this.title,
    this.tipo,
    this.image,
    this.unidad,

    this.equivalencia,
    this.price,
    this.ventaValor,
    this.desUnidad,
    this.desUnidadCorto,

    this.completo,
  } );

  factory Producto.fromJson(Map<String, dynamic> jsonData) {
    return Producto(
      id:             jsonData['id'],
      title:          jsonData['title'],
      tipo:           jsonData['tipo'],
      image:          jsonData['image'],
      unidad:         jsonData['unidad'],

      equivalencia:   jsonData['equivalencia'],
      price:          jsonData['price'],
      ventaValor:     jsonData['ventaValor'],
      desUnidad:      jsonData['desUnidad'],
      desUnidadCorto: jsonData['desUnidadCorto'],

      completo:       jsonData['completo'],
    );
  }
}

class Buscar {

  static const servicioProductos = 'https://ocobosoft.000webhostapp.com/consultaProductos.php';

  static const _getData = 'GET_DATA';
  static const _AddData = 'ADD_DATA';

  static Future<String> averiguarProductos() async {

    String consulta =
        "SELECT r.referencia AS id, r.descripcion, r.estado AS tipo, " +
            "v.unidad, v.equivalencia, v.ventaUnitario, v.ventaValor, u.descripcion AS desUnidad, u.valor_i, " +
            "CONCAT( g.descripcion, ' ', r.descripcion ) AS completo " +
            "FROM p_referencia r, p_referencia g, p_valor v, g_registro u " +
            "WHERE r.estado = 10601 " +
            "AND SUBSTRING(r.referencia, 1, 2) = g.referencia " +
            "AND r.referencia = v.referencia AND v.orden = 1 AND v.unidad = u.registro " +
            "ORDER BY 1 Desc";

    String productos;
    productos = await getProducto();                                            // La consulta esta en: consultaProducto.php
    print('actividades: ${productos}');

    return productos.toString();
  }

  static Future<String> getProducto() async {

    try {
      final response = await http.post( servicioProductos );                    // Retorna un String que es un Json

      if ( 200 == response.statusCode && response.contentLength > 0 ) {
        print('datos(R): ${response.body}');
        return response.body;
      }
      else {
        print('datos(R): 0');
        return 'error';
      }
    } catch (e) {
      print('datos(R): error');
      return 'error';                                                           // return an empty list on exception/error
    }
  }

  static Future<List<Producto>> searchloadProducto( String value, String query ) async {
    if ( query.length == 0 )
      return parseProducto( value );                                     // Cambio, pasa el string --> objeto
    else {
      var productos = parseProducto( value );
      return productos.where(
              (registro) => registro.completo.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }

  static List<Producto> parseProducto(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Producto>((json) => new Producto.fromJson(json)).toList();
  }

}
