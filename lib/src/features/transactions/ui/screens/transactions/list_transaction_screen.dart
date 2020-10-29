import 'package:facilapp/src/features/transactions/models/transaccion.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/transaccion_widget.dart';
import 'package:flutter/material.dart';

class ListTransaccion extends StatefulWidget {
  @override
  _ListTransaccionState createState() => _ListTransaccionState();
}

class _ListTransaccionState extends State<ListTransaccion> {
  var transaccion1 = Transaccion(
      imagen: 'open-hands.png',
      actividad: 'Servicio público',
      fecha: '21-OCT-2020 5:30 P.M',
      auxiliar: 'Alcanos',
      precio: '12860');
  var transaccion2 = Transaccion(
      imagen: 'aprobado.png',
      actividad: 'Servicio público',
      fecha: '30-SEP-2020 2:00 P.M',
      auxiliar: 'Celsia',
      precio: '42860');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Filtro(),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              TransaccionWidget(
                transaccion: transaccion1,
                icon: Icons.pan_tool,
              ),
              TransaccionWidget(transaccion: transaccion2, icon: Icons.check),
            ],
          ),
        )
      ],
    );
  }
}
