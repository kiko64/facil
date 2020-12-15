import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/transactions_repository.dart';
import 'package:facilapp/src/features/transactions/models/account.dart';
import 'package:facilapp/src/features/transactions/models/activity.dart';
import 'package:facilapp/src/features/transactions/models/auxiliary.dart';
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
    final result =
        await _transactionRepository.cancelTransaction(id: id, status: status);
    if (result == 200) {
      emit(CancelTransaction(success: true));
    } else {
      emit(CancelTransaction(error: "Error al cancelar la transacción"));
    }
  }

  void updateTransaction({Transaction transaction}) async {
    emit(TransactionLoading());
    // emit(UpdateTransaction(success: false));
    final result = await _transactionRepository.updateTransaction(
        id: transaction.id,
        idActivity: transaction.idActivity,
        value: transaction.value,
        docAuxiliary: transaction.docAuxiliary,
        account: transaction.account,
        observation: transaction.observation,
        images: transaction.images);
    if (result == 200) {
      emit(UpdateTransaction(success: true));
      // emit(UpdateTransaction(success: false));
    } else {
      emit(UpdateTransaction(error: "Error al actualizar la transacción"));
    }
  }

  void registerTransaction({Transaction transaction}) async {
    emit(TransactionLoading());
    final result = await _transactionRepository.registerTransaction(
        date: transaction.date,
        tracing: transaction.status,
        activity: transaction.idActivity,
        document: transaction.docAuxiliary,
        account: transaction.account,
        value: transaction.value.toString(),
        observation: transaction.observation);
    if (result.statusCode == 201) {
      Map<String, dynamic> responseData = json.decode(result.body);
      var id = responseData['ejecutar'].toString();
      registerImagesTransaction(id: id, images: transaction.images);
      emit(RegisteredTransaction(success: true, id: id));
    } else {
      emit(RegisteredTransaction(error: "Error al registrar la transacción"));
    }
  }

  void registerImagesTransaction({final id, List images}) async {
    emit(TransactionLoading());
    final result =
        await _transactionRepository.updateImages(id: id, images: images);
    if (result == 200) {
      emit(RegisteredImagesTransaction(success: true));
    } else {
      emit(RegisteredImagesTransaction(error: "Error al subir los soportes"));
    }
  }

  void getActivities({String number, String word}) async {
    List<Activity> result =
        await _transactionRepository.getActivities(number: number, word: word);
    emit(GetActivities(listActivities: result));
  }

  void getAccounts() async {
    List<Account> result = await _transactionRepository.getAccounts();
    emit(GetAccounts(listAccounts: result));
  }

  void getAuxiliaries({String number, String type}) async {
    List<Auxiliary> result =
        await _transactionRepository.getAuxiliaries(number: number, type: type);
    emit(GetAuxiliaries(listAuxiliaries: result));
  }

  void changeCancel(cancel) {
    emit(TransactionInitial());
    emit(ChangedCancelState(cancel: cancel));
  }
}
