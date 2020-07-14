import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:loader_search_bar/loader_search_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'globals.Dart' as globals;
import 'librerias/servicioEjecutar.dart';
import 'auxiliares.dart';
import 'actividades.dart';
import 'registros.dart';
import 'productos.dart';
import 'cuentas.dart';
import 'package:facilapp/pos/presentation/home/home_page.dart';

class MyTransaccion extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,                                             // Color de sombra
        primaryColor: Colors.teal,

        ),
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {

  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {

  static final String uploadEndPoint = 'https://ocobosoft.000webhostapp.com/uploadFile.php';
  String status = '';
  String base64Image;
  String errMessage = 'Error Uploading Image';
  File _imagen = null;

  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  bool _isWorking   = false;

  String _resultText  = '';                                                     // resultado de averiguar
  String _actividades = '';                                                     // json
  String _auxiliares  = '';                                                     // json
  String _cuentas     = '';                                                     // json

  var _texto       = TextEditingController();
  var _actividad   = TextEditingController();
  var _auxiliar    = TextEditingController();
  var _cuenta      = TextEditingController();
  var _observacion = TextEditingController();
  var _valor       = TextEditingController();

  final FocusNode _textoFocus = FocusNode();
  final FocusNode _observacionFocus = FocusNode();
  final FocusNode _valorFocus = FocusNode();

  final NumberFormat formato = new NumberFormat("#,##0", "es_US");

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
    _valor.addListener(_formatearValor);
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el widget se elimine del árbol de widgets
    // Esto también elimina el listener _printLatestValue
    _valor.dispose();
    super.dispose();
  }

  _formatearValor() {
    if ( _valor.text.length > 0 ) {
      String cadena = _valor.text;
      cadena =cadena.replaceAll( "," , "" );
      if ( formato.format(int.parse( cadena ) ) != _valor.text ) {
        _valor.text = formato.format(int.parse(cadena));
        _valor.selection = TextSelection.collapsed(offset: _valor.text.length);
      }
    }
  }

  void initSpeechRecognizer() {

    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler( (bool result) => setState(() => _isAvailable = result), );
    _speechRecognition.setRecognitionStartedHandler( () => setState(() => _isListening = true), );
    _speechRecognition.setRecognitionResultHandler( (String speech) => setState(() => _resultText = speech), );
    _speechRecognition.setRecognitionCompleteHandler( () => setState(() => _isListening = false), );
    _speechRecognition.activate().then( (result) => setState(() => _isAvailable = result), );
  }

  void _prender() {
    setState(() {
      _isWorking = true;
    });
  }

  void _apagar() {
    setState(() {
      _isWorking = false;
    });
  }

  void _limpiar() {
    setState(() {
      globals.actividadSaved = 0;
      globals.auxiliarSaved  = 0;
      globals.registroSaved  = 0;
      globals.cuentaSaved    = 0;

      globals.actividadNamed = '';
      globals.auxiliarNamed  = '';
      globals.cuentaNamed    = '';

      _texto.text       = '';
      _actividad.text   = '';
      _auxiliar.text    = '';
      _cuenta.text      = '';
      _valor.text       = '';
      _observacion.text = '';

      _imagen = null;
    });
  }

  void _refrescar() {
    setState(() {
      _actividad.text = globals.actividadNamed.toString();
      _auxiliar.text  = globals.auxiliarNamed.toString();
      _cuenta.text  = globals.cuentaNamed.toString();
    });
  }

  void _averiguar() async {

    String resultado;
    resultado = await Buscar.averiguar( _resultText );                          // <-- actividad, valor, nombre
    print('resultado: ${resultado}');

    List lista = resultado.split(",");
    _texto.text = resultado.replaceAll(",", " ");
    _valor.text = lista[1].toString();

    _actividades = await Buscar.averiguarActividades( resultado );              // Viene el json como un String
    print('actividadesMain: ${_actividades}');                                  // Cambio
//    actividades = Buscar.parseActividad( _actividades );                      // Pasarlo al objeto

    _auxiliares = await Buscar.averiguarAuxiliares( resultado, _actividades );  // Viene el json como un String
    print('auxiliarMain: ${_auxiliares}');
//    auxiliares = Buscar.parseAuxiliar( _auxiliares );                         // Pasarlo al objeto

    _cuentas = await Buscar.averiguarCuentas();                                 // Viene el json como un String
    print('cuentasMain: ${_cuentas}');

    _refrescar();
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == _imagen) {
      setStatus(errMessage);
      return;
    }
    String fileName = _imagen.path.split('/').last;
    upload( 'tmp/' + fileName );
  }

  upload(String fileName) {
    http.post(uploadEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
    }).catchError((error) {
      setStatus(error);
    });
  }


  @override
  Widget build(BuildContext context) {

    Widget oyendo = Container(

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 12.0,
      ),
      child: Text(
        _resultText,
        style: TextStyle(fontSize: 14.0, color: Colors.white,),
      ),
    );

    Widget widgetEsperar = Center(
        child: _isWorking == true ? new CircularProgressIndicator() : null
    );

    Widget widgetTexto = Container (

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,                                                    // grey.shade300
        borderRadius: BorderRadius.circular(6.0),
      ),
      padding: EdgeInsets.symmetric(
//        vertical: 6.0,
        horizontal: 6.0,
      ),

      child: TextFormField(
        controller: _texto,
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.data_usage),
          labelText: 'Transacción',
          hintText: 'Modifique el texto si es necesario',
        ),
        focusNode: _textoFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _textoFocus.unfocus();
          FocusScope.of(context).requestFocus(_valorFocus);
        },
      ),
    );

    Widget widgetValor = Container (

        width: MediaQuery.of(context).size.width * 0.93,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(
//          vertical: 6.0,
          horizontal: 6.0,
        ),

        child: TextFormField(
          controller: _valor,
          decoration: const InputDecoration(
            prefixIcon: const Icon(Icons.attach_money),
            labelText: 'Valor transacción',
            hintText: 'Digite el valor',
          ),
          focusNode: _valorFocus,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (term) {
            _valorFocus.unfocus();
            FocusScope.of(context).requestFocus(_observacionFocus);
          },
          keyboardType: TextInputType.phone,
        ),
    );

    Widget widgetActividad = Container (

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        ),
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
      ),

      child: TextFormField(
        controller: _actividad,
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.settings),
          labelText: 'Actividad',
          ),

        onTap: () async {
          if ( _actividades.length > 0 ) {
            print('llamar: ${_actividades}');
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyActividadPage(
                      value: _actividades), // llamar la forma de actividades
              );

            await Navigator.of(context).push(route);
            _refrescar();
          }
          else {
            Fluttertoast.showToast( msg: "Pantalla sin datos...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
            backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );
        }
        },
      ),

    );

    Widget widgetAuxiliar = Container (

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        ),
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
        ),

      child: TextFormField(
        controller: _auxiliar,
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.person),
          labelText: 'Auxiliar',
          ),

        onTap: () async {
          if ( _auxiliares.length > 0 ) {
            print('llamar: ${_auxiliares}');
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyAuxiliarPage(
                      value: _auxiliares),                                      // Llamar la forma de auxiliares
              );

            await Navigator.of(context).push(route);
            _refrescar();
          }
          else {
            Fluttertoast.showToast( msg: "Pantalla sin datos...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
            backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );
          }

        },
      ),
    );

    Widget widgetCuenta = Container (

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        ),
      padding: EdgeInsets.symmetric(
        horizontal: 6.0,
        ),

      child: TextFormField(
        controller: _cuenta,
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.account_balance),
          labelText: 'Cuenta',
          ),

        onTap: () async {
          if ( _cuentas.length > 0 ) {
            print('llamar: ${_cuentas}');
            var route = MaterialPageRoute(
              builder: (BuildContext context) =>
                  MyCuentaPage(
                      value: _cuentas),                                         // Llamar la forma de auxiliares
              );

            await Navigator.of(context).push(route);
            _refrescar();
          }
          else {
            Fluttertoast.showToast( msg: "Pantalla sin datos...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
                                        backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );
          }

        },
        ),
      );

    Widget widgetObservacion = Container (

      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
      ),
      padding: EdgeInsets.symmetric(
//        vertical: 0.0,
        horizontal: 6.0,
      ),

      child: TextFormField(
        maxLines: 2,
        controller: _observacion,
        decoration: const InputDecoration(
          prefixIcon: const Icon(Icons.note),
          labelText: 'Observación',
          hintText: 'Nota adicional',
        ),
        focusNode: _observacionFocus,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (term) {
          _observacionFocus.unfocus();
        },
      ),
    );

    Future getGaleria() async {
      var pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imagen = File(pickedFile.path);
        base64Image = base64Encode(_imagen.readAsBytesSync());
      });
    }

    Future getImagen() async {
      var pickedFile = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _imagen = File(pickedFile.path);
        base64Image = base64Encode(_imagen.readAsBytesSync());
      });
    }

    Future<void> _showDialog(BuildContext context) {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
                title: Text("Desde donde desea tomar la imagen?"),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: <Widget>[
                      GestureDetector(
                        child: Text("Cámara"),
                        onTap: () {
                          getImagen();
                        },
                      ),
                      Padding(padding: EdgeInsets.all(8.0)),
                      GestureDetector(
                        child: Text("Galería"),
                        onTap: () {
                          getGaleria();
                        },
                      ),
                    ],
                  ),
                )
            );
          }
        );
    }

    Widget widgetFotos = Container (
      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        ),

      child: RaisedButton(
        onPressed: ()  {
          _showDialog(context);
        },

        textColor: Colors.black,
        color: Colors.white,
        splashColor: Colors.black,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: _imagen == null
                ? Stack (
                  children: <Widget>[
                    Padding (
                      child: Image.asset("assets/camara.png"),
                        padding: EdgeInsets.all(2.0),
                    ),
                  ],
                )
//              : CircleAvatar(backgroundImage: FileImage(_image2), radius: 80.0,),  // FOTO: Presenta la documento
                : Stack (
                  children: <Widget>[
                    Padding (
                      child: Image.file(_imagen),
                        padding: EdgeInsets.symmetric(vertical: 6.0)
                      ),
                  ],
                )
            ),
          ],
        ),
      ),
    );

    Widget widgetGaleria = Container (
        width: MediaQuery.of(context).size.width * 0.93,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.0),
          ),
      padding: EdgeInsets.all(8.0),
      child: GridView.extent(
        maxCrossAxisExtent: 10,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        children: <Widget>[
          Image.network("https://placeimg.com/500/500/any"),
          Image.network("https://placeimg.com/500/500/any"),
          Image.network("https://placeimg.com/500/500/any"),
          Image.network("https://placeimg.com/500/500/any"),
        ],
      )
    );

    Widget widgetTarjeta = Card (
      child: Column(
        children: [

          oyendo,
//              Divider(color: Colors.white,),
          SizedBox(height: 6.0),

          widgetEsperar,
//              Divider(color: Colors.white,),

          widgetTexto,
          widgetActividad,
          widgetAuxiliar,
          widgetCuenta,
          widgetValor,
          widgetObservacion,

          SizedBox(height: 6.0),

          widgetFotos,

        ],
      ),
    );

    return new Scaffold(

        appBar: SearchBar(

          iconified: true,
          searchHint: 'Buscar transacciones...',
          defaultBar: AppBar(
//          leading: IconButton( icon: Icon(Icons.menu ),
//            onPressed: _openDrawer,
//          ),
            title: const Text('Registro de Transacciones',
              style: TextStyle(fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        drawer: MenuLateral(),

        body: Container(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2, ),
//              padding: const EdgeInsets.all( 10 ),
            children: <Widget>[
              widgetTarjeta,
            ],
            ),
          ),

        floatingActionButton:Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
/*
              FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.cancel,),
                backgroundColor: Colors.red,
                mini: true,
                onPressed: _limpiarText,
              ),
*/
              FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.mic,),
                backgroundColor: Colors.teal,
                onPressed: () {
                  if ( _isAvailable && !_isListening )   // en_US
                    _speechRecognition
                        .listen(locale: "en_ES")
                        .then((result) => print('$result'));
                },
              ),

              FloatingActionButton(
                  heroTag: null,
                  child: Icon(Icons.data_usage,),
                  backgroundColor: Colors.black38,
                  mini: true,
                  onPressed: () async {
                    _prender();
                    await _averiguar();
                    _apagar();
                  }
              ),

/*
              FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.stop,),
                backgroundColor: Colors.red,
                mini: true,
                onPressed: () {
                  if (_isListening)
                    _speechRecognition.stop().then(
                          (result) => setState(() => _isListening = result),
                          );
                },
                ),
*/
              FloatingActionButton(
                heroTag: null,
                child: Icon(Icons.add),
                backgroundColor: Colors.teal,
                mini: false,
                onPressed: () async {

                  if ( globals.actividadSaved !=  0 ) {

                    if ( globals.auxiliarNamed.length == 0 )
                      globals.auxiliarSaved = 0;

                    if ( globals.cuentaNamed.length == 0 )
                      globals.cuentaSaved = 0;

                    String sentencia;
                    if ( _imagen != null )
                         sentencia = "'" + _imagen.path.split('/').last + "', '', '', ''" ;
                    else sentencia = "'', '', '', ''" ;

                    sentencia =
                        "insert into g_ejecutar ( ejecutar, fecha, usuario, seguimiento, agenda, documento, cuenta, valor, observacion, registro, mascara, archivo0, archivo1, archivo2, archivo3 ) "+
                        "values ( 0, now(), 'Ocobo', 12602, " + globals.actividadSaved.toString() + ', ' +
                        globals.auxiliarSaved.toString() + ", " + globals.cuentaSaved.toString() +", " + _valor.text.replaceAll( "," , "" ) +
                        ", '" + _observacion.text + "', 0, 0, " + sentencia + ")" ;

                    print('eecutar(->): ${sentencia}');
                    sentencia = await Buscar.ejecutar( sentencia );             // Ingresar a g_ejecutar
                    print('ejecutar(<-): ${sentencia}');

                    if ( sentencia == 'Error' ) {
                      Fluttertoast.showToast( msg: "Error intente nuevamente...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
                                                  backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );
                    }
                    else {
                      Fluttertoast.showToast( msg: "Datos grabados...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
                                                  backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );
                      startUpload();
                      _limpiar();
                    }
                  }
                  else
                    Fluttertoast.showToast( msg: "Error datos incompeltos, intente nuevamente...", toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIos: 2,
                    backgroundColor: Colors.grey.shade900.withOpacity(0.6), textColor: Colors.white, fontSize: 16.0 );

                }
              ),
            ]
        )

    );

  }

}

