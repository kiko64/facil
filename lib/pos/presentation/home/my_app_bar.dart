import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int _cartItemsCounter;

  MyAppBar(this._cartItemsCounter, {Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; //

  @override
  Widget build(BuildContext context) {

/*
    return AppBar(
      title: Image.asset(
        'assets/images/logo.png',
        width: 130.0,
      ),
      actions: <Widget>[
        shoppingCartIcon(context)
      ],
    );
*/

    return Scaffold(
      appBar: SearchBar(
        iconified: true,
        searchHint: 'Buscar productos...',
        defaultBar: AppBar(
          title: Text('Productos',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),
          actions: <Widget>[
            shoppingCartIcon(context)
          ],
        ),
//        onQueryChanged: (query) => onQueryChanged(context, query),            // Cambio, este es
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
