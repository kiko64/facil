import 'package:facilapp/src/features/transactions/ui/screens/vouchers/cubit/voucher_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facilapp/src/router/router_path.dart' as routes;

class AppbarSearch extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  AppbarSearch({this.title});
  @override
  Size get preferredSize => Size.fromHeight(60);
  @override
  _AppbarSearchState createState() => _AppbarSearchState();
}

class _AppbarSearchState extends State<AppbarSearch> {
  TextEditingController _searchQueryController = TextEditingController();
  bool _isSearching = false;
  String searchQuery = "Search query";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: _isSearching ? const BackButton() : null,
      title: _isSearching
          ? _buildSearchField()
          :
          // title:
          Text(
              widget.title,
            ),
      actions: _buildActions(),
    );
  }

  // Dibuja el textField
  Widget _buildSearchField() {
    return TextField(
      controller: _searchQueryController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: "Buscar",
        border: InputBorder.none,
        hintStyle: TextStyle(color: Color(0xff9F9F9F)),
      ),
      style: TextStyle(
          color: Colors.black, fontSize: 15.0, fontFamily: "Poppinslight"),
      onChanged: (query) => updateSearchQuery(query),
    );
  }

  //Dibuja los iconos del action
  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        IconButton(
          icon: const Icon(
            Icons.highlight_off,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              Navigator.pop(context);
              _isSearching = false;
              return;
            }
            _isSearching = false;
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          _startSearch();
        },
      )
    ];
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
    print('object');
    SnackBar(content: Text(_searchQueryController.text));
    BlocProvider.of<VoucherCubit>(context)
        .getAll(query: _searchQueryController.text);
    Future.delayed(Duration.zero, () {
      Navigator.pushNamed(context, routes.HomeVochersPageRoute);
    });
    setState(() {
      searchQuery = newQuery;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQueryController.clear();
      updateSearchQuery("");
    });
  }
}
