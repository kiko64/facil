import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class RegisterTransactionScreen extends StatelessWidget {
  final Transaction transaction;

  const RegisterTransactionScreen({this.transaction});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TransactionCubit(),
      child: RegisterTransaction(
        transaction: transaction,
      ),
    );
  }
}

class RegisterTransaction extends StatefulWidget {
  final Transaction transaction;

  const RegisterTransaction({Key key, this.transaction}) : super(key: key);
  @override
  _RegisterTransactionState createState() => _RegisterTransactionState();
}

class _RegisterTransactionState extends State<RegisterTransaction> {
  Transaction _transaction;
  var _transactionCubit;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _value = TextEditingController();
  final TextEditingController _observation = TextEditingController();
  final _formRegisterTransaction = GlobalKey<FormState>();
  String _activity;
  String _account;
  int _auxiliary;
  File _image;
  List<DropdownMenuItem<String>> _listActivity;

  List<dynamic> _images = [];

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

  //Lista para el select de auxiliar
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
    DropdownMenuItem(
        child: Text(
          'N/A',
        ),
        value: '0'),
  ];
  void initState() {
    super.initState();
    _transactionCubit = BlocProvider.of<TransactionCubit>(context);
    _transaction = widget.transaction;
    _transactionCubit.getActivities(number: '2');
    if (_transaction != null) {
      _value.text = _transaction.value;
      _observation.text = _transaction.observation;
      _activity = _transaction.idActivity.toString();
      _account = _transaction.account;
      _images = _transaction.images;
      // _auxiliary = _transaction.docAuxiliary;
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is GetActivities) {
          final _list = state.listActivities;
          List<DropdownMenuItem<String>> listActivity = List.generate(
            _list.length,
            (index) => DropdownMenuItem(
                child: Text(
                  _list[index].description,
                ),
                value: _list[index].id.toString()),
          );
          _listActivity = listActivity;
        }
        return Scaffold(
          drawer: DrawerOcobo(),
          appBar: AppBar(
            centerTitle: true,
            title: widget.transaction == null
                ? Text('Registro de Transacción')
                : Text('Transacción ${_transaction.id}'),
          ),
          body: Form(
            key: _formRegisterTransaction,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0, left: 25.0, top: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _search,
                      decoration: InputDecoration(
                          hintText: 'Actividad,valor,auxiliar',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          )),
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Actividad',
                        prefixIcon: Icon(Icons.list_alt, color: Colors.black),
                      ),
                      items: _listActivity,
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
                        prefixIcon: Icon(Icons.attach_money_outlined,
                            color: Colors.black),
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
                          prefixIcon:
                              Icon(Icons.perm_identity, color: Colors.black)),
                      items: listAuxiliary,
                      value: _auxiliary,
                      onChanged: (value) {
                        setState(() {
                          _auxiliary = value;
                        });
                      },
                      // validator: (value) {
                      //   if (_auxiliary.isEmpty) {
                      //     return 'Debe Seleccionar';
                      //   }
                      //   return null;
                      // },
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        labelText: 'Cuenta',
                        prefixIcon: Icon(Icons.account_balance_outlined,
                            color: Colors.black),
                      ),
                      items: listAccount,
                      value: _account,
                      onChanged: (value) {
                        setState(() {
                          _account = value;
                        });
                      },
                      // validator: (value) {
                      //   if (_account.isEmpty) {
                      //     return 'Debe Seleccionar';
                      //   }
                      //   return null;
                      // },
                    ),
                    TextFormField(
                      controller: _observation,
                      decoration: InputDecoration(
                        labelText: 'Observación',
                        prefixIcon: Icon(Icons.rate_review_outlined,
                            color: Colors.black),
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
                                          decoration: _image != null || _transaction != null
                                              ? BoxDecoration(
                                                  image: DecorationImage(
                                                      fit: BoxFit.contain,
                                                      image: _transaction ==
                                                              null
                                                          ? FileImage(item)
                                                          : NetworkImage(item)))
                                              : null,
                                        ))
                                    .toList(),
                              )),
                        ),
                        _images.length <= 3
                            ? Positioned(
                                left: 5,
                                bottom: 5,
                                child: Row(
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
                  Navigator.pushNamed(context, routes.SplashInfoRoute,
                      arguments: {
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
      },
    );
  }
}
