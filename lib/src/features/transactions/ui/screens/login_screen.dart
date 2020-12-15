import 'package:facilapp/pos/presentation/book/pages/list_books.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/button_navigation.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:facilapp/src/styles/theme.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Icon _iconEmail;
  bool _iconPassword;
  bool _colorPassword;
  bool _logueado = false;
  String _company;
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _colorPassword = false;
    _iconPassword = true;
  }

  //Lista para el select de empresa
  List<DropdownMenuItem<String>> listCompany = [
    DropdownMenuItem(
        child: Text(
          "OcoboSoft",
        ),
        value: "OcoboSoft"),
    DropdownMenuItem(
        child: Text(
          'Ibacrea SAS',
        ),
        value: 'Ibacrea SAS'),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, routes.HomePageRoute);
      },
      child: Scaffold(
          appBar: AppbarOcobo(
            navigator: () {
              Navigator.pop(context);
            },
            // textAction: 'Registrarse',
            // navigator: () {
            //   Navigator.pushNamed(context, routes.RegisterUserPageRoute);
            // },
          ),
          body: _logueado
              ? ListBookScreen()
              : Form(
                  key: _formKeyLogin,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Iniciar sesión',
                            style: myTheme.textTheme.button,
                          ),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              labelText: 'Empresa',
                            ),
                            items: listCompany,
                            value: _company,
                            onChanged: (value) {
                              setState(() {
                                _company = value;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Seleccione una opción';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _email,
                            decoration: InputDecoration(
                              suffixIcon: _iconEmail,
                              labelText: 'Usuario',
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                _iconEmail = Icon(
                                  Icons.warning,
                                  color: Colors.red,
                                );
                                setState(() {});
                                return 'Ingrese el Usuario';
                              }
                              _iconEmail = null;
                              setState(() {});
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
                                color:
                                    _colorPassword ? Colors.red : Colors.black,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                child: Text(
                                  'Olvidó su contraseña',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xff6A9426),
                                      fontFamily: "Poppins"),
                                ),
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, routes.ForgetPasswordPageRoute);
                                },
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          ButtonNavigation(
                            text: "Iniciar sesión",
                            navigator: () async {
                              if (!_formKeyLogin.currentState.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Text(
                                      'Debe completar todos los campos',
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
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  routes.HomeTransactionsPageRoute,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )),
    );
  }
}
