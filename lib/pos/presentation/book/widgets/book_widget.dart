import 'package:facilapp/pos/models/book.dart';
import 'package:facilapp/pos/presentation/book/pages/book_page.dart';
import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  const BookWidget({this.book, this.bloc, this.searchBook});
  final Book book;
  final bloc;
  final String searchBook;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: GestureDetector(
        child: Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Center(child: Text(book.name)),
                Text('Paginas: ${book.numberOfPages}'),
                Text('Precio: ${book.price}'),
                Text('Publicado: ${book.publicationDate}'),
                Text('Estado: ${book.status ? 'Activo' : 'Inactivo'}'),
              ],
            ),
          ),
        ),
        onTap: () async {
          final isBack = await Navigator.push(
            context,
            MaterialPageRoute(builder: (nContext) => BookScreen(book: book)),
          );
          if (isBack) {
            bloc.getAll(name: searchBook);
          }
        },
      ),
    );
  }
}
