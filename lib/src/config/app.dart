import 'package:facilapp/src/router/routes.dart';
import 'package:facilapp/src/styles/theme.dart';
import 'package:flutter/material.dart';

class OcoboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: myTheme,
    initialRoute: '/',
    routes:  routes(),
    // home: OcoboApp(),
  );
  }
}
