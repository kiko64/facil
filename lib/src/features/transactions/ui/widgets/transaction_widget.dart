import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionWidgetScreen extends StatelessWidget {
  final Transaction transaction;

  const TransactionWidgetScreen({Key key, this.transaction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TransactionCubit(),
        child: TransactionWidget(
          transaction: transaction,
        ));
  }
}

class TransactionWidget extends StatefulWidget {
  final Transaction transaction;

  const TransactionWidget({Key key, this.transaction}) : super(key: key);
  @override
  _TransactionWidgetState createState() => _TransactionWidgetState();
}

class _TransactionWidgetState extends State<TransactionWidget> {
  String icon;
  var cancelar = false;
  var _transactionCubit;

  void initState() {
    super.initState();
    _transactionCubit = BlocProvider.of<TransactionCubit>(context);
  }

  cancelTransaction() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              _transactionCubit.cancelTransaction(
                  id: widget.transaction.id, status: 12605);
            },
          ),
        ],
      ),
    );
  }

  showSupports() {
    print('object');
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.transaction.status) {
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
    return BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
      if (state is CancelTransaction) {
        if (state.success) {
          // Navigator.pop(context, true);
          // showDialog(
          //   context: context,
          //   builder: (context) => AlertDialog(
          //     content: Text('Transacción cancelada con éxito.'),
          //   ),
          // );
          // Scaffold.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("Hola, soy SnackBar"),
          //   ),
          // );
          Future.delayed(Duration.zero, () {
            //Aqui va el code
            Navigator.pushNamed(context, routes.HomeTransactionsPageRoute);
          });
        } else {
          print(state.error);
        }
      }
      return GestureDetector(
        onHorizontalDragEnd: widget.transaction.status == 12601
            ? (details) {
                if (cancelar) {
                  cancelar = false;
                } else {
                  cancelar = true;
                }
                setState(() {});
              }
            : null,
        child: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 20),
          // color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20, left: 10),
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
                        widget.transaction.activity,
                        style: TextStyle(fontSize: 12, fontFamily: "Poppins"),
                      ),
                      Row(
                        children: [
                          // Icon(icon),
                          Text(
                            widget.transaction.date,
                            style: TextStyle(color: Color(0xff9F9F9F)),
                          )
                        ],
                      ),
                      Text(
                          '${widget.transaction.auxiliary} (${widget.transaction.value})')
                    ],
                  ),
                ],
              ),
              IconButton(
                icon: cancelar
                    ? Icon(Icons.highlight_off, color: Colors.red)
                    : Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  cancelar ? cancelTransaction() : showSupports();
                },
              )
              // Icon(Icons.arrow_forward_ios)
            ],
          ),
        ),
        onTap:  () {
          Navigator.pushNamed(context, routes.HomeVochersPageRoute,
              arguments: widget.transaction.vouchers);
        },
      );
    });
  }
}
