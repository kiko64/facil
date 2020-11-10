import 'package:facilapp/src/router/router.dart' as router;
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:facilapp/src/styles/theme.dart';
import 'package:flutter/material.dart';

class OcoboApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    theme: myTheme,
    initialRoute: routes.SplashRoute,
    onGenerateRoute: router.generateRoute,

    // home: OcoboApp(),
  );
  }
}
