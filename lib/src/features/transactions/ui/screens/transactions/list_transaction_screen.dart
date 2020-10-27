import 'package:facilapp/src/features/transactions/models/transaccion.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/transaccion_widget.dart';
import 'package:flutter/material.dart';

class ListTransaccion extends StatefulWidget {
  @override
  _ListTransaccionState createState() => _ListTransaccionState();
}

class _ListTransaccionState extends State<ListTransaccion> {
  var transaccion1 = Transaccion(
      imagen:
          'https://us.123rf.com/450wm/iconicbestiary/iconicbestiary1612/iconicbestiary161200811/67658259-libro-o-libro-mayor-de-contabilidad-mesas-abiertas-con-calculadora-y-l%C3%A1piz-ilustraci%C3%B3n-vectorial-de-estil.jpg?ver=6',
      actividad: 'Tipo de Actividad',
      fecha: 'Fecha');
  var transaccion2 = Transaccion(
      imagen:
          'https://thumbs.dreamstime.com/b/iconos-planos-que-consideran-calculadora-con-el-cuaderno-y-l%C3%A1piz-aislados-en-fondo-blanco-ilustraci%C3%B3n-del-vector-140144314.jpg',
      actividad: 'Tipo de Actividad',
      fecha: 'Fecha');
  var transaccion3 = Transaccion(
      imagen:
          'https://media.istockphoto.com/vectors/paper-notebook-with-pencil-and-calculator-tools-vector-id670262900',
      actividad: 'Tipo de Actividad',
      fecha: '01/10/2020');

  @override
  Widget build(BuildContext context) {
    return ListView(
      
      children: [
        TransaccionWidget(transaccion: transaccion1,icon: Icons.pan_tool,),
        TransaccionWidget(transaccion: transaccion2,icon:Icons.check),
        TransaccionWidget(transaccion: transaccion3,icon:Icons.verified)
      ],
    );
  }
}
