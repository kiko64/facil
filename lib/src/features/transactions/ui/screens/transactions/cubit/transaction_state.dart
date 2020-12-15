part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}

class GetAllTransactions extends TransactionState {
  const GetAllTransactions(
      {this.listTransactions, this.offset, this.loadingData});
  final List<Transaction> listTransactions;
  final int offset;
  final bool loadingData;

  @override
  List<Object> get props {
    return [listTransactions, offset, loadingData];
  }

  @override
  String toString() =>
      'List Transactions { posts: ${listTransactions.toString()}, offset: $offset, loadingData: $loadingData}';
}

class CancelTransaction extends TransactionState {
  final String error;
  final bool success;

  CancelTransaction({this.success = false, this.error});
}

class UpdateTransaction extends TransactionState {
  final String error;
  final bool success;

  UpdateTransaction({this.success = false, this.error});
}

class RegisteredTransaction extends TransactionState {
  final String error;
  final bool success;
  final String id;

  RegisteredTransaction({this.success = false, this.error, this.id});
}

class RegisteredImagesTransaction extends TransactionState {
  final String error;
  final bool success;
  RegisteredImagesTransaction({this.success = false, this.error});
}

class GetActivities extends TransactionState {
  const GetActivities({this.listActivities});
  final List<Activity> listActivities;

  @override
  List<Object> get props {
    return [listActivities];
  }

  @override
  String toString() => 'List Activities { posts: ${listActivities.toString()}}';
}

class GetAccounts extends TransactionState {
  const GetAccounts({this.listAccounts});
  final List<Account> listAccounts;

  @override
  List<Object> get props {
    return [listAccounts];
  }

  @override
  String toString() => 'List Accounts { posts: ${listAccounts.toString()}}';
}

class GetAuxiliaries extends TransactionState {
  const GetAuxiliaries({this.listAuxiliaries});
  final List<Auxiliary> listAuxiliaries;

  @override
  List<Object> get props {
    return [listAuxiliaries];
  }

  @override
  String toString() =>
      'List Auxiliaries { posts: ${listAuxiliaries.toString()}}';
}

class ChangedCancelState extends TransactionState {
  final bool cancel;
  ChangedCancelState({this.cancel});
}
