import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';


class MySoportePage extends StatefulWidget {
  final String value;
  MySoportePage({Key key, this.value}) : super(key: key);                       // Cambio

  @override
  _MySoportePageState createState() => _MySoportePageState();
}


class _MySoportePageState extends State<MySoportePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Soportes',style: TextStyle( fontSize: 16.0, fontWeight: FontWeight.bold ), ),

        ),
        body: Stack(
          children: [
            Center(child: CircularProgressIndicator()),
            Center(
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
//                image: 'https://ocobosoft.000webhostapp.com/tmp/image_picker2370246501564009452.jpg',
                  image: widget.value,
              ),
            ),
          ],
        ),
    );
  }
}
