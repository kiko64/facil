import 'package:facilapp/src/features/transactions/models/voucher.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/voucher_widget.dart';
import 'package:flutter/material.dart';

class ListVoucher extends StatefulWidget {
  @override
  _ListVoucherState createState() => _ListVoucherState();
}

class _ListVoucherState extends State<ListVoucher> {
  var comprobante1 = Voucher(
    number: 1,
    date: DateTime.parse("1969-07-20 20:18:04Z"),
    datetime: '01-OCT-2020 5:30 P.M',
    auxiliary: 'Alcanos',
    value: 12860
  );
  var comprobante2 = Voucher(
    number: 2,
    date: DateTime.parse("1969-07-20 20:18:04Z"),
    datetime: '30-SEP-2020 2:00 P.M',
    auxiliary: 'Celsia',
    value: 42860
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Filtro(),
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              VoucherWidget(voucher: comprobante1,),
              VoucherWidget(voucher: comprobante2,),
            ],
          ),
        )
      ],
    );
  }
}
