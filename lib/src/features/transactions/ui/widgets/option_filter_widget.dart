import 'package:flutter/material.dart';

class OptionFilter extends StatefulWidget {
  String option;
  IconData icon;
  OptionFilter({@required this.option, @required this.icon});
  @override
  _OptionFilterState createState() => _OptionFilterState();
}

class _OptionFilterState extends State<OptionFilter> {
  
  Color color;
  bool selected;
  Color colorText;

  @override
  void initState() {
    super.initState();
    color = null;
    colorText = Colors.black;
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
        child: Material(
          elevation: 10,
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.all(5),
            width: 110,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.icon,
                  // size: 10,
                  color: colorText,
                ),
                SizedBox(
                  width: 1,
                ),
                Text(widget.option,
                    style: TextStyle(
                        fontSize: 10, color: colorText, fontFamily: "Poppins")),
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        seletedButton();
      },
    );
  }

  seletedButton() {
    if (color == null) {
      color = Color(0xff6A9426);
      colorText = Colors.white;
    } else {
      color = null;
      colorText = Colors.black;
    }
    setState(() {});
  }
}
