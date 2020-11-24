import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:flutter/material.dart';

class VoucherWidget extends StatelessWidget {
  Voucher voucher;
  VoucherWidget({this.voucher});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only( top: 10.0),
      child: ListTile(
        title: Text('Comprobante contable ${voucher.id}',
            style: TextStyle(fontSize: 12, fontFamily: "Poppins")),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(voucher.date, style: TextStyle(fontSize: 12)),
            Text('${voucher.auxiliary}(${voucher.value})', style: TextStyle(fontSize: 12)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/icons/Grupo 16212.png',
                  width: 35,
                  height: 35,
                ),
                Text('Comprobante', style: TextStyle(fontSize: 10))
              ],
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              children: [
                Image.asset(
                  'assets/icons/Grupo 16213.png',
                  width: 35,
                  height: 35,
                ),
                Text(
                  'Documento',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, routes.MovementsPageRoute, arguments: voucher);
          // Navigator.of(context).pushNamed('/movements', arguments: voucher);
        },
      ),
    );
  }
}
