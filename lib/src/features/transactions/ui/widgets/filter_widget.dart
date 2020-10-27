import 'package:facilapp/src/features/transactions/ui/widgets/option_filter_widget.dart';
import 'package:flutter/material.dart';

class Filtro extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text('Filtrar por estados',style:TextStyle(fontSize: 12, fontFamily: "Poppins")),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionFilter(option: 'Todos', icon: null),
            OptionFilter(option: 'Preparación', icon: Icons.pan_tool),
            OptionFilter(option: 'Aprobada', icon: Icons.check),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OptionFilter(option: 'Proceso', icon: Icons.cached),
            OptionFilter(option: 'Ejecutada', icon: Icons.verified),
            OptionFilter(option: 'Cancelada', icon: Icons.highlight_off),
          ],
        ),

      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0);
}