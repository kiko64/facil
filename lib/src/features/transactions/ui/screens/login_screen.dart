import 'package:facilapp/pos/presentation/book/pages/list_books.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/button_navigation.dart';
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
  final _formKeyLogin = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _colorPassword = false;
    _iconPassword = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarOcobo(
          textAction: 'Registrarse',
          navigator: () {
            Navigator.pushNamed(context, routes.RegisterUserPageRoute);
            // Navigator.of(context).pushNamed('/registerUser');
          },
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
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                            suffixIcon: _iconEmail,
                            labelText: 'Correo',
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              _iconEmail = Icon(
                                Icons.warning,
                                color: Colors.red,
                              );
                              setState(() {});
                              return 'Ingrese el correo';
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
                                Navigator.of(context)
                                    .pushNamed('/forgetPassword');
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
                              return;
                            }
                            // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
                            Navigator.pushNamed(context, routes.LoginPageRoute);
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                routes.HomeTransactionsPageRoute,
                                (Route<dynamic> route) => false);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
