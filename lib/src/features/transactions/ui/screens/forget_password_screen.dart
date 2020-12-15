import 'package:facilapp/src/features/transactions/ui/widgets/appbar_ocobo_widget.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class ForgetPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, routes.LoginPageRoute);
      },
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppbarOcobo(
            navigator: () {
              Navigator.pushNamed(context, routes.LoginPageRoute);
            },
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recuperar Contraseña',
                  style: TextStyle(fontFamily: "Poppins", fontSize: 40),
                ),
                SizedBox(
                  height: 60,
                ),
                Theme(
                  data: new ThemeData(
                    primaryColor: Color(0xff6A9426),
                    hintColor: Colors.black,
                  ),
                  child: TextFormField(
                    cursorColor: Color(0xff6A9426),
                    decoration: InputDecoration(
                        hintText: 'Correo eléctronico',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: "Poppinslight",
                        )),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Container(
                    height: 40,
                    width: 100,
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                        side: BorderSide(width: 3, color: Color(0xff6A9426)),
                      ),
                      textColor: Color(0xff6A9426),
                      color: Color(0xffFFFFFF),
                      child: Text(
                        'Enviar',
                        style: TextStyle(fontSize: 20, fontFamily: "Poppins"),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
