import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/movements_repository.dart';
import 'package:facilapp/src/features/transactions/models/movement.dart';

part 'movement_state.dart';

class MovementCubit extends Cubit<MovementState> {
  final _movementsRepository = MovementsRepository();
  MovementCubit() : super(MovementInitial());
  void loading() {
    emit(MovementLoading());
  }
  void getByVoucher({id}) async {
    emit(MovementLoading());
    List<Movement> _vouchers = await _movementsRepository.getByVoucher(id: id);
    // bool loadingData =
    //     _vouchers.length == 0 && _vouchers.length < limit ? false : true;
    emit(GetByVoucher(listMovements: _vouchers));
  }
}
