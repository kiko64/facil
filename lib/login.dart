// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _username = TextEditingController();
  final _password = TextEditingController();

  final FocusNode _usernameFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

//    final bloc = AuxiliarBloc();  //new separate

    var loginBtn = Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RaisedButton(

              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              color: Colors.teal,
              child: Text("INGRESAR"),
              onPressed: () {
                Navigator.pop(context);
              }
            ),
          ),
        ]
    );

    var ResetBtn = Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: RaisedButton(

              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(10.0),
              ),
              elevation: 4.0,
              color: Colors.grey.shade200.withOpacity(0.5),
              child: Text("REESTABLECER CONTRASEÑA"),
              onPressed: () {

                CircularProgressIndicator();

              },

            ),
          ),
        ]
    );

    var loginForm = new Column(

      children: <Widget>[

        SizedBox(height: 16.0),

        new Text(
          "Identificación",
          textScaleFactor: 2.0,
        ),

        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[

              TextFormField(
                controller: _username,
                decoration: InputDecoration(
                  labelText: '  Correo',
                ),

                focusNode: _usernameFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (term) {
                  _usernameFocus.unfocus();
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                keyboardType: TextInputType.emailAddress,
              ),

              TextFormField(
                controller: _password,
                decoration: InputDecoration(
                  labelText: '  Contraseña',
                ),

                focusNode: _passwordFocus,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                obscureText: true,

              ),


            ],
          ),
        ),

        SizedBox(height: 12.0),

        loginBtn,

        ResetBtn,

      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );


    return new Scaffold(

      appBar: null,

      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/fondo.png"),
            fit: BoxFit.cover),
        ),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 310.0,
                width:  320.0,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(16.0),
                  color: Colors.grey.shade600.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
    );

  }

}
