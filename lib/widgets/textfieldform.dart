import 'package:facilapp/app/themes/themes.dart';
import 'package:flutter/material.dart';

class TextFieldForm extends StatelessWidget {
  const TextFieldForm(
      {@required this.labelText, this.hintText = '', this.onTap});
  final String labelText;
  final String hintText;
  final Function onTap;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Theme(
        data: AppTheme.profileCard(),
        child: InkWell(
          onTap: onTap,
          child: TextField(
            onTap: onTap,
            decoration:
                InputDecoration(labelText: labelText, hintText: hintText),
          ),
        ),
      ),
    );
  }
}
