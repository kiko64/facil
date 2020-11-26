import 'package:facilapp/src/features/transactions/ui/widgets/option_filter_widget.dart';
import 'package:flutter/material.dart';

class Filtro extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Wrap(
        children: [
          OptionFilter(option: 'Todos', icon: null, status: 12600,),
          OptionFilter(option: 'Preparación', icon: 'preparacion.png', status: 12601,),
          OptionFilter(option: 'Aprobada', icon: 'aprobado.png', status: 12602,),
          OptionFilter(option: 'Proceso', icon: 'proceso.png', status: 12603,),
          OptionFilter(option: 'Ejecutada', icon: 'ejecutada.png', status: 12604,),
          OptionFilter(option: 'Cancelada', icon: 'cancelada.png', status: 12605,),

        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(120.0);
}