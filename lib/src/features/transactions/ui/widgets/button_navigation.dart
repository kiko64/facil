import 'package:facilapp/src/styles/colors.dart';
import 'package:facilapp/src/styles/theme.dart';
import 'package:flutter/material.dart';

class ButtonNavigation extends StatelessWidget {
  String text;
  VoidCallback navigator;
  ButtonNavigation({
    this.text,
    this.navigator,
  });
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        textColor: OcoboColors.white,
        child: Text(
          text,
          style: myTheme.primaryTextTheme.button,
        ),
        onPressed: navigator);
  }
}
