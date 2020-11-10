import 'package:facilapp/src/features/transactions/models/movement.dart';
import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/movement_widget.dart';
import 'package:flutter/material.dart';

class MovementScreen extends StatelessWidget {
  Voucher voucher;
  final movements = [
    Movement(
        account: '415530',
        description: 'Consultoria en equipo',
        name: 'Auxiliar general',
        debit: 0,
        credit: 12941),
    Movement(
        account: '415530',
        description: 'Consultoria en equipo',
        name: 'Auxiliar general',
        debit: 12941,
        credit: 0),
  ];
  MovementScreen({this.voucher});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Comprobante Contable ${voucher.number}'),
          actions: [
            Icon(Icons.search),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/icons/Grupo 16212.png',
                width: 20,
                height: 20,
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: movements.length,
          itemBuilder: (context, index) {
            return MovementWidget(movement: movements[index],);
          },
        )
        );
  }
}
