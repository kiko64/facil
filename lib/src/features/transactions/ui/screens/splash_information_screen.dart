import 'dart:core';
import 'dart:async';
import 'package:facilapp/src/features/transactions/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class SplashInformation extends StatefulWidget {
  String navigator;
  Color color;
  IconData icon;
  String text;
  SplashInformation({
    this.navigator,
    this.color,
    this.icon,
    this.text
  });
  @override
  _SplashInformationState createState() => _SplashInformationState();
}

class _SplashInformationState extends State<SplashInformation> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      // if (widget.navigateAfterSeconds is String) {
      //   // It's fairly safe to assume this is using the in-built material
      //   // named route component
      //   Navigator.of(context).pushReplacementNamed(widget.navigateAfterSeconds);
      // } else if (widget.navigateAfterSeconds is Widget) {
      //   Navigator.of(context).pushReplacement(new MaterialPageRoute(
      //       builder: (BuildContext context) => widget.navigateAfterSeconds));
      // } else {
      //   throw new ArgumentError(
      //       'widget.navigateAfterSeconds must either be a String or Widget');
      // }
      // widget.navigator;
      Navigator.pushNamed(context, widget.navigator);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
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
                        radius: 100,
                        backgroundColor: widget.color,
                        child: Icon(
                          // Icons.thumb_up,
                          widget.icon,
                          size: 100,
                          color: Colors.white,
                        )
                        // new Container(child: Image.asset('assets/ocoboSoft.png')),
                        // radius: 100,
                        ),
                    new Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                    ),
                    Text(
                      widget.text,
                      // '¡Transacción almacenada con éxito!',
                      style: TextStyle(color: Color(0xff9F9F9F)),
                    )
                    // widget.title
                  ],
                )),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(top: 60),
                    child: Loading(
                      indicator: BallPulseIndicators(),
                      size: 100.0,
                      color: widget.color,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
