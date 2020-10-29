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
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: AssetImage('assets/icons/${transaccion.imagen}'),
                      // image: NetworkImage(transaccion.imagen),
                      fit: BoxFit.contain),
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
                      // Icon(icon),
                      Text(
                        transaccion.fecha,
                        style: TextStyle(color: Color(0xff9F9F9F)),
                      )
                    ],
                  ),
                  Text('${transaccion.auxiliar} (\$${transaccion.precio})')
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
