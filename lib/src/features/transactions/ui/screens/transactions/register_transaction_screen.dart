import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:facilapp/src/features/transactions/models/activity.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/splash_information_widget.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

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
  String _auxiliary;
  String _activitySearch;
  String _valueSearch;
  String _auxiliarySearch;
  File _image;
  List<DropdownMenuItem<String>> _listActivity;
  List<DropdownMenuItem<String>> _listAccount;
  List<DropdownMenuItem<String>> _listAuxiliary;
  List<Activity> _listA;

  List<dynamic> _images = [];
  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text;
  var cont = 0;

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

  void initState() {
    super.initState();
    cont = 0;
    _transactionCubit = BlocProvider.of<TransactionCubit>(context);
    _transaction = widget.transaction;
    _speech = stt.SpeechToText();
    if (_transaction != null) {
      _value.text = _transaction.value.toString();
      _observation.text = _transaction.observation;
      _activity = _transaction.idActivity.toString();
      _account = _transaction.account;
      _images = _transaction.images;
      _auxiliary = _transaction.docAuxiliary.toString();
      _text = _transaction.activity +
          ' ' +
          _transaction.value.toString() +
          ' ' +
          _transaction.auxiliary;
    }
    _search.text = _text;
    loadingActivities();
    // loadingAccounts();
  }

  void loadingActivities() async {
    await _transactionCubit.getActivities(number: '2');
  }

  void loadingAuxiliaries() async {
    var _type;
    _listA.forEach((element) {
      if (element.id.toString() == _activity) {
        _type = element.type.toString();
      }
    });
    await _transactionCubit.getAuxiliaries(number: '2', type: _type);
  }

  void loadingAccounts() async {
    await _transactionCubit.getAccounts();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoading) {
          return SplashInformation(
            color: OcoboColors.primaryColor,
            icon: Icons.thumb_up,
            text: 'Procesando...',
          );
        }
        if (state is UpdateTransaction) {
          if (state.success) {
            Future.delayed(Duration.zero, () {
              Navigator.pushNamed(context, routes.HomeTransactionsPageRoute);
            });
            // Navigator.pop(context, true);
          }
        }
        if (state is RegisteredTransaction) {
          if (state.success) {
            Navigator.pop(context, true);
          }
        }
        if (state is GetActivities) {
          _listA = state.listActivities;
          List<DropdownMenuItem<String>> listActivity = List.generate(
            _listA.length,
            (index) => DropdownMenuItem(
                child: Text(
                  _listA[index].description,
                ),
                value: _listA[index].id.toString()),
          );
          _listActivity = listActivity;
          loadingAuxiliaries();
        }
        if (state is GetAuxiliaries) {
          final _list = state.listAuxiliaries;
          List<DropdownMenuItem<String>> listAuxiliary = List.generate(
            _list.length,
            (index) => DropdownMenuItem(
                child: Text(
                  _list[index].description,
                ),
                value: _list[index].id.toString()),
          );
          _listAuxiliary = listAuxiliary;
          loadingAccounts();
        }
        if (state is GetAccounts) {
          final _list = state.listAccounts;
          List<DropdownMenuItem<String>> listAccount = List.generate(
            _list.length,
            (index) => DropdownMenuItem(
                child: Text(
                  _list[index].description,
                ),
                value: _list[index].id.toString()),
          );
          _listAccount = listAccount;
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
                padding: const EdgeInsets.only(right: 20.0, left: 20.0, top: 5),
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
                      isExpanded: true,
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
                        _auxiliary = null;
                        loadingAuxiliaries();
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione una actividad';
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
                      isExpanded: true,
                      decoration: InputDecoration(
                          labelText: 'Auxiliar',
                          prefixIcon:
                              Icon(Icons.perm_identity, color: Colors.black)),
                      items: _listAuxiliary,
                      value: _auxiliary,
                      onChanged: (value) {
                        setState(() {
                          _auxiliary = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione un auxiliar';
                        }
                        return null;
                      },
                    ),
                    DropdownButtonFormField(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Cuenta',
                        prefixIcon: Icon(Icons.account_balance_outlined,
                            color: Colors.black),
                      ),
                      items: _listAccount,
                      value: _account,
                      onChanged: (value) {
                        setState(() {
                          _account = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Seleccione una cuenta';
                        }
                        return null;
                      },
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Material(
                            elevation: 10,
                            child: Container(
                                width: screenSize.width,
                                height: screenSize.width * 0.5,
                                child: CarouselSlider(
                                  options: CarouselOptions(),
                                  items: _images
                                      .map((item) => Container(
                                            decoration: _image != null ||
                                                    _transaction != null
                                                ? BoxDecoration(
                                                    image: DecorationImage(
                                                        fit: BoxFit.contain,
                                                        image: _transaction ==
                                                                null
                                                            ? FileImage(item)
                                                            : NetworkImage(
                                                                item)))
                                                : null,
                                          ))
                                      .toList(),
                                )),
                          ),
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
                    SizedBox(
                      width: 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AvatarGlow(
                animate: _isListening,
                glowColor: Theme.of(context).primaryColor,
                endRadius: 40.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 100),
                repeat: true,
                child: FloatingActionButton(
                  heroTag: 1,
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                ),
              ),
              // SizedBox(
              //   width: 10,
              // ),
              FloatingActionButton(
                heroTag: 2,
                child: Icon(Icons.save_outlined),
                onPressed: () async {
                  if (!_formRegisterTransaction.currentState.validate() ||
                      _images.length == 0) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                          'Debe completar todos los campos requeridos y cargar al menos un soporte',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          IconButton(
                            icon: Icon(
                              Icons.check,
                              color: OcoboColors.primaryColor,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                    return;
                  }
                  // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
                  if (widget.transaction != null) {
                    _transactionCubit.updateTransaction(
                        transaction: Transaction(
                            id: widget.transaction.id,
                            idActivity: int.parse(_activity),
                            value: double.parse(
                              _value.text,
                            ),
                            docAuxiliary: int.parse(_auxiliary),
                            account: _account,
                            observation: _observation.text));
                  } else {
                    var now = DateTime.now();
                    BlocProvider.of<TransactionCubit>(context)
                        .registerTransaction(
                            transaction: Transaction(
                                date: DateFormat('yyyy-MM-dd hh:mm')
                                    .format(now)
                                    .toString(),
                                status: 12601,
                                idActivity: int.parse(_activity),
                                docAuxiliary: int.parse(_auxiliary),
                                account: _account,
                                value: double.parse(_value.text),
                                images: _images,
                                observation: _observation.text));
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void textSearch(List<String> _query) {
    var position = 1;
    _query.forEach((element) {
      _activitySearch += element;
      // if (position == 1) {
      //   _activitySearch += element;
      // }
      // if (element.startsWith('0') ||
      //     element.startsWith('1') ||
      //     element.startsWith('2') ||
      //     element.startsWith('3') ||
      //     element.startsWith('4') ||
      //     element.startsWith('5') ||
      //     element.startsWith('6') ||
      //     element.startsWith('7') ||
      //     element.startsWith('8') ||
      //     element.startsWith('9')) {
      //   _valueSearch = element;
      //   position = 3;
      // }
      // if (position == 3) {
      //   _auxiliarySearch += element;
      // }
    });
    print(_activitySearch);
    print(_valueSearch);
    print(_activitySearch);
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _search.text = _text;
            // var n = _text.split(' ');
            // textSearch(n);
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
