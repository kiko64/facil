import 'package:facilapp/pos/models/book.dart';
import 'package:facilapp/pos/presentation/book/cubit/book_cubit.dart';
import 'package:facilapp/pos/presentation/book/widgets/book_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'book_page.dart';

class ListBookScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => BookCubit(), child: _ListBookScreen());
  }
}

class _ListBookScreen extends StatefulWidget {
  const _ListBookScreen({
    Key key,
  }) : super(key: key);
  @override
  ListBookScreenState createState() => ListBookScreenState();
}

class ListBookScreenState extends State<_ListBookScreen> {
  List<Book> _listBook;
  var _bookCubit;
  final _searchBookController = TextEditingController();

  void initState() {
    super.initState();
    _listBook = [];
    _bookCubit = BlocProvider.of<BookCubit>(context);
    _bookCubit.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(title: Text('Libros')),
        body: BlocBuilder<BookCubit, BookState>(builder: (context, state) {
          return BlocBuilder<BookCubit, BookState>(builder: (context, state) {
            if (state is BookLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (state is GetAllBooks) {
              _listBook = state.listBooks;
            }
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.teal[900],
                  child: Container(
                    padding: EdgeInsets.only(left: 10),
                    color: Colors.white,
                    child: TextFormField(
                      controller: _searchBookController,
                      autocorrect: true,
                      validator: (value) {
                        if (value != null) {
                          return "No es un nombre válido";
                        }
                        return null;
                      },
                      onFieldSubmitted: (text) =>
                          FocusScope.of(context).nextFocus(),
                      decoration: InputDecoration(
                        hintText: "Buscar Books",
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            _bookCubit.getAll(name: _searchBookController.text);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: ListView.builder(
                      itemCount: _listBook.length,
                      itemBuilder: (BuildContext nContext, int index) {
                        return Column(
                          children: <Widget>[
                            Container(
                                child: BookWidget(
                              book: _listBook[index],
                              bloc: context.bloc<BookCubit>(),
                              searchBook: _searchBookController.text,
                            ))
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: FloatingActionButton(
                      backgroundColor: const Color(0xff03dac6),
                      foregroundColor: Colors.black,
                      onPressed: () async {
                        final isBack = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (nContext) => BookScreen(book: null)),
                        );
                        if (isBack) {
                          context
                              .bloc<BookCubit>()
                              .getAll(name: _searchBookController.text);
                        }
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                )
              ],
            );
          });
        }),
      ),
      onWillPop: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
    );
  }
}
