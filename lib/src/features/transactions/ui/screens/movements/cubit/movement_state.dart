part of 'movement_cubit.dart';

abstract class MovementState extends Equatable {
  const MovementState();

  @override
  List<Object> get props => [];
}

class MovementInitial extends MovementState {}

class MovementLoading extends MovementState {}

class GetByVoucher extends MovementState {
  const GetByVoucher({this.listMovements});
  final List<Movement> listMovements;
  @override
  List<Object> get props {
    return [listMovements];
  }

  @override
  String toString() =>
      'List Books { posts: ${listMovements.toString()}';
}
