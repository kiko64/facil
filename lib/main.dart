import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

final ThemeData kIOSTheme = new ThemeData(

  primarySwatch: Colors.teal,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,

  );

final ThemeData kDefaultTheme = new ThemeData(

  primarySwatch: Colors.teal,                                             // Color de sombra
  primaryColor: Colors.teal,

//        primaryColorBrightness: Brightness.light,
//        primaryIconTheme: const IconThemeData.fallback().copyWith(
//          color: Colors.white,                                                // Cambiar globalmente el color del icono
//          ),

  primaryTextTheme: TextTheme(
      title: TextStyle(
          color: Colors.white                                             // Cambiar globalmente el color del titulo
          )
      ),
  );

void main() {

  WidgetsFlutterBinding.ensureInitialized();                                    // Arreglo
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
//      statusBarColor: Colors.white,                                           //top bar color
//      statusBarIconBrightness: Brightness.dark,                               //top bar icons
//      systemNavigationBarColor: Colors.white,                                 //bottom bar color
//      systemNavigationBarIconBrightness: Brightness.dark,                     //bottom bar icons
)
      );


      runApp(facilApp());

}

//void main() => runApp(OirApp());
