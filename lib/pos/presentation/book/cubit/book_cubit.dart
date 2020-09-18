import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/pos/data/repositories/book_repository.dart';
import 'package:facilapp/pos/models/book.dart';
import 'package:meta/meta.dart';

part 'book_state.dart';

class BookCubit extends Cubit<BookState> {
  BookCubit() : super(BookInitial());
  final _bookRepository = BookRepository();
  void getAll({final name = ""}) async {
    emit(BookLoading());
    List<Book> _books = await _bookRepository.getAllBook(name: name);
    emit(GetAllBooks(listBooks: _books));
  }

  void updateBook({Book book}) async {
    emit(BookLoading());
    final result = await _bookRepository.updateBook(
        id: book.id,
        name: book.name,
        numberOfPages: book.numberOfPages,
        price: book.price,
        publicationDate: book.publicationDate,
        status: book.status);
    if (result == 200) {
      emit(BookUpdated(success: true));
    } else {
      emit(BookUpdated(error: "Problemas al actualizar"));
    }
  }

  void registerBook({Book book}) async {
    emit(BookLoading());
    final result = await _bookRepository.registerBook(
        name: book.name,
        numberOfPages: book.numberOfPages,
        price: book.price,
        publicationDate: book.publicationDate,
        status: book.status);
    if (result == 201) {
      emit(RegisteredBook(success: true));
    } else {
      emit(RegisteredBook(error: "Problemas al registrar"));
    }
  }

  void deleteBook({final id}) async {
    emit(BookLoading());
    final result = await _bookRepository.deleteBook(id: id);
    if (result == 200) {
      emit(DeletedBook(success: true));
    } else {
      emit(DeletedBook(error: "Problemas al eliminar"));
    }
  }
}
