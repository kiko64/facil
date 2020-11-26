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
      'List Books { posts: ${listTransactions.toString()}, offset: $offset, loadingData: $loadingData}';
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

class RegisterTransaction extends TransactionState {
  final String error;
  final bool success;

  RegisterTransaction(this.error, this.success);
}

class GetActivities extends TransactionState{
  const GetActivities({this.listActivities});
  final List<Activity> listActivities;

  @override
  List<Object> get props {
    return [listActivities];
  }

  @override
  String toString() =>
      'List Books { posts: ${listActivities.toString()}}';
}
