import 'package:facilapp/src/features/transactions/models/movement.dart';
import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:facilapp/src/features/transactions/ui/screens/movements/cubit/movement_cubit.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/movement_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovementScreen extends StatelessWidget {
  Voucher voucher;
  MovementScreen({this.voucher});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovementCubit(),
      child: MovementListScreen(
        voucher: voucher,
      ),
    );
  }
}

class MovementListScreen extends StatefulWidget {
  final Voucher voucher;

  const MovementListScreen({Key key, this.voucher}) : super(key: key);
  @override
  _MovementListScreenState createState() => _MovementListScreenState();
}

class _MovementListScreenState extends State<MovementListScreen> {
  List<Movement> _listMovements;
  var _movementsCubit;

  void initState() {
    super.initState();
    _listMovements = [];
    _movementsCubit = BlocProvider.of<MovementCubit>(context);
    // _movementsCubit.loading();
    _movementsCubit.getByVoucher(id: widget.voucher.id);
    // _scrollController.addListener(() {
    //   if (_scrollController.position.pixels ==
    //           _scrollController.position.maxScrollExtent &&
    //       loadingData) {
    //     _getMoreData();
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovementCubit, MovementState>(
      builder: (context, state) {
        if (state is MovementLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()),);
          // return Center(child: CircularProgressIndicator());
        }
        if (state is GetByVoucher) {
          _listMovements = state.listMovements;
        }
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text('Comprobante Contable ${widget.voucher.id}'),
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
              itemCount: _listMovements.length,
              itemBuilder: (context, index) {
                return MovementWidget(
                  movement: _listMovements[index],
                );
              },
            ));
      },
    );
  }
}
