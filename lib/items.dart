import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'globals.Dart' as globals;

import 'package:facilapp/librerias/modeloEjecutar.dart';
import 'package:facilapp/librerias/servicioEjecutar.dart';

List<Item> items;                                                               // defino la variable items

class MyItemPage extends StatefulWidget {
  final String value;
  MyItemPage({Key key, this.value}) : super(key: key);                          // Pendiente

  int _cartItemsCounter;

  @override
  _MyItemPageState createState() => _MyItemPageState();
}


class _MyItemPageState extends State<MyItemPage> {

  String _queryText;

  get _cartItemsCounter => 18;                                                  // Cambio,

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
        searchHint: 'Buscar items...',
        defaultBar: AppBar(
          title: Text('Items',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),
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
        child: FutureBuilder<List<Item>> (                                      // function
//          future: downloadItem( _queryText ),                                 // Cambio, Aqui es donde cambio
          future: Buscar.searchloadItem( widget.value, _queryText ),            // Cambio, Aqui es donde cambio
          //We pass a BuildContext and an AsyncSnapshot object which is an
          //Immutable representation of the most recent interaction with
          //an asynchronous computation.
          builder: (context, snapshot) {
            if (snapshot.hasData) {
//              List<Item> items;                                               // traslado la definición de la variable items al principio
              items = snapshot.data;                                            // defino la variable items
              return CustomListView();                                          // Es el Widget detalle CustomListView(items: items);
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

    final badge = _cartItemsCounter != 0 ? counterBadge() : Container();

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
          '$_cartItemsCounter',
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
//  final List<Item> items;
//  CustomListView({Key key, this.items}) : super(key: key);

  @override
  _CustomListViewState createState() => _CustomListViewState();                 // _CustomListViewState(this.items);
}


class _CustomListViewState extends State<CustomListView> {
//  final List<Item> items;
//  _CustomListViewState(this.items);

  @override
  void initState() {

    if ( globals.itemSaved == 0 ) {
      globals.itemSaved = int.parse(items.first.id);                            // widget.
      globals.itemNamed = items.first.descripcion;                              // widget.

    }
  }


  @override
  Widget build(context) {
    return GridView.builder(
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(                   // SliverGridDelegateWithMaxCrossAxisExtent
          maxCrossAxisExtent: 250.0, childAspectRatio: 0.9),

      itemBuilder: (context, int currentIndex) {
        return createViewItem( items[currentIndex], context );
      },
    );
  }


  Widget createViewItem(Item item, BuildContext context) {

    return Card(
        elevation: 4.0,
        child: Column(
          children: <Widget>[
            Expanded( flex: 4, child: Image.asset('assets/12601.png'), ),
            Padding(
              padding: EdgeInsets.all(4),
              child: Text(
                item.id,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.body1,
                ),
              ),
            Text(item.descripcion, style: TextStyle(fontSize: 12.0, color: Colors.black,),),
            RawMaterialButton(
              child: Text(
                'Add to cart'.toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Theme.of(context).primaryColor),
                ),
//              onPressed: ()=> _addProductToCartCallback(_productItem),
            )
          ],
        )
    );
  }

}

