import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/transactions_repository.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final _transactionRepository = TransactionRepository();
  void getAll({final name = ""}) async {
    emit(TransactionLoading());
    List<Transaction> _transactions = await _transactionRepository.getAllBook(name: name);
    emit(GetAllTransactions(listTransactions: _transactions));
  }
}
