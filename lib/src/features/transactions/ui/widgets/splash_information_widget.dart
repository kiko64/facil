import 'dart:core';
import 'package:facilapp/src/features/transactions/ui/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:loading/loading.dart';

class SplashInformation extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  SplashInformation({this.color, this.icon, this.text});

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
                        backgroundColor: color,
                        child: Icon(
                          // Icons.thumb_up,
                          icon,
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
                      text,
                      // '¡Transacción almacenada con éxito!',
                      style: TextStyle(color: Color(0xff9F9F9F)),
                    )
                    // title
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
                      color: color,
                    ),
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
