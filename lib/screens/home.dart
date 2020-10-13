// import 'dart:html';

import 'package:facilapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  //Posicion de la pantalla  
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: new InkWell(
        // onTap: widget.onClick,
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            // new Container(
            //   decoration: new BoxDecoration(
            //     image: widget.imageBackground == null
            //         ? null
            //         : new DecorationImage(
            //             fit: BoxFit.cover,
            //             image: widget.imageBackground,
            //           ),
            //     gradient: widget.gradientBackground,
            //     color: widget.backgroundColor,
            //   ),
            // ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  flex: 2,
                  child: new Container(
                      child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: new Container(
                            child: Image.asset('assets/ocoboSoft.png')),
                        radius: 100.0,
                      ),
                      new Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                      ),
                      // widget.title
                    ],
                  )),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 40,
                        width: 300,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          textColor: Colors.white,
                          color: Color(0xff6A9426),
                          child: Text(
                            'Iniciar sesión',
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Poppins"),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 40,
                        width: 300,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          textColor: Colors.white,
                          color: Color(0xff6A9426),
                          child: Text(
                            'Registrate',
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Poppins"),
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
