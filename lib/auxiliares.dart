import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

class MyAuxiliarPage extends StatefulWidget {
  final String value;
  MyAuxiliarPage({Key key, this.value}) : super(key: key);                      // Cambio

  @override
  _MyAuxiliarPageState createState() => _MyAuxiliarPageState();
}


class _MyAuxiliarPageState extends State<MyAuxiliarPage> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar auxiliares...',
        defaultBar: AppBar(
//          leading: IconButton( icon: Icon(Icons.menu ),
//            onPressed: _openDrawer,
//          ),
          title: const Text('Auxiliares',
            style: TextStyle(fontSize: 16.0,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),

      body: Center(
        child: FutureBuilder<List<Auxiliar>>(                                   // function
          future: Buscar.downloadAuxiliar( widget.value ),                      // Cambio, pasa el String y lo carga al objeto
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Auxiliar> auxiliares = snapshot.data;                        // defino la variable auxiliares
              return CustomListView(auxiliares: auxiliares);                    // Es el Widget detalle
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
  final List<Auxiliar> auxiliares;
  CustomListView({Key key, this.auxiliares}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState(this.auxiliares);
}

class _CustomListViewState extends State<CustomListView> {
  final List<Auxiliar> auxiliares;

  _CustomListViewState(this.auxiliares);

  @override
  void initState() {
    if ( globals.auxiliarSaved == 0 ) {
      globals.auxiliarSaved = int.parse( widget.auxiliares.first.id );
      globals.actividadNamed = widget.auxiliares.first.descripcion;
    }
  }


  @override
  Widget build(context) {
    return ListView.builder(
      itemCount: auxiliares.length,
      itemBuilder: (context, int currentIndex) {
        return createViewItem(auxiliares[currentIndex], context);
      },
    );
  }


  Widget createViewItem(Auxiliar auxiliar, BuildContext context) {

    return Column(
      children: <Widget>[
        ListTile(
            title: Text(
              auxiliar.descripcion,
              style: new TextStyle(fontWeight: FontWeight.normal),
              textAlign: TextAlign.left,
              ),
            trailing: Icon(
              globals.auxiliarSaved == int.parse(auxiliar.id) ? Icons.check_circle : Icons.cancel,   // panorama_fish_eye, Icons.loop
              color: globals.auxiliarSaved == int.parse(auxiliar.id) ? Colors.teal : null,
              ),

            onTap: () {
              setState(() {
                globals.auxiliarSaved = int.parse(auxiliar.id);
                globals.auxiliarNamed = auxiliar.descripcion;

                print('auxiliar: ${globals.auxiliarSaved}');
//                Navigator.pop(context, 'Yep!');
              });
            }
        ),

        Divider(),                                                              // <-- Divider

      ],
    );
  }

}
