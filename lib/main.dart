import 'package:facilapp/app/app.dart';
import 'package:facilapp/screens/home.dart';
import 'package:facilapp/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: OcoboApp(),
    routes: <String, WidgetBuilder>{
      '/home': (BuildContext context) => Home(),
      '/login': (BuildContext context) => Login(),
    },
  ));
}
