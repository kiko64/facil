import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/transactions_repository.dart';
import 'package:facilapp/src/features/transactions/models/transaction.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());
  final _transactionRepository = TransactionRepository();
  final limit = 20;
  void loading() {
    emit(TransactionLoading());
  }

  void getAll({final name = "", offset}) async {
    // emit(TransactionLoading());
    List<Transaction> _transactions = await _transactionRepository
        .getAllTransactions(name: name, offset: offset, limit: limit);
    final loadingData =
        _transactions.length == 0 && _transactions.length < limit ? false : true;

    emit(GetAllTransactions(listTransactions: _transactions, offset: offset, loadingData: loadingData));
  }

  void cancelTransaction({final id, status}) async {
    emit(TransactionLoading());
    final result = await _transactionRepository.cancelTransaction(id, status);
    if (result == 200) {
      emit(CancelTransaction(success: true));
    } else {
      emit(CancelTransaction(error: "Error al cancelar la transacción"));
    }
  }
}
