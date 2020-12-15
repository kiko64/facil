import 'package:facilapp/src/features/transactions/models/transaction.dart';
import 'package:facilapp/src/features/transactions/ui/screens/transactions/cubit/transaction_cubit.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class ListTransactionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => TransactionCubit(),
        child: _ListTransactionScreen());
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
  ScrollController _scrollController = ScrollController();
  var _transactionCubit;
  int offset = 1;
  bool loadingData;

  void initState() {
    super.initState();
    loadingData = true;
    _listTransaction = [];
    _transactionCubit = BlocProvider.of<TransactionCubit>(context);
    _transactionCubit.loading();
    _transactionCubit.getAll(offset: offset);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          loadingData) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    _transactionCubit.getAll(offset: offset + 1);
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
            offset = state.offset;
            loadingData = state.loadingData;
            _listTransaction.addAll(state.listTransactions);
            
          }
          return Column(
            children: [
              Stack(
                children: [
                  Filtro(),
                ],
              ),
              Expanded(
                child: _listTransaction.length != 0 ? ListView.builder(
                  controller: _scrollController,
                  itemCount: _listTransaction.length,
                  itemBuilder: (context, index) {
                    //Revisar posible error
                    if (loadingData) {
                      if (index == _listTransaction.length - 1) {
                        return Center(
                            heightFactor: 1.5,
                            child: CircularProgressIndicator());
                      }
                    }
                    return TransactionWidgetScreen(
                      transaction: _listTransaction[index],
                      onTap: (transaction) {
                        if (transaction.status == 12601) {
                          Navigator.pushNamed(
                              context, routes.RegisterTransactionPageRoute,
                              arguments: transaction);
                        }
                      },
                    );
                  },
                ) : Center(child: Text('No se encontrarón resultados'),),
              )
            ],
          );
        },
      ),
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
    );
  }
}
