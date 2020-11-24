import 'package:facilapp/src/features/transactions/ui/screens/drawer.dart';
import 'package:facilapp/src/features/transactions/ui/screens/vouchers/list_vouchers_screen.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/appbar_search.dart';
import 'package:flutter/material.dart';

class VoucherScreen extends StatefulWidget {
  final vouchers;

  const VoucherScreen({Key key, this.vouchers}) : super(key: key);

  @override
  _VoucherScreenState createState() => _VoucherScreenState();
}

class _VoucherScreenState extends State<VoucherScreen> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";
  bool filter;
  @override
  void initState() {
    super.initState();
    filter = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerOcobo(),
      appBar: AppbarSearch(
        title: 'Comprobantes',
      ),
      body: ListVoucherScreen(
        registros: widget.vouchers,
      ),
    );
  }
}
