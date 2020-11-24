import 'package:flutter/material.dart';
import 'package:facilapp/src/config/globals.dart' as globals;

class OptionFilter extends StatefulWidget {
  String option;
  String icon;
  int status;
  OptionFilter(
      {@required this.option, @required this.icon, @required this.status});
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
    if (widget.status == globals.selected) {
      seletedButton();
    }
    // if (widget.status != globals.selected) {
    //   seletedButton();
    // }
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
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ColorFiltered(
                  child: Container(
                      margin: EdgeInsets.only(right: 12),
                      width: 20,
                      height: 20,
                      child: widget.icon != null
                          ? Image.asset('assets/icons/${widget.icon}')
                          : null),
                  colorFilter: ColorFilter.mode(colorText, BlendMode.srcIn),
                ),
                // Container(margin: EdgeInsets.only(right: 12), width: 20, child: Image.asset('assets/loading.png')),
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
    globals.selected = widget.status;
    setState(() {});
  }
}
