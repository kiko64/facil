import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;
import 'package:transparent_image/transparent_image.dart';

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

List<Producto> productos;                                                       // defino la variable productos

class MyProductoPage extends StatefulWidget {
  final String value;
  MyProductoPage({Key key, this.value}) : super(key: key);                      // Pendiente

  final int _cartProductosCounter = 0;

  @override
  _MyProductoPageState createState() => _MyProductoPageState();
}


class _MyProductoPageState extends State<MyProductoPage> {

  String _queryText;

//  get _cartProductosCounter => null;

  get _cartProductosCounter => 18;                                              // Cambio,

  @override
  void initState() {
    _queryText = '';                                                            // Cambio,
    super.initState();
  }

  void onQueryChanged(BuildContext context, String query) {

    setState(() {
      _queryText = '$query';                                                    // Cambio,
    });
  }

// https://youtu.be/nQBpOIHE4eE

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar productos...',
        defaultBar: AppBar(
          title: Text('Productos',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),
          actions: <Widget>[
            shoppingCartIcon(context)
          ],
        ),
        onQueryChanged: (query) => onQueryChanged(context, query),              // Cambio,
//        onQuerySubmitted: (query) => onQuerySubmitted(context, query),
      ),

      body: Center(
        //FutureBuilder is a widget that builds itself based on the latest snapshot
        // of interaction with a Future.
        child: FutureBuilder<List<Producto>> (                                  // function
//          future: downloadProducto( _queryText ),                             // Cambio, Aqui es donde cambio
          future: Buscar.searchloadProducto( widget.value, _queryText ),        // Cambio, Aqui es donde cambio
          //We pass a BuildContext and an AsyncSnapshot object which is an
          //Immutable representation of the most recent interaction with
          //an asynchronous computation.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//              List<Producto> productos;                                       // traslado la definición de la variable productos al principio
              productos = snapshot.data;                                        // defino la variable productos
              return CustomListView();                                          // Es el Widget detalle CustomListView(productos: productos);
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

  Widget shoppingCartIcon(BuildContext context) {

    final badge = _cartProductosCounter != 0 ? counterBadge() : Container();

    // Using Stack to show Notification Badge
    return Stack(
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ),
        badge
      ],
    );
  }

  Widget counterBadge() {

    return Positioned(
      right: 8,
      top: 2,
      child: Container(
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
          ),
        constraints: const BoxConstraints(
          minWidth: 18,
          minHeight: 18,
          ),
        child: Text(
//          "1",
          '$_cartProductosCounter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10,
            ),
          textAlign: TextAlign.center,
          ),
        ),
      );
  }

}


class CustomListView extends StatefulWidget {
//  final List<Producto> productos;
//  CustomListView({Key key, this.productos}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();                 // _CustomListViewState(this.productos);
}


class _CustomListViewState extends State<CustomListView> {
//  final List<Producto> productos;
//  _CustomListViewState(this.productos);

  @override
  void initState() {

    if ( globals.productoSaved == 0 ) {
      globals.productoSaved = int.parse(productos.first.id);                    // widget.
      globals.productoNamed = productos.first.descripcion;                      // widget.

    }
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
//      _cartProductosCounter++;
    });
  }


  @override
  Widget build(context) {
    return GridView.builder(
      itemCount: productos.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(                   // SliverGridDelegateWithMaxCrossAxisExtent
          maxCrossAxisExtent: 250.0, childAspectRatio: 0.9),

      itemBuilder: (context, int currentIndex) {
        return createViewProducto( productos[currentIndex], context );
      },
    );
  }


  Widget createViewProducto(Producto producto, BuildContext context) {

    return Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[                                                   //
            Expanded( flex: 4,
//              child: Image.asset('assets/12601.png'),
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: 'https://ocobosoft.000webhostapp.com/imagen/' + producto.id + '.png',
              ),
            ),

            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                producto.id,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body1,
                ),
              ),

            Text(producto.descripcion, style: TextStyle(fontSize: 12.0, color: Colors.black,),),

            RawMaterialButton(
              child: Text(
                'Add to cart'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Theme.of(context).primaryColor),
                ),
                onPressed: _incrementCounter,
//              onPressed: ()=> _addProductToCartCallback(_productProducto),
            )
          ],
        )
    );
  }

}
