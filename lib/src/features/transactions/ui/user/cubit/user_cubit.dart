import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  void changeOptionDrawer({option}) {
    // print(option);
    emit(UserInitial());
    emit(ChangedOptionDrawer(option: option));
  }
}
