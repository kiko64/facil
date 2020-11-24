import 'package:facilapp/src/features/transactions/models/movement.dart';
import 'package:flutter/material.dart';

class MovementWidget extends StatelessWidget {
  Movement movement;
  MovementWidget({this.movement});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: ListTile(
        title: Text('Cuenta:${movement.account}', style: TextStyle(fontFamily: "Poppins", fontSize: 12),),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${movement.description}', style: TextStyle(fontSize: 12)),
            Text('Nombre: ${movement.auxiliary}', style: TextStyle(fontSize: 12)),
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Debito: ${movement.debit}', style: TextStyle(fontSize: 12)),
                // SizedBox(
                //   width: screenwidth,
                // ),
                Text('Credito: ${movement.credit}', style: TextStyle(fontSize: 12)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
