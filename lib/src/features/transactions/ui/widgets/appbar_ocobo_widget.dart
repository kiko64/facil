import 'package:flutter/material.dart';

class AppbarOcobo extends StatelessWidget implements PreferredSizeWidget {
  final String textAction;
  final VoidCallback navigator;
  AppbarOcobo({this.textAction,this.navigator});
  @override
  Widget build(BuildContext context) {
    // var screenSize = MediaQuery.of(context).size;
    // var screenHeight = screenSize.height;
    // var screenwidth = screenSize.width;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
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
                  // style: TextStyle(fontFamily: "Poppinslight", fontSize: 12),
                ),
              ],
            ),
            onTap: navigator,
            // onTap: () {
            //   Navigator.pop(context);
            // },
          ),
          textAction != null ? GestureDetector(
            child: Text(textAction,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 12,
                  color: Color(0xff9F9F9F),
                )),
            onTap: navigator
          )
        : Text('')],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60);
}
