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
    return [listTransactions,offset,loadingData];
  }

  @override
  String toString() => 'List Books { posts: ${listTransactions.toString()}, offset: $offset, loadingData: $loadingData}';
}

class CancelTransaction extends TransactionState {
  final String error;
  final bool success;

  CancelTransaction({this.success = false, this.error});
}
