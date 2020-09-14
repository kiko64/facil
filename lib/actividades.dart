import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';


class MyActividadPage extends StatefulWidget {
  final String value;
  MyActividadPage({Key key, this.value}) : super(key: key);                     // Cambio

  @override
  _MyActividadPageState createState() => _MyActividadPageState();
}


class _MyActividadPageState extends State<MyActividadPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar actividades...',
        defaultBar: AppBar(
//          leading: IconButton( icon: Icon(Icons.menu ),
//            onPressed: _openDrawer,
//          ),
          title: const Text('Actividades',
            style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: Center(
        //FutureBuilder is a widget that builds itself based on the latest snapshot
        // of interaction with a Future.
        child: FutureBuilder<List<Actividad>>(                                  // function
          future: Buscar.downloadActividad( widget.value ),                     // Cambio, pasa el String y lo carga al objeto
          //we pass a BuildContext and an AsyncSnapshot object which is an
          //Immutable representation of the most recent interaction with
          //an asynchronous computation.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Actividad> actividades = snapshot.data;                      // defino la variable actividades
              return CustomListView(actividades: actividades);                  // Es el Widget detalle
            } else if (snapshot.hasError) {
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
  final List<Actividad> actividades;
  CustomListView({Key key, this.actividades}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState(this.actividades);
}

class _CustomListViewState extends State<CustomListView> {
  final List<Actividad> actividades;

  _CustomListViewState(this.actividades);

  @override
  void initState() {
    if ( globals.actividadSaved == 0 ) {
      globals.actividadSaved = int.parse(widget.actividades.first.id);
      globals.actividadNamed = widget.actividades.first.descripcion;
    }
  }

  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: actividades.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(actividades[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Actividad actividad, BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(

            trailing: Icon(
              globals.actividadSaved == int.parse(actividad.id) ? Icons.check_circle : Icons.cancel,
              color: globals.actividadSaved == int.parse(actividad.id) ? Colors.teal : null,
              ),

            title: Text(

              actividad.descripcion,
              style: new TextStyle(fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
              ),

            onTap: () {
              setState(() {
                globals.actividadSaved = int.parse(actividad.id);
                globals.actividadNamed = actividad.descripcion;
                globals.tipoSaved      = actividad.tipo;
                print('actividad: ${globals.actividadSaved}');
                Navigator.pop(context);

              });
            }
        ),

        Divider(),                                                              // <-- Divider

      ],
    );
  }

}
