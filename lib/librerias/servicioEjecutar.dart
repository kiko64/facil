import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../globals.Dart' as globals;
import '../productos.dart';
import '../registros.dart';
import 'package:facilapp/librerias/modeloEjecutar.dart';


class Buscar {

  static const servicioEjecutar = 'https://ocobosoft.000webhostapp.com/consultaEjecutar.php';
  static const servicioMovimiento = 'https://ocobosoft.000webhostapp.com/consultaMovimiento.php';
  static const servicioCuenta = 'https://ocobosoft.000webhostapp.com/consultaCuenta.php';
  static const servicioDato = 'https://ocobosoft.000webhostapp.com/consultaDato.php';
  static const servicioProducto = 'https://ocobosoft.000webhostapp.com/consultaProducto.php';

  static const _getData     = 'GET_DATA';
  static const _AddData     = 'ADD_DATA';


  static Future<List<Producto>> searchloadProducto( String value, String query ) async {
    if ( query.length == 0 )
      return Buscar.parseProducto( value );                                     // Cambio, pasa el string --> objeto
    else {
      productos = Buscar.parseProducto( value );
      return productos.where(
              (registro) => registro.completo.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }


  Future<List<Producto>> downloadProducto( String value ) async {               // Ya no se usa era para la prueba inicial que selecionaba agendas como productos
    String sJson = await Buscar.averiguarActividades( value );                  // value = 'todos,0,todos' -> Busca en la BD -> StringJson
    return Buscar.parseProducto( sJson );                                       // Cambio, pasa el StringJson --> List<Producto>
  }


  static Future<List<Registro>> downloadRegistro( String value, String query ) async {
    if ( query.length == 0 )
      return Buscar.parseRegistro( value );                                     // Cambio, pasa el string --> objeto
    else {
      registros = Buscar.parseRegistro( value );                                // Lo carga con el de todos
      return registros.where(
              (registro) => registro.descripcion.toLowerCase().contains(query.toLowerCase())).toList();
    }
  }


  static Future<List<Actividad>> downloadActividad( String value ) async {
    return Buscar.parseActividad( value );                                      // Cambio, pasa el string --> objeto
  }


  static Future<List<Auxiliar>> downloadAuxiliar( String value ) async {
//    return Buscar.parseAuxiliar( value );                                     // Cambio, pasar el JsonString --> List<Auxiliar>
    List<Auxiliar> auxiliares;                                                  // defino la variable auxiliares globalmente
    auxiliares = Buscar.parseAuxiliar( value );                                 // Cambio, pasar el JsonString --> List<Auxiliar>
    return auxiliares.where(
            (auxiliar) => auxiliar.tipo.contains( globals.tipoSaved )).toList();
  }


  static Future<List<Cuenta>> downloadCuenta( String value ) async {
    return Buscar.parseCuenta( value );                                         // Cambio, pasa el string --> objeto
  }


  static List<Actividad> parseActividad(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Actividad>((json) => new Actividad.fromJson(json)).toList();
  }


  static List<Auxiliar> parseAuxiliar(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Auxiliar>((json) => new Auxiliar.fromJson(json)).toList();
  }


  static List<Cuenta> parseCuenta(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Cuenta>((json) => new Cuenta.fromJson(json)).toList();
  }


  static List<Registro> parseRegistro(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Registro>((json) => new Registro.fromJson(json)).toList();
  }


  static List<Movimiento> parseMovimiento(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Movimiento>((json) => new Movimiento.fromJson(json)).toList();
  }


  static List<Producto> parseProducto(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Producto>((json) => new Producto.fromJson(json)).toList();
  }


  static Future<String> getConsulta( String consulta0, consulta1, consulta2, cual ) async {

//    print('consulta0: ${consulta0}');
//    print('consulta1: ${consulta1}');
//    print('consulta2: ${consulta2}');

    try {
      var map = Map<String, dynamic>();
      map['action']    = _getData;
      map['consulta0'] = consulta0;
      map['consulta1'] = consulta1;
      map['consulta2'] = consulta2;

      final response = await http.post( servicioDato, body: map );

      if ( 200 == response.statusCode && response.contentLength > 0 ) {
//        print('datos(${cual}): ${response.body}');
        return response.body;
      }
      else {
        print('datos(${cual}): 0');
        return 'error';
      }
    } catch (e) {
      print('datos(${cual}): error');
      return 'error';                                                           // return an empty list on exception/error
    }
  }


  static Future<String> ejecutar( String consulta ) async {

    try {
      var map = Map<String, dynamic>();
      map['action']   = _getData;
      map['consulta'] = consulta;

      final response = await http.post( servicioEjecutar, body: map );

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


  static Future<String> getCuenta( String consulta ) async {

//    print('consulta: ${consulta}');

    try {
      var map = Map<String, dynamic>();
      map['action']   = _getData;
      map['consulta'] = consulta;

      final response = await http.post( servicioCuenta, body: map );

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


  static Future<String> getProducto() async {

//    print('consulta: ${consulta}');

    try {
//      var map = Map<String, dynamic>();
//      map['action']   = _getData;
//      map['consulta'] = consulta;

      final response = await http.post( servicioProducto );

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


  static Future<String> getMovimiento( String consulta ) async {

//    print('consulta: ${consulta}');

    try {
      var map = Map<String, dynamic>();
      map['action']   = _getData;
      map['consulta'] = consulta;

      final response = await http.post( servicioMovimiento, body: map );

      if ( 200 == response.statusCode && response.contentLength > 0 ) {
        print('datos(R): ${response.body}');                                    // return a json's string
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


  static Future<String> averiguar( String cadena ) async {

    String resultado = averiguarPartes( cadena );                               // <-- actividad,valor,nombre
    return resultado.toString();
  }


  static Future<String> averiguarActividades( String cadena ) async {           // <-- actividad,valor,nombre

    List lista = cadena.split(",");

    String consulta0 =
          "select a.agenda as id, a.descripcion, c.documento as tipo " +        // Se relaciona con clase para saber cual es el documento
          "from g_agenda a, g_parametro p, clase c " +                          // agenda.actividad = 33006 Dictadas
          "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
          "and a.descripcion like '" + lista[0] + "' "; // limit 1
    String consulta1 =
          "select a.agenda as id, a.descripcion, c.documento as tipo " +
          "from g_agenda a, g_parametro p, clase c " +
          "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
          "and a.descripcion like '%" + lista[0] + "%' order by a.descripcion desc"; // limit 1

    lista[0] = lista[0].toUpperCase();
    String consulta2 =
          "select a.agenda as id, a.descripcion, c.documento as tipo, levenshtein('\$" + lista[0] + "', UPPER(a.descripcion)) " +
          "from g_agenda a, g_parametro p, clase c " +
          "where a.actividad = 33006 and a.agenda = p.agenda and p.orden = 4 and trim(p.ultimo) > 0 and p.ultimo = c.clase " +
          "order by 4 desc, 3 limit 10";

//    List<Actividad> _actividades = parseActividad( await getConsulta( consulta0, consulta1, consulta2, 'A' ) );   // Pasarlo al objeto

    String actividades;
    actividades = await getConsulta( consulta0, consulta1, consulta2, 'A' );    // Consulta de actividad
    print('actividades: ${actividades}');

    return actividades.toString();
  }


  static Future<String> averiguarAuxiliares( String cadena, String actividades ) async { // <-- 'actividad,valor,nombre', '[{"id":"14422","descripcion":"Factura honorarios","tipo":"14000"}]'

    int i = actividades.toString().indexOf('\"id\"');                           // Buscar la primera Actividad
    int j = actividades.toString().indexOf('\"descripcion\"');
    globals.actividadSaved = int.parse( actividades.substring(i + 6, j - 2) );  // <-- 14422

    i = actividades.toString().indexOf('\"tipo\"');
    globals.actividadNamed = actividades.substring(j + 15, i - 2);              // <- Factura honorarios

    String provisional = "";                                                    // Sacar la lista de auxiliares posibles            i
    while( actividades.toString().indexOf('\"tipo\"') != -1 ) {                 // [{"id":"14422","descripcion":"Factura honorarios","tipo":"14000"}]'
      i = actividades.toString().indexOf('\"tipo\"');                           //                                                  |
      if ( provisional.length == 0 ) {
        provisional = actividades.substring(i + 8, i + 13);
        globals.tipoSaved = provisional;                                        // Cual tipo de documento esta activo, se seleciona el primero
      }
      else provisional+= ','+actividades.substring(i + 8, i + 13 );
      actividades = actividades.substring( 0 , i ) + actividades.substring( i + 13, actividades.length );
    }

    provisional = '(' + provisional + ')';
    List lista = cadena.split(",");

    String consulta0 =
          "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo " +
          "from g_auxiliar a, documento d, tercero t " +
          "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND a.favorito like '" + lista[2] + "' AND d.tipo in " + provisional ; // limit 1

    String consulta1 =
          "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo " +
           "from g_auxiliar a, documento d, tercero t " +
          "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND a.favorito like '%" + lista[2] + "%' AND d.tipo in " + provisional + " order by a.favorito desc"; // limit 1

    lista[2] = lista[2].toUpperCase();
    String consulta2 =
          "select d.documento as id, concat( a.favorito, ', ', format( a.identificacion, 0), ' (', t.descripcion, ')' ) as descripcion, d.tipo, levenshtein('\$" + lista[2] + "', UPPER(a.favorito)) " +
          "from g_auxiliar a, documento d, tercero t " +
          "where a.auxiliar = d.auxiliar AND d.tipo = t.tercero AND d.tipo in "+ provisional + " order by 4 desc, 3 limit 10";

    String auxiliares;
    auxiliares = await getConsulta( consulta0, consulta1, consulta2, 'D' );     // Consulta de auxiliares
    print('auxiliares: ${auxiliares}');

    i = auxiliares.toString().indexOf('\"id\"');                                // Buscar el primer Auxiliar
    j = auxiliares.toString().indexOf('\"descripcion\"');
    globals.auxiliarSaved = int.parse( auxiliares.substring(i + 6, j - 2) );    // <-- 14

    i = auxiliares.toString().indexOf('\"tipo\"');
    globals.auxiliarNamed = auxiliares.substring(j + 15, i - 2);                // <- Kiko Cárdenas

    return auxiliares.toString();
  }


  static Future<String> averiguarCuentas() async {

    String consulta = "SELECT cuenta as id, desCuenta as descripcion, tipo FROM v_cuenta ORDER BY cuenta desc ";

    String cuentas;
    cuentas = await getCuenta( consulta );                                    // Consulta de cuentas
    print('cuentas: ${cuentas}');

    int i = cuentas.toString().indexOf('\"id\"');                                // Buscar el primer Auxiliar
    int j = cuentas.toString().indexOf('\"descripcion\"');
    int k = cuentas.toString().indexOf('\"tipo\"');
    // i  i+6   j          j+15                                  k
    globals.cuentaSaved = int.parse( cuentas.substring(i + 6, j - 2) );         // "id":"8","descripcion":"Colombia Aho. No 80705461011","tipo":"22001"
    globals.cuentaNamed = cuentas.substring(j + 15, k - 2);                     // <- Kiko Cárdenas
    return cuentas.toString();
  }


  static Future<String> averiguarRegistros() async {

    String consulta =
      "select e.ejecutar, DATE_FORMAT(e.fecha,'%d %b %Y') as fecha, e.usuario, e.seguimiento, e.agenda, e.documento, " +
      "e.cuenta, format(e.valor,0) as valor, e.observacion, e.archivo0, e.archivo1, e.archivo2, e.archivo3, " +
      "a.descripcion, d.nombre as nombre, concat('assets\/',e.seguimiento,'.png') as imagen, concat(' (', r.descripcion, ')') as desSeguimiento " +
      "from  g_ejecutar e, g_agenda a, v_documento d, g_registro r " +
      "where e.agenda = a.agenda and e.documento = d.documento and e.seguimiento = r.registro " +
      "order by e.ejecutar ";

    String registros;
    registros = await ejecutar( consulta );                                  // Consulta de registros
    print('actividades: ${registros}');

    return registros.toString();
  }


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
    productos = await getProducto();                                                    // La consulta esta en: consultaProducto.php
    print('actividades: ${productos}');

    return productos.toString();
  }


  static Future<String> averiguarMovimientos( String id ) async {

    String consulta =
      "select m.orden, m.cuenta, p.descripcion, v.favorito, FORMAT(m.valorDB,0)as valorDB, FORMAT(m.valorCR,0) as valorCR "
      "from movimiento m, puc p, v_auxiliar v "
      "where m.cuenta = p.cuenta and m.auxiliar = v.auxiliar "
      "and m.registro = " + id +
      " order by m.orden desc ";

    print('consulta: ${consulta}');

    String movimientos;
    movimientos = await getMovimiento( consulta );                              // json's String
    print('movimientos: ${movimientos}');

    return movimientos.toString();
  }


  static bool esNumero(String cadena ) {                                        // Es número

    if(cadena == null) {
      return false;
    }
    else
      return double.tryParse(cadena) != null;
  }


  static String quitarCeros(String cadena ) {                                   // Quita ceros a la derecha

    int i = cadena.length;
    int hasta = 3;
    while ( hasta > 0 && i > 0 && cadena.substring( ( i - 1 ), i) == '0' ) {
      i--;
      hasta--;
    }
    if ( i == 0 )
      return cadena;
    else
      return cadena.substring(0, i);
  }


  static String averiguarPartes( String cadena ) {

    int iniNumero = -1;
    int finNumero = -1;
    int indice    = 0;

    String actividad = "";
    String nombre    = "";
    String valor     = "";

    String provisional = cadena.replaceAll( "." , "" ).replaceAll( "\$" , "" ).replaceAll( "," , "" ).replaceAll( "-" , "" ).replaceAll( " cero " , " 0 " ).replaceAll( " pesos " , " 0 " );

    List lista = provisional.split(" ");

    while( indice < lista.length ) {									                          // Averiguar donde esta el número
      if ( iniNumero == -1 && esNumero(lista[indice].trim() ) ) {
        iniNumero = indice;
        finNumero = indice;
      }
      else
      if ( iniNumero != -1 && esNumero(lista[indice].trim() ) ) {
        finNumero = indice;
      }
      indice++;
    }

    if ( iniNumero != -1 ) {
      for ( int recorrido = 0; recorrido < iniNumero; recorrido++ ) {	          // Armar actividad
        if ( recorrido == 0 )
          actividad = lista[recorrido].trim();
        else actividad = actividad + ' ' + lista[recorrido].trim();
      }

      for ( int recorrido = iniNumero; recorrido <= finNumero; recorrido++ ) {  // Armar número
        if ( ( recorrido + 1) <= finNumero )
          valor = valor + quitarCeros(lista[recorrido].trim() );		            // Quita ceros intermedios si hay mas numeros adelante
        else
          valor = valor + lista[recorrido].trim();
      }
                                                                                // Armar auxiliar
      for ( int recorrido = finNumero + 1; recorrido < lista.length; recorrido++ ) {
        if ( recorrido == finNumero + 1 )
          nombre = lista[recorrido].trim();
        else nombre = nombre + ' ' + lista[recorrido].trim();
      }
    }
    else {
      for ( int recorrido = 0; recorrido < lista.length; recorrido++ ) {	      // Armar actividad
        if ( recorrido == 0 )
          actividad = lista[recorrido].trim();
        else actividad = actividad + ' ' + lista[recorrido].trim();
      }
    }
    return actividad + "," + valor + "," + nombre;
  }


}
