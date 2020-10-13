import 'package:facilapp/screens/register.dart';
import 'package:flutter/material.dart';
import '../globals.dart' as globals;

class AppbarOcobo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: globals.screenHeight,
      padding: EdgeInsets.all(10),
      child: Row(
        //   mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios),
                Text(
                  'Regresar',
                  style: TextStyle(fontFamily: "Poppinslight", fontSize: 12),
                ),
              ],
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          GestureDetector(
            child: Text('Registrarse',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Color(0xff9F9F9F),
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()));
            },
          )
        ],
      ),
    );
  }
}
