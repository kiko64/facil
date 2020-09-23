import 'package:facilapp/pos/models/book.dart';
import 'package:facilapp/pos/presentation/book/cubit/book_cubit.dart';
import 'package:facilapp/utils/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';

class BookScreen extends StatelessWidget {
  const BookScreen({this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookCubit(),
        child: _BookScreen(
          book: book,
        ));
  }
}

class _BookScreen extends StatefulWidget {
  const _BookScreen({
    Key key,
    this.book,
  }) : super(key: key);
  final Book book;
  @override
  BookScreenState createState() => BookScreenState();
}

class BookScreenState extends State<_BookScreen> {
  Book _book;
  var _bookCubit;
  final _nameControler = TextEditingController();
  final _numberPageControler = TextEditingController();
  final _pricePageControler = TextEditingController();
  DateTime _addDateTime;
  bool _stateSelected;
  final _formKeyBook = GlobalKey<FormState>();
  bool _isLoading;

  void initState() {
    super.initState();
    _bookCubit = BlocProvider.of<BookCubit>(context);
    _book = widget.book;
    if (_book != null) {
      _nameControler.text = _book.name;
      _numberPageControler.text = _book.numberOfPages.toString();
      _pricePageControler.text = _book.price.toString();
      _addDateTime = DateTime.parse(_book.publicationDate);
      _stateSelected = _book.status;
    } else {
      _addDateTime = DateTime.now();
      _stateSelected = true;
    }
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    print(_book);
    return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
      if (state is BookLoading) {
        _isLoading = true;
      }
      if (state is BookUpdated) {
        _isLoading = false;
        if (!state.success) {
          print(state.error);
        }
      }
      if (state is RegisteredBook) {
        _isLoading = false;
        if (state.success) {
          _nameControler.text = "";
          _numberPageControler.text = "";
          _pricePageControler.text = "";
          _addDateTime = DateTime.now();
          _stateSelected = true;
        } else {
          print(state.error);
        }
      }
      if (state is DeletedBook) {
        _isLoading = false;
        if (state.success) {
          Navigator.pop(context, true);
        } else {
          print(state.error);
        }
      }
      return LoadingOverlay(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Libro'),
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  if (_book != null) {
                    _bookCubit.deleteBook(id: _book.id);
                  }
                },
              )
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Form(
              key: _formKeyBook,
              child: ListView(
                children: [
                  TextFormField(
                      controller: _nameControler,
                      autocorrect: true,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "No es un dato válido";
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) =>
                          FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                        hintText: "Nombre",
                      )),
                  TextFormField(
                      controller: _numberPageControler,
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "No es un dato válido";
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) =>
                          FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                        hintText: "Numero de paginas",
                      )),
                  TextFormField(
                      controller: _pricePageControler,
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "No es un dato válido";
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) =>
                          FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                        hintText: "Precio",
                      )),
                  TextFormField(
                    controller: TextEditingController(
                        text: DateFormat("yyyy-MM-dd").format(_addDateTime)),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'No es un dato válido';
                      } else {
                        return null;
                      }
                    },
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DatePicker.showDatePicker(context,
                          theme: DatePickerTheme(
                            containerHeight: 210.0,
                          ),
                          showTitleActions: true,
                          minTime: DateTime(1950, 1, 1, 12),
                          maxTime: DateTime(9999, 12, 31, DateTime.now().hour),
                          onConfirm: (date) {
                        setState(() {
                          _addDateTime = date;
                        });
                      }, currentTime: DateTime.now(), locale: LocaleType.es);
                    },
                  ),
                  DropDownFormField(
                    hintText: 'Seleccione',
                    value: _stateSelected,
                    onSaved: (value) {
                      setState(() {
                        _stateSelected = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _stateSelected = value;
                      });
                    },
                    filled: false,
                    dataSource: [
                      {
                        "display": "Activo",
                        "value": true,
                        "icon": null,
                      },
                      {
                        "display": "Inactivo",
                        "value": false,
                        "icon": null,
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    iconField: 'icon',
                  ),
                  SizedBox(height: 10),
                  RaisedButton(
                    child: Text(_book == null ? 'Guardar' : 'Actualizar'),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      if (_formKeyBook.currentState.validate()) {
                        if (_book == null) {
                          BlocProvider.of<BookCubit>(context).registerBook(
                              book: Book(
                                  name: _nameControler.text,
                                  numberOfPages:
                                      int.parse(_numberPageControler.text),
                                  price: double.parse(_pricePageControler.text),
                                  publicationDate: DateFormat("yyyy-MM-dd")
                                      .format(_addDateTime),
                                  status: _stateSelected));
                        } else {
                          _bookCubit.updateBook(
                              book: Book(
                                  id: _book.id,
                                  name: _nameControler.text,
                                  numberOfPages:
                                      int.parse(_numberPageControler.text),
                                  price: double.parse(_pricePageControler.text),
                                  publicationDate: DateFormat("yyyy-MM-dd")
                                      .format(_addDateTime),
                                  status: _stateSelected));
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
        isLoading: _isLoading,
      );
    });
  }
}
