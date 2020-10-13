import 'package:facilapp/pos/presentation/book/pages/list_books.dart';
import 'package:facilapp/screens/forgetpassword.dart';
import 'package:facilapp/widgets/appbar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String correo;
  String contrasena;
  bool _logueado = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _logueado ? ListBookScreen() : LoginOcobo());
  }
}

class LoginOcobo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppbarOcobo(),
          Container(
            padding: EdgeInsets.only(
              left: 45,
              right: 45,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Iniciar sesión',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 20),
                ),
                Theme(
                  data: new ThemeData(
                    primaryColor: Color(0xff6A9426),
                    hintColor: Colors.black,
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xff6A9426),
                    decoration: InputDecoration(
                        labelText: 'Correo',
                        labelStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppinslight",
                        )),
                  ),
                ),
                Theme(
                  data: new ThemeData(
                    primaryColor: Color(0xff6A9426),
                    hintColor: Colors.black,
                  ),
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.visibility_off,
                        color: Colors.black,
                      ),
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "Poppinslight",
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: GestureDetector(
                        child: Text(
                          'Olvidó su contraseña',
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins",
                              color: Color(0xff6A9426)),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen()));
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: 40,
                  width: 300,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    textColor: Colors.white,
                    color: Color(0xff6A9426),
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
