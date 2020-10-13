import 'package:facilapp/screens/splashScreen.dart';
import 'package:flutter/material.dart';

class OcoboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: SplashOcobo(),
    );
  }
}
