import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;


import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

class MyCuentaPage extends StatefulWidget {
  final String value;
  MyCuentaPage({Key key, this.value}) : super(key: key);                      // Cambio

  @override
  _MyCuentaPageState createState() => _MyCuentaPageState();
}


class _MyCuentaPageState extends State<MyCuentaPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar cuentas...',
        defaultBar: AppBar(
//          leading: IconButton( icon: Icon(Icons.menu ),
//            onPressed: _openDrawer,
//          ),
          title: const Text('Cuentas',
            style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: Center(
        child: FutureBuilder<List<Cuenta>>(                                   // function
          future: Buscar.downloadCuenta( widget.value ),                      // Cambio, pasa el String y lo carga al objeto
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Cuenta> cuentas = snapshot.data;                        // defino la variable cuentas
              return CustomListView(cuentas: cuentas);                    // Es el Widget detalle
            }
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            //return  a circular progress indicator.
            return new CircularProgressIndicator();
          },
        ),
      ),
/*
        floatingActionButton:Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.add),
                  backgroundColor: Colors.teal,
                  onPressed: ()  {
                  }
              ),
            ]
        )
*/
    );
  }
}


class CustomListView extends StatefulWidget {
  final List<Cuenta> cuentas;
  CustomListView({Key key, this.cuentas}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState(this.cuentas);
}

class _CustomListViewState extends State<CustomListView> {
  final List<Cuenta> cuentas;

  _CustomListViewState(this.cuentas);

  @override
  void initState() {
    if ( globals.auxiliarSaved == 0 ) {
      globals.cuentaSaved = int.parse( widget.cuentas.first.id );
      globals.cuentaNamed = widget.cuentas.first.descripcion;
    }
  }


  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: cuentas.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(cuentas[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Cuenta cuenta, BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
            title: Text(
              cuenta.descripcion,
              style: new TextStyle(fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
              ),
            trailing: Icon(
              globals.cuentaSaved == int.parse(cuenta.id) ? Icons.check_circle : Icons.cancel,   // panorama_fish_eye, Icons.loop
              color: globals.cuentaSaved == int.parse(cuenta.id) ? Colors.teal : null,
              ),

            onTap: () {
              setState(() {
                globals.cuentaSaved = int.parse(cuenta.id);
                globals.cuentaNamed = cuenta.descripcion;

                print('cuenta: ${globals.cuentaSaved}');
//                Navigator.pop(context, 'Yep!');
              });
            }
        ),

        Divider(),                                                              // <-- Divider

      ],
    );
  }

}
