import 'package:flutter/material.dart';
import 'package:loader_search_bar/loader_search_bar.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final int _cartItemsCounter;

  MyAppBar(this._cartItemsCounter, {Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;
  @override
  _MyAppBarState createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {

  String _queryText;

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

  onQuerySubmitted(BuildContext context, String query) {
    _queryText = '$query';
    print('_onQuerySubmitted: ${_queryText}');
    setState(() => _queryText = '$query');                                      // 'Query submitted!'
  }

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
          onQueryChanged: (query) => onQueryChanged(context, query),            // Cambio, este es
          onQuerySubmitted: (query) => onQuerySubmitted(context, query),
      ),
    );

  }

  Widget shoppingCartIcon(BuildContext context) {

    final badge = widget._cartItemsCounter != 0 ? counterBadge() : Container();

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
          '${widget._cartItemsCounter}',
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
