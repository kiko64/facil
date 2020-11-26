import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/transactions_repository.dart';
import 'package:facilapp/src/features/transactions/models/activity.dart';
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
    List<dynamic> response = await _transactionRepository.getAllTransactions(
        name: name, offset: offset, limit: limit);
    List<Transaction> _transactions = response[0];
    int total = response[1];
    final loadingData =
        _transactions.length == 0 && _transactions.length < limit ||
                _transactions.length == total
            ? false
            : true;

    emit(GetAllTransactions(
        listTransactions: _transactions,
        offset: offset,
        loadingData: loadingData));
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

  void updateTransaction({Transaction transaction}) async {
    emit(TransactionLoading());
    final result = await _transactionRepository.updateTransaction(
        transaction.id,
        transaction.idActivity,
        transaction.value,
        transaction.docAuxiliary,
        transaction.account,
        transaction.observation,
        transaction.images);
    if (result == 200) {
      emit(UpdateTransaction(success: true));
    } else {
      emit(UpdateTransaction(error: "Error al cancelar la transacción"));
    }
  }

  void registerTransaction(Transaction transaction) {}

  void getActivities({String number, String word}) async {
    List<Activity> result =
        await _transactionRepository.getActivities(number: number, word: word);
    emit(GetActivities(listActivities: result));
  }
}
