part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {}


class GetAllTransactions extends TransactionState {
  const GetAllTransactions({this.listTransactions});
  final List<Transaction> listTransactions;

  @override
  List<Object> get props {
    return [listTransactions];
  }

  @override
  String toString() => 'List Books { posts: ${listTransactions.toString()}}';
}

