import 'package:facilapp/pos/presentation/book/pages/list_books.dart';
import 'package:facilapp/src/features/transactions/ui/screens/forget_password_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/register_screen.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/home_transactions_screen.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/button_navigation.dart';
import 'package:facilapp/src/styles/theme.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  Icon _iconEmail;
  bool _colorPasword;
  bool _logueado = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _colorPasword = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppbarOcobo(
          textAction: 'Registrarse',
          navigator: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegisterScreen()));
          },
        ),
        body: _logueado
            ? ListBookScreen()
            : Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SingleChildScrollView(
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
                          obscureText: true,
                          decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.visibility_off,
                              color: _colorPasword ? Colors.red : Colors.black,
                            ),
                            labelText: 'Contraseña',
                            
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              _colorPasword = true;
                              setState(() {});
                              return 'Ingrese la contraseña';
                            }
                            _colorPasword = false;
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
                                    fontSize: 12, color: Color(0xff6A9426)),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ForgetPasswordScreen()));
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ButtonNavigation(
                              text: "Iniciar sesión",
                              navigator: () async {
                                if (!_formKey.currentState.validate()) {
                                  return;
                                }
                                // Aquí el formulario ya está validado. Haz lo que tengas que hacer (;
                                Navigator.of(context).pushNamedAndRemoveUntil('/homeTransactions', (Route<dynamic> route) => false);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
  }
}
