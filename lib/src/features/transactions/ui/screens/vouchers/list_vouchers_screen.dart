import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:facilapp/src/features/transactions/ui/screens/vouchers/cubit/voucher_cubit.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/voucher_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListVoucherScreen extends StatelessWidget {
  final String registros;

  const ListVoucherScreen({Key key, this.registros}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VoucherCubit(),
      child: ListVoucher(
        registros: registros,
      ),
    );
  }
}

class ListVoucher extends StatefulWidget {
  final String registros;

  const ListVoucher({Key key, this.registros}) : super(key: key);
  @override
  _ListVoucherState createState() => _ListVoucherState();
}

class _ListVoucherState extends State<ListVoucher> {
  List<Voucher> _listVoucher;
  ScrollController _scrollController = ScrollController();
  var _voucherCubit;
  String registros;
  int offset = 1;
  bool loadingData;

  void initState() {
    super.initState();
    loadingData = true;
    registros = widget.registros;
    _listVoucher = [];
    _voucherCubit = BlocProvider.of<VoucherCubit>(context);
    _voucherCubit.loading();
    _voucherCubit.getAll(registros: registros, offset: offset);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          loadingData) {
        _getMoreData();
      }
    });
  }

  _getMoreData() {
    _voucherCubit.getAll(registros: registros, offset: offset + 1);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoucherCubit, VoucherState>(
      builder: (context, state) {
        if (state is VoucherLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is GetAllVouchers) {
          offset = state.offset;
          loadingData = state.loadingData;
          _listVoucher.addAll(state.listVouchers);
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
                controller: _scrollController,
                itemCount: _listVoucher.length,
                itemBuilder: (context, index) {
                  if (loadingData) {
                    if (index == _listVoucher.length - 1) {
                      return Center(
                          heightFactor: 1.5,
                          child: CircularProgressIndicator());
                    }
                  }
                  return VoucherWidget(
                    voucher: _listVoucher[index],
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
