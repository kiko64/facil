part of 'card_cubit.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class RegisteredBook extends CardState {}

class FailedRegisterBook extends CardState {}

class LoadingRegister extends CardState {}
