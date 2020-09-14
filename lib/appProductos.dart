import 'package:flutter/material.dart';

import 'package:facilapp/pos/presentation/home/home_page.dart';

class AppProductos extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
//      title: 'Shopping Cart Flutter',
      theme: ThemeData(
//        primarySwatch: Colors.teal[900],
        primaryColor: Colors.teal[900],
        primarySwatch: Colors.teal,                                             // Color de sombra

        canvasColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
