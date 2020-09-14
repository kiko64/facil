import 'dart:async';
import 'package:facilapp/soporte.dart';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

import 'movimientos.dart';
import 'globals.Dart' as globals;

List<Registro> registros;                                                       // defino la variable registros globalmente

class MyRegistroPage extends StatefulWidget {
  final String value;                                                           // Cambio, pasa la consulta inicial
  MyRegistroPage({Key key, this.value}) : super(key: key);

  @override
  _MyRegistroPageState createState() => _MyRegistroPageState();
}


class _MyRegistroPageState extends State<MyRegistroPage> {

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
        searchHint: 'Buscar registros...',
        defaultBar: AppBar(
          title: Text('Registros',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),
        ),
        onQueryChanged: (query) => onQueryChanged(context, query),              // Cambio,
        onQuerySubmitted: (query) => onQuerySubmitted(context, query),
      ),

      body: Center(
        child: FutureBuilder<List<Registro>>(                                   // function
          future: Buscar.downloadRegistro( widget.value, _queryText ),          // Cambio, pasa el String y lo carga al objeto, ya que el FutureBuilder espera el List<Registro>
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//              List<Registro> registros = snapshot.data;                       // defino la variable registros
              registros = snapshot.data;                                        // defino la variable registros
//              return CustomListView(registros: registros);                    // Es el Widget detalle
              return CustomListView();                                          // Es el Widget detalle
            }
            else
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
    if ( globals.registroSaved == 0 )
      globals.registroSaved = int.parse( registros.first.registro );            // int.parse( widget.registros.first.ejecutar );
  }

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: registros.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(registros[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Registro registro, BuildContext context) {

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
/*
      onDismissed: (direction) {
//      bloc.delete( item.amparo, item.poliza );          // Manejo DB Borrar
        String sentencia = 'update registro set seguimiento = 12605 where registro =' + registro.registro;
//      sentencia = await Buscar.ejecutar( sentencia );                         // Ingresar a g_ejecutar
        sentencia =  Buscar.registro( sentencia ) as String;                    // Ingresar a g_ejecutar

      },
*/
      child: Column(
        children: <Widget>[
          ListTile(

              leading: CircleAvatar(
                child: Text( registro.registro )
              ),

              title: Text(
                registro.desRegistro,
                style: new TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),

              subtitle: Text( registro.nombre ),

              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right, ),

                onPressed: () async {
                  String _movimientos = await Buscar.averiguarMovimientos( registro.registro );      // Viene el json como un String
                  print('llamar: ${_movimientos}');
                  var route = MaterialPageRoute(
                  builder: (BuildContext context) =>
                    MyMovimientoPage(value: _movimientos ),                     // Cambio
                  );
                  Navigator.of(context).push(route);
                },

              ),

              onTap: () {
                Navigator.push(                                                 // Manejo DB Actualizar
                    context,                                                    // llamar el soporte
                    MaterialPageRoute(
//                        builder: (context) => AnexoPage(actual: item)
                    )
                );
              },

            //            onTap: () {
            //              setState(() {
            //                globals.registroSaved = int.parse( registro.ejecutar );
            //                print('registro: ${globals.registroSaved}');
            //              });
            //            }
          ),

          Divider(),                                                              // <-- Divider
        ],
      ),
    );
  }

}
