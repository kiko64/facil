import 'package:facilapp/src/features/transactions/ui/widgets/option_filter_widget.dart';
import 'package:flutter/material.dart';

class Filtro extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Wrap(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(9.0),
          //   child: Text('Filtrar por estados',style:TextStyle(fontSize: 12, fontFamily: "Poppins")),
          // ),
          OptionFilter(option: 'Todos', icon: null),
          OptionFilter(option: 'Preparación', icon: 'open-hands.png'),
          OptionFilter(option: 'Aprobada', icon: 'aprobado.png'),
          OptionFilter(option: 'Proceso', icon: 'loading.png'),
          OptionFilter(option: 'Ejecutada', icon: 'engranaje.png'),
          OptionFilter(option: 'Cancelada', icon: 'cancelar.png'),

        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0);
}