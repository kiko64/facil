import 'dart:async';
import 'package:facilapp/soporte.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

import 'movimientos.dart';
import 'registros.dart';
import 'globals.Dart' as globals;

List<Transaccion> transacciones;                                                // defino la variable registros globalmente

class MyTransaccionPage extends StatefulWidget {
  final String value;                                                           // Cambio, pasa la consulta inicial
  MyTransaccionPage({Key key, this.value}) : super(key: key);

  @override
  _MyTransaccionPageState createState() => _MyTransaccionPageState();
}


class _MyTransaccionPageState extends State<MyTransaccionPage> {

  String _queryText;                                                            // Cambio,

  @override
  void initState() {
    _queryText = '';                                                            // Cambio, consulta inical vacia = todos
    super.initState();
  }

  void onQueryChanged(BuildContext context, String query) {

    setState(() {
      _queryText = '$query';                                                    // Cambio,
    });
  }

  onQuerySubmitted(BuildContext context, String query) {
    _queryText = '$query';
    print('_onQuerySubmitted: ${_queryText}');
    setState(() => _queryText = '$query');                                      // 'Query submitted!'
  }
// https://youtu.be/nQBpOIHE4eE

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar transacciones...',
        defaultBar: AppBar(
          title: Text('Transacciones',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),
          ),
        onQueryChanged: (query) => onQueryChanged(context, query),              // Cambio,
        onQuerySubmitted: (query) => onQuerySubmitted(context, query),
        ),

      body: Center(
        child: FutureBuilder<List<Transaccion>>(                                // function
          future: Buscar.downloadTransaccion( widget.value, _queryText ),       // Cambio, pasa el String y lo carga al objeto
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//              List<Registro> registros = snapshot.data;                       // defino la variable registros
              transacciones = snapshot.data;                                    // defino la variable registros
//              return CustomListView(registros: registros);                    // Es el Widget detalle
              return CustomListView();                                          // Es el Widget detalle
            } else
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
            //return  a circular progress indicator.
            return new CircularProgressIndicator();
          },
        ),
      ),

    );
  }
}


class CustomListView extends StatefulWidget {
//  final List<Registro> registros;
//  CustomListView({Key key, this.registros}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();                 // _CustomListViewState(this.registros);
}

class _CustomListViewState extends State<CustomListView> {
//  final List<Registro> registros;
//  _CustomListViewState(this.registros);

//  int _registroSaved = 0;

  @override
  void initState() {
    if ( globals.transaccionSaved == 0 )
      globals.transaccionSaved = int.parse( transacciones.first.ejecutar );            // int.parse( widget.registros.first.ejecutar );
  }

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: transacciones.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(transacciones[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Transaccion transaccion, BuildContext context) {

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: AlignmentDirectional.centerEnd,
        color: Theme.of(context).accentColor,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
          child: Icon(
            Icons.delete, color: Colors.white,
          ),
        ),
      ),

    onDismissed: (direction) {
//      bloc.delete( item.amparo, item.poliza );          // Manejo DB Borrar
      String sentencia = 'update g_ejecutar set seguimiento = 12605 where ejecutar =' + transaccion.ejecutar;
//      sentencia = await Buscar.ejecutar( sentencia );                         // Ingresar a g_ejecutar
      sentencia =  Buscar.transaccion( sentencia ) as String;                      // Ingresar a g_ejecutar

    },

      child: Column(
        children: <Widget>[
          ListTile(

            leading: Image.asset( transaccion.imagen.toString() ),
      //    leading: FadeInImage.memoryNetwork(
      //    placeholder: kTransparentImage,
      //      image: 'https://ocobosoft.000webhostapp.com/tmp/' + registro.archivo0,
      //    ),

            title: Text(
              transaccion.descripcion + transaccion.desSeguimiento + ', ' + transaccion.fecha,
              style: new TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),

            subtitle: Text( transaccion.nombre +' ( \$'+ transaccion.valor + ' )' ),
/*
            trailing: IconButton(
              icon: const Icon(Icons.attach_file, ),
      //      icon: const Icon(Icons.keyboard_arrow_right, ),

              onPressed: () async {
                String _soporte = 'https://ocobosoft.000webhostapp.com/tmp/' + registro.archivo0;

                print('llamar: ${_soporte}');
                var route = MaterialPageRoute(
                  builder: (BuildContext context) =>
                  MySoportePage(value: _soporte ),                              // Cambio
                );
                Navigator.of(context).push(route);
              },
            ),

    */

            trailing: IconButton(
              icon: const Icon(Icons.keyboard_arrow_right, ),

              onPressed: () async {
                String _registros = await Buscar.averiguarRegistros( transaccion.registro );  // Retorna el json como un String de acuerdo al parametro
                print('llamar: ${_registros}');
                var route = MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MyRegistroPage(value: _registros ),                       // Cambio
                );
                Navigator.of(context).push(route);
/*
                String _movimientos = await Buscar.averiguarMovimientos( registro.ejecutar );      // Viene el json como un String
                print('llamar: ${_movimientos}');
                var route = MaterialPageRoute(
                  builder: (BuildContext context) =>
                  MyMovimientoPage(value: _movimientos ),             // Cambio
                );
                Navigator.of(context).push(route);
  */
              },

          ),


            onTap: () {
              String _soporte = 'https://ocobosoft.000webhostapp.com/tmp/' + transaccion.archivo0;

              print('llamar: ${_soporte}');
              var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  MySoportePage(value: _soporte ),                              // Cambio
              );
              Navigator.of(context).push(route);
            }

          ),

          Divider(),                                                            // <-- Divider
        ],
      ),
    );
  }

}
