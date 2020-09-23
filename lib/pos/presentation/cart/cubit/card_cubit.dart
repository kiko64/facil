import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/pos/data/repositories/book_repository.dart';
import 'package:facilapp/pos/models/book.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  final _bookRepository = BookRepository();

  void registra(Book book) async {
    emit(LoadingRegister());
    int code = await _bookRepository.registerBook(name: book.name);
    if (code == 200) {
      emit(RegisteredBook());
    } else {
      emit(FailedRegisterBook());
    }
  }
}
