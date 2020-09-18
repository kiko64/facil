library dropdown_formfield;

import 'package:flutter/material.dart';

class DropDownFormField extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
  final bool filled;
  final String iconField;
  final String imageField;
  final double rowHeight;
  final double iconHeightRatio;
  final String trackingCommitLvlApiMsgField;

  DropDownFormField(
      {FormFieldSetter<dynamic> onSaved,
      FormFieldValidator<dynamic> validator,
      bool autovalidate = false,
      this.titleText = 'Title',
      this.hintText = 'Seleccione una opcion',
      this.required = false,
      this.errorText = 'Por favor seleccione una opcion',
      this.value,
      this.dataSource,
      this.textField,
      this.valueField,
      this.onChanged,
      this.iconField,
      this.imageField,
      this.rowHeight = 100,
      this.iconHeightRatio = 0.45,
      this.trackingCommitLvlApiMsgField,
      this.filled = true})
      : super(
          onSaved: onSaved,
          validator: validator,
          autovalidate: autovalidate,
          initialValue: value == '' ? null : value,
          builder: (FormFieldState<dynamic> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.only(
                          left: 10,
                          right: 0,
                          top: 0,
                          bottom: 0,
                        ),
                        filled: filled),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<dynamic>(
                        dropdownColor: Colors.white,
                        iconEnabledColor: Colors.grey,
                        hint: Text(
                          hintText,
                        ),
                        value: value == '' ? null : value,
                        onChanged: (dynamic newValue) {
                          state.didChange(newValue);
                          onChanged(newValue);
                        },
                        items: dataSource.map((item) {
                          return DropdownMenuItem<dynamic>(
                            value: item[valueField],
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: item[iconField] == null
                                  ? <Widget>[
                                      Text(item[textField]),
                                    ]
                                  : <Widget>[
                                      Icon(item[iconField]),
                                      SizedBox(width: 10),
                                      Text(item[textField]),
                                    ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: state.hasError ? 5.0 : 0.0),
                Text(
                  state.hasError ? state.errorText : '',
                  style: TextStyle(
                      color: Colors.redAccent.shade700,
                      fontSize: state.hasError ? 12.0 : 0.0),
                ),
              ],
            );
          },
        );
}
