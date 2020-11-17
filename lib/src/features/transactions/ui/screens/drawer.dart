import 'package:facilapp/pos/presentation/cart/widgets/cart_drawer.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class DrawerOcobo extends StatelessWidget {
  String selected;
  DrawerOcobo({this.selected});
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.height * 0.3;
    return Drawer(
      child: ListView(
        children: [
          // UserAccountsDrawerHeader(
          //     currentAccountPicture: CircleAvatar(  child: Text('Logo Cliente', textAlign: TextAlign.center,)),
          //     accountName: Text('Nombre de Usuario'),
          //     accountEmail: Text('correo@gmail.com')),
          DrawerHeader(
              child: Column(
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: OcoboColors.primaryColor,
                  shape: BoxShape.circle,
                  // image: DecorationImage(image: NetworkImage(''))
                ),
                child: Align(
                    alignment: Alignment(0, 0),
                    child: Text('Logo Cliente',
                        style: TextStyle(
                            fontFamily: "Poppins", color: Colors.white))),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Nombre de Usuario',
                style: TextStyle(fontFamily: "Poppins"),
              ),
              Text('correo@gmail.com'),
            ],
          )),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined),
            title: Text(
              'Transacciones',
              // style: TextStyle(color: Colors.white),
            ),
            selected: true,
            // selectedTileColor: OcoboColors.primaryColor,
            onTap: () {
              Navigator.pushNamed(context, routes.HomeTransactionsPageRoute);

              // Navigator.pushNamed(context, '/homeTransactions');
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books_outlined),
            focusColor: OcoboColors.primaryColor,
            title: Text('Comprobantes'),
            onTap: () {
              Navigator.pushNamed(context, routes.HomeVochersPageRoute);
              // Navigator.pushNamed(context, '/homeVouchers');
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart_outlined),
            title: Text('POS'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: screenSize),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text('Configuración'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
                ListTile(
                  leading: Icon(Icons.login),
                  title: Text('Cerrar sesión'),
                  onTap: () {
                    // Update the state of the app.
                    // ...
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
