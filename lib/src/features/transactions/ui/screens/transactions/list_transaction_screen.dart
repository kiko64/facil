import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TransactionCubit(), child: _ListTransactionScreen());
  }
}

class _ListTransactionScreen extends StatefulWidget {
  const _ListTransactionScreen({
    Key key,
  }) : super(key: key);
  @override
  ListTransactionScreenState createState() => ListTransactionScreenState();
}

class ListTransactionScreenState extends State<_ListTransactionScreen> {
  List<Transaction> _listTransaction;
  var _transactionCubit;

  void initState() {
    super.initState();
    _listTransaction = [];
    _transactionCubit = BlocProvider.of<TransactionCubit>(context);
    _transactionCubit.getAll();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is GetAllTransactions) {
            _listTransaction = state.listTransactions;
          }
          return Column(
            children: [
              Stack(
                children: [
                  Filtro(),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _listTransaction.length,
                  itemBuilder: (context, index) {
                    return TransactionWidget(
                      transaction: _listTransaction[index],
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
      onWillPop: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
    );
  }
}
