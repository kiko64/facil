part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class ChangedOptionDrawer extends UserState {
  final int option;

  ChangedOptionDrawer({this.option});
}
