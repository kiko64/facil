import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/button_navigation.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _correo = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final _formKeyRegisterUser = GlobalKey<FormState>();
  String _company;
  String _role;
  bool _iconPassword;
  bool _colorPassword;

  @override
  void initState() {
    super.initState();
    _colorPassword = false;
    _iconPassword = true;
    _company = '';
    _role = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarOcobo(
          textAction: 'Iniciar Sesión',
          navigator: () {
            Navigator.of(context).pushNamed('/login');
          },
        ),
        body: Form(
          key: _formKeyRegisterUser,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Registro',
                    style: TextStyle(fontFamily: "Poppins", fontSize: 20),
                  ),
                  TextFormField(
                    controller: _name,
                    cursorColor: Color(0xff6A9426),
                    decoration: InputDecoration(
                      labelText: 'Nombre Completo',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese el nombre';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _correo,
                    cursorColor: Color(0xff6A9426),
                    decoration: InputDecoration(
                      labelText: 'Correo',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Ingrese el correo';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _password,
                    obscureText: _iconPassword,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: _iconPassword
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: _colorPassword ? Colors.red : Colors.black,
                        onPressed: () {
                          if (_iconPassword) {
                            _iconPassword = false;
                          } else {
                            _iconPassword = true;
                          }
                          setState(() {});
                        },
                      ),
                      labelText: 'Contraseña',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        _colorPassword = true;
                        setState(() {});
                        return 'Ingrese la contraseña';
                      }
                      _colorPassword = false;
                      setState(() {});
                      return null;
                    },
                  ),
                  DropDownFormField(
                    filled: false,
                    titleText: 'Empresa',
                    hintText: '',
                    value: _company,
                    onSaved: (value) {
                      setState(() {
                        _company = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _company = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "OcoboSoft",
                        "value": "OcoboSoft",
                      },
                      {
                        "display": "Ibacrea SAS",
                        "value": "Ibacrea SAS",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Seleccione una opción';
                      }
                      return null;
                    },
                  ),
                  DropDownFormField(
                    filled: false,
                    titleText: 'Rol',
                    hintText: '',
                    value: _role,
                    onSaved: (value) {
                      setState(() {
                        _role = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _role = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Contador",
                        "value": "Contador",
                      },
                      {
                        "display": "Cliente",
                        "value": "Cliente",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Seleccione una opción';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 120,
                  ),
                  ButtonNavigation(
                    text: 'Registrarse',
                    navigator: () async {
                      if (!_formKeyRegisterUser.currentState.validate()) {
                        return;
                      }
                      // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/homeTransactions', (Route<dynamic> route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
