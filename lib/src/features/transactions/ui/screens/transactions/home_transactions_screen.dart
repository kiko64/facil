import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/list_transaction_screen.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_search.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class TransaccionScreen extends StatefulWidget {
  @override
  _TransaccionScreenState createState() => _TransaccionScreenState();
}

class _TransaccionScreenState extends State<TransaccionScreen> {
  bool filter;
  @override
  void initState() {
    super.initState();
    filter = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerOcobo(),
        appBar: AppbarSearch(title: 'Transacciones',),
        body: ListTransaccion(),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Color(0xff6A9426),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, routes.RegisterTransactionPageRoute);
          },
        ));
  }
}
