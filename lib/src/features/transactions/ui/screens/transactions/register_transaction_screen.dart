import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class RegisterTransaction extends StatefulWidget {
  @override
  _RegisterTransactionState createState() => _RegisterTransactionState();
}

class _RegisterTransactionState extends State<RegisterTransaction> {
  final TextEditingController _search = TextEditingController();
  final TextEditingController _value = TextEditingController();
  final TextEditingController _observation = TextEditingController();
  final _formRegisterTransaction = GlobalKey<FormState>();
  String _activity;
  String _account;
  String _auxiliary;
  File _image;

  final List<File> _images = [];

  //Función para la galeria
  Future getImageGallery() async {
    // final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _images.add(_image);
    });
  }

  //Función para la camara
  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _images.add(_image);
    });
  }

  List<DropdownMenuItem<String>> listDrop2 = [
    new DropdownMenuItem(
        child: new Text(
          "Ingeniería ambiental",
        ),
        value: "Ingeniería ambiental"),
    new DropdownMenuItem(
        child: new Text(
          'Adm. medio ambiente',
        ),
        value: 'Adm. medio ambiente'),
    new DropdownMenuItem(
        child: new Text(
          'Biólogo',
        ),
        value: 'Biólogo')
  ];

  //Lista para el select de actividad
  List<DropdownMenuItem<String>> listActivity = [
    DropdownMenuItem(
        child: Text(
          "Liquidar Nomina",
        ),
        value: "Liquidar Nomina"),
    DropdownMenuItem(
        child: Text(
          'Servicio público',
        ),
        value: 'Servicio público'),
  ];

  //Lista para el select de actividad
  List<DropdownMenuItem<String>> listAuxiliary = [
    DropdownMenuItem(
        child: Text(
          "Celsia",
        ),
        value: "Celsia"),
    DropdownMenuItem(
        child: Text(
          'Alcanos',
        ),
        value: 'Alcanos'),
  ];

  //Lista para el select de cuenta
  List<DropdownMenuItem<String>> listAccount = [
    DropdownMenuItem(
        child: Text(
          "Efectivo",
        ),
        value: "Efectivo"),
    DropdownMenuItem(
        child: Text(
          'Transacción',
        ),
        value: 'Transacción'),
  ];

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      drawer: DrawerOcobo(),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Registro de Transacción'),
      ),
      body: Form(
        key: _formRegisterTransaction,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 30.0, left: 30.0, top: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _search,
                  decoration: InputDecoration(
                      hintText: 'Actividad,valor,auxiliar',
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      prefixIcon: Icon(Icons.search, color: Colors.black,)),
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Actividad',
                    prefixIcon: Icon(Icons.list_alt, color: Colors.black),
                  ),
                  items: listActivity,
                  value: _activity,
                  onChanged: (value) {
                    setState(() {
                      _activity = value;
                    });
                  },
                  validator: (value) {
                    if (_activity.isEmpty) {
                      return 'Debe Seleccionar';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _value,
                  decoration: InputDecoration(
                    labelText: 'Valor',
                    prefixIcon: Icon(Icons.attach_money_outlined, color: Colors.black),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Ingrese un valor';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Auxiliar',
                      prefixIcon: Icon(Icons.perm_identity, color: Colors.black)),
                  items: listAuxiliary,
                  value: _auxiliary,
                  onChanged: (value) {
                    setState(() {
                      _auxiliary = value;
                    });
                  },
                  validator: (value) {
                    if (_auxiliary.isEmpty) {
                      return 'Debe Seleccionar';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField(
                  decoration: InputDecoration(
                    labelText: 'Cuenta',
                    prefixIcon: Icon(Icons.account_balance_outlined, color: Colors.black),
                  ),
                  items: listAccount,
                  value: _account,
                  onChanged: (value) {
                    setState(() {
                      _account = value;
                    });
                  },
                  validator: (value) {
                    if (_account.isEmpty) {
                      return 'Debe Seleccionar';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _observation,
                  decoration: InputDecoration(
                    labelText: 'Observación',
                    prefixIcon: Icon(Icons.rate_review_outlined, color: Colors.black),
                  ),
                ),
                Center(heightFactor: 1.5, child: Text('Soportes')),
                Stack(
                  children: [
                    Material(
                      elevation: 10,
                      child: Container(
                          width: screenSize.width * 0.9,
                          height: screenSize.width * 0.5,
                          child: CarouselSlider(
                            options: CarouselOptions(),
                            items: _images
                                .map((item) => Container(
                                      decoration: _image != null
                                          ? BoxDecoration(
                                              image: DecorationImage(
                                                  fit: BoxFit.contain,
                                                  image: FileImage(item)))
                                          : null,
                                    ))
                                .toList(),
                          )),
                    ),
                    _images.length <= 4
                        ? Positioned(
                            left: 5,
                            bottom: 5,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  heroTag: 3,
                                  mini: true,
                                  onPressed: () {
                                    getImageCamera();
                                  },
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: OcoboColors.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                FloatingActionButton(
                                  backgroundColor: Colors.white,
                                  heroTag: 4,
                                  mini: true,
                                  onPressed: () {
                                    getImageGallery();
                                  },
                                  child: Icon(
                                    Icons.collections,
                                    color: OcoboColors.primaryColor,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            child: Icon(Icons.mic_none),
            onPressed: () {
              Navigator.of(context).pushNamed('/registerTransaction');
            },
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            child: Icon(Icons.save_outlined),
            onPressed: () async {
              if (!_formRegisterTransaction.currentState.validate() ||
                  _images.length == 0) {
                return;
              }
              // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
              // Navigator.of(context).pushNamed('/homeTransactions');
              Navigator.pushNamed(context, routes.SplashInfoRoute, arguments: {
                'navigator': routes.HomeTransactionsPageRoute,
                'color': OcoboColors.primaryColor,
                'icon': Icons.thumb_up,
                'text': '¡Transacción almacenada con éxito!'
              });
            },
          ),
        ],
      ),
    );
  }
}
