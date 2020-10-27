import 'package:facilapp/src/features/transactions/models/transaccion.dart';
import 'package:flutter/material.dart';

class TransaccionWidget extends StatelessWidget {
  final Transaccion transaccion;
  IconData icon;

  TransaccionWidget({this.transaccion, this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 20),
                width: 80,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                      image: NetworkImage(transaccion.imagen),
                      fit: BoxFit.cover),
                ),
                // child: Image.network(transaccion.imagen),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaccion.actividad,
                    style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                  ),
                  Row(
                    children: [
                      Icon(icon),
                      Text(
                        transaccion.fecha,
                        style:
                            TextStyle(fontSize: 12, fontFamily: "PoppinsLight"),
                      )
                    ],
                  ),
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
