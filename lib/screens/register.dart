import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:facilapp/widgets/appbar.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            Column(
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
                        'Registro',
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
                              labelText: 'Nombre Completo',
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
                      Theme(
                        data: ThemeData(
                          fontFamily: 'Poppinslight',
                          hintColor: Colors.black,
                          hoverColor: Colors.black,
                        ),
                        child: DropDownFormField(
                          filled: false,
                          titleText: 'Empresa',
                          hintText: '',
                          // value: 'OcoboSoft',
                          onChanged: () {},
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
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                          fontFamily: 'Poppinslight',
                          hintColor: Colors.black,
                          hoverColor: Colors.black,
                        ),
                        child: DropDownFormField(
                          filled: false,
                          titleText: 'Rol',
                          hintText: '',
                          // value: 'OcoboSoft',
                          onChanged: () {},
                          dataSource: [
                            {
                              "display": "Contador",
                              "value": "Contador",
                            },
                            {
                              "display": "Cliente",
                              "value": "Contador",
                            },
                          ],
                          textField: 'display',
                          valueField: 'value',
                        ),
                      ),
                      SizedBox(
                        height: 120,
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
                            'Registrarse',
                            style:
                                TextStyle(fontSize: 20, fontFamily: "Poppins"),
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
            )
          ],
        ));
  }
}
