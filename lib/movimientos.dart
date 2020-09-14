import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';


Future<List<Movimiento>> downloadMovimiento( String value ) async {
  return Buscar.parseMovimiento( value );                                       // Cambio, pasa el string --> objeto
}


class MyMovimientoPage extends StatefulWidget {
  final String value;
  MyMovimientoPage({Key key, this.value}) : super(key: key);                    // Cambio

  @override
  _MyMovimientoPageState createState() => _MyMovimientoPageState();
}


class _MyMovimientoPageState extends State<MyMovimientoPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar movimientos...',
        defaultBar: AppBar(
//          leading: IconButton( icon: Icon(Icons.menu ),
//            onPressed: _openDrawer,
//          ),
          title: const Text('Movimientos',
            style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: Center(
        child: FutureBuilder<List<Movimiento>>(                                 // function
          future: downloadMovimiento( widget.value ),                           // Cambio, pasa el String y lo carga al objeto
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Movimiento> movimientos = snapshot.data;                     // defino la variable movimientos
              return CustomListView(movimientos: movimientos);                  // Es el Widget detalle
            } else if (snapshot.hasError) {
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
  final List<Movimiento> movimientos;
  CustomListView({Key key, this.movimientos}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState(this.movimientos);
}

class _CustomListViewState extends State<CustomListView> {
  final List<Movimiento> movimientos;

//  int _movimientoSaved = 0;
  _CustomListViewState(this.movimientos);

  @override
  void initState() {
//    if ( globals.movimientoSaved == 0 )
//      globals.movimientoSaved = int.parse( widget.movimientos.first.ejecutar );
  }

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: movimientos.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(movimientos[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Movimiento movimiento, BuildContext context) {

    Widget DbCr = new Row(
        children: <Widget>[
          Expanded(
            child: new Text(movimiento.valorDB, textAlign: TextAlign.right),
//              child: movimiento.valorDB != 0 ? Text(movimiento.valorDB, textAlign: TextAlign.right) : Text('')
          ),
          Expanded(
            child: new Text(movimiento.valorCR, textAlign: TextAlign.right),
          ),
        ],
    );

    return Column(
      children: <Widget>[
        ListTile(

            leading: CircleAvatar(
                child: Text( movimiento.orden.toString() )
                ),

            title: Text(
              movimiento.cuenta + ', ' + movimiento.descripcion + ' - ' + movimiento.favorito,
    style: new TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,

              ),
            subtitle: DbCr,
//            subtitle: Text( movimiento.favorito +' '+ movimiento.valorDB + '  '+ movimiento.valorCR  ),

            onTap: () {
              setState(() {
//                globals.movimientoSaved = int.parse( movimiento.ejecutar );
//                print('movimiento: ${globals.movimientoSaved}');
              });
            }
        ),

        Divider(),                                                              // <-- Divider

      ],
    );

  }


}
