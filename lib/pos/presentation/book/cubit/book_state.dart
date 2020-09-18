part of 'book_cubit.dart';

@immutable
abstract class BookState extends Equatable {
  const BookState();

  @override
  List<Object> get props => [];
}

class BookInitial extends BookState {}

class BookLoading extends BookState {}

class GetAllBooks extends BookState {
  const GetAllBooks({this.listBooks});
  final List<Book> listBooks;

  @override
  List<Object> get props {
    return [listBooks];
  }

  @override
  String toString() => 'List Books { posts: ${listBooks.toString()}}';
}

class BookUpdated extends BookState {
  final String error;
  final bool success;

  BookUpdated({this.success = false, this.error});
}

class RegisteredBook extends BookState {
  final String error;
  final bool success;

  RegisteredBook({this.success = false, this.error});
}

class DeletedBook extends BookState {
  final String error;
  final bool success;

  DeletedBook({this.success = false, this.error});
}
