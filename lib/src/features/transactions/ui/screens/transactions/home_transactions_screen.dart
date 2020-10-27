import 'package:facilapp/src/features/transactions/ui/screens/transactions/list_transaction_screen.dart';
import 'package:facilapp/src/features/transactions/ui/widgets/filter_widget.dart';
import 'package:flutter/material.dart';

class TransaccionScreen extends StatefulWidget {
  @override
  _TransaccionScreenState createState() => _TransaccionScreenState();
}

class _TransaccionScreenState extends State<TransaccionScreen> {
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
        drawer: Drawer(),
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Colors.white,
          leading: _isSearching ? _buildleading() : Container(),
          title: _isSearching
              ? _buildSearchField()
              :
              // title:
              Text(
                  'Transacciones',
                  style: TextStyle(
                      color: Colors.black, fontSize: 14, fontFamily: "Poppins"),
                ),
          actions: _buildActions(),
          bottom: filter
              ? Filtro()
              : !filter
                  ? null
                  : null,
        ),
        body: ListTransaccion(),
        floatingActionButton: FloatingActionButton(
          // backgroundColor: Color(0xff6A9426),
          child: Icon(Icons.add),
          onPressed: () {},
        ));
  }

  //Muestra o oculta el filtro
  showFilter() {
    if (filter) {
      filter = false;
    } else {
      filter = true;
    }
    setState(() {});
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
            color: Colors.black,
          ),
          onPressed: () {
            if (_searchQueryController == null ||
                _searchQueryController.text.isEmpty) {
              _isSearching = false;
              showFilter();
              return;
            }
            _isSearching = false;
            _clearSearchQuery();
            showFilter();
          },
        ),
      ];
    }

    return <Widget>[
      IconButton(
        icon: Icon(Icons.filter_list),
        color: Colors.black,
        onPressed: () {
          _startSearch();
          showFilter();
        },
      )
    ];
  }

  //Valida el leading
  _buildleading() {
    if (_isSearching) {
      return IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          if (_searchQueryController == null ||
              _searchQueryController.text.isEmpty) {
            _isSearching = false;
            showFilter();
            return;
          }
          _isSearching = false;
          _clearSearchQuery();
          showFilter();
        },
      );
    }
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void updateSearchQuery(String newQuery) {
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