class MenuLateral extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children: <Widget>[
          Padding(
              child: Image.asset( "assets/ocoboSoftph.png" ),
              padding: EdgeInsets.only(bottom: 6.0),
          ),

          new ListTile(
            title: Text("Comunicaciones",),
            leading: Icon(Icons.book,),
            onTap: () async {
            },
          ),

          new ListTile(
            title: Text("Inquietudes",),
            leading: Icon(Icons.create,),
            onTap: () async {
            },
          ),

          new ListTile(
            title: Text("Transacciones"),
            leading: Icon(Icons.format_list_numbered,),
            onTap: () async {

              String _registros = await Buscar.averiguarRegistros();            // Viene el json como un String
              print('llamar: ${_registros}');
              var route = MaterialPageRoute(
                builder: (BuildContext context) =>
                    MyRegistroPage(value: _registros ),                         // Cambio
              );
              Navigator.of(context).push(route);

            },
          ),

          new ListTile(
            title: Text("Configuración",),
            leading: Icon(Icons.build,),
            onTap: () async {
            },
          ),

          new ListTile(
            leading: Icon(Icons.local_grocery_store),
            title: Text("Compras"),
            onTap: () async {

              String _items = await Buscar.averiguarProductos();                // Viene el json como un String
              print('llamar: ${_items}');
              var route = MaterialPageRoute(
                builder: (BuildContext context) =>
//                    MyProductoPage( value: _items ),                            // Cambio
                  HomePage(),
                );
              Navigator.of(context).push(route);

            },
            ),

        ],
      ) ,

    );
  }

}
