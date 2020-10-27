import 'package:facilapp/src/features/transactions/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';



class SplashOcobo extends StatefulWidget {
  @override
  void initState(){
 
  SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
  ]);
}
  _SplashOcoboState createState() => new _SplashOcoboState();
}

class _SplashOcoboState extends State<SplashOcobo> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      image: Image.asset('assets/ocoboSoft.png'),
      styleTextUnderTheLoader: new TextStyle(),
      photoSize: 100.0,
      // loaderColor: Color(0xff6A9426),
    ); 
  }
}
