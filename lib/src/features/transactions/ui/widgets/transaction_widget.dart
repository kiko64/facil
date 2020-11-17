import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  final Transaction transaction;
  String icon;

  TransactionWidget({this.transaction});
  @override
  Widget build(BuildContext context) {
    switch (transaction.status) {
      case 12601:
        icon = "preparacion.png";
        break;
      case 12602:
        icon = "aprobado.png";
        break;
      case 12603:
        icon = "proceso.png";
        break;
      case 12604:
        icon = "ejecutada.png";
        break;
      case 12605:
        icon = "cancelada.png";
        break;
      default:
    }
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 30, left: 10),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: AssetImage('assets/icons/$icon'),
                      // image: NetworkImage(transaction.imagen),
                      fit: BoxFit.contain),
                ),
                // child: Image.network(transaction.imagen),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.activity,
                    style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                  ),
                  Row(
                    children: [
                      // Icon(icon),
                      Text(
                        transaction.date,
                        style: TextStyle(color: Color(0xff9F9F9F)),
                      )
                    ],
                  ),
                  Text('${transaction.auxiliary} (\$${transaction.value})')
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }
}
