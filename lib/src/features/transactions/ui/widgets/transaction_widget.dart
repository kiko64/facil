import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionWidgetScreen extends StatelessWidget {
  final Transaction transaction;
  final Function(Transaction) onTap;

  const TransactionWidgetScreen({Key key, this.transaction, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    var status = transaction.status;
    var icon;
    switch (status) {
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

    _cancelTransaction(transaction, _cubit) {
      Future.delayed(Duration.zero, () {
        showDialog(
          context: context,
          builder: (ncontext) => AlertDialog(
            content: Text('¿Esta seguro de cancelar esta Transacción?'),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.highlight_off,
                  color: Colors.red,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: OcoboColors.primaryColor,
                ),
                onPressed: () {
                  _cubit.cancelTransaction(id: transaction.id, status: 12605);
                },
              ),
            ],
          ),
        );
      });
    }

    return BlocProvider(
      create: (context) => TransactionCubit(),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          var _cubit = BlocProvider.of<TransactionCubit>(context);
          bool cancelar = false;
          if (state is CancelTransaction) {
            if (state.success) {
              Future.delayed(Duration.zero, () {
                Navigator.pushNamed(context, routes.HomeTransactionsPageRoute);
              });
            } else {
              print(state.error);
            }
          }
          if (state is ChangedCancelState) {
            cancelar = state.cancel;
            // if (cancelar) {
            //   _cancelTransaction(transaction, _cubit);
            // }
          }
          return GestureDetector(
            onHorizontalDragEnd: (details) {
              if (status == 12601 && details.primaryVelocity > 0) {
                _cubit.changeCancel(!cancelar);
              }
            },
            child: Container(
              margin: EdgeInsets.only(left: 15, right: 5, top: 20),
              // color: Colors.blue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                              image: AssetImage('assets/icons/$icon'),
                              fit: BoxFit.contain),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.activity,
                            style:
                                TextStyle(fontSize: 12, fontFamily: "Poppins"),
                          ),
                          Row(
                            children: [
                              Text(
                                transaction.date,
                                style: TextStyle(color: Color(0xff9F9F9F)),
                              )
                            ],
                          ),
                          Text(
                            '${transaction.auxiliary} (${NumberFormat.simpleCurrency().format(double.parse(transaction.value.toString()))})',
                            style: TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                  IconButton(
                    icon: cancelar
                        ? Icon(Icons.highlight_off, color: Colors.red)
                        : Icon(Icons.arrow_forward_ios),
                    onPressed: cancelar
                        ? () => _cancelTransaction(transaction, _cubit)
                        : () => onTap(transaction),
                    // :() =>Navigator.pushNamed(
                    //         context, routes.RegisterTransactionPageRoute,
                    //         arguments: transaction)
                  )
                ],
              ),
            ),
            onTap: status == 12604
                ? () {
                    Navigator.pushNamed(context, routes.HomeVochersPageRoute,
                        arguments: {'vouchers': transaction.vouchers});
                  }
                : null,
          );
        },
      ),
    );
  }
}
