import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/features/transactions/ui/screens/vouchers/list_vouchers_screen.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_search.dart';
import 'package:flutter/material.dart';

class VoucherScreen extends StatefulWidget {
  final vouchers;
  final search;
  const VoucherScreen({
    Key key,
    this.vouchers,
    this.search
  }) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerOcobo(
        selected: 2,
      ),
      appBar: AppbarSearch(
        title: 'Comprobantes',
      ),
      body: ListVoucherScreen(
        registros: widget.vouchers,
        search: "h",
      ),
    );
  }
}
