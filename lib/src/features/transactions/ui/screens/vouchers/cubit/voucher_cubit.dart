import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facilapp/src/features/transactions/data/repositories/voucher_repository.dart';
import 'package:facilapp/src/features/transactions/models/voucher.dart';

part 'voucher_state.dart';

class VoucherCubit extends Cubit<VoucherState> {
  VoucherCubit() : super(VoucherInitial());
  final _voucherRepository = VoucherRepository();
  final limit = 20;
  void loading() {
    emit(VoucherLoading());
  }

  void getAll({registros, offset}) async {
    // emit(VoucherLoading());
    List<dynamic> response = await _voucherRepository.getAllVoucher(
        registros: registros, offset: offset, limit: limit);
    List<Voucher> _vouchers = response[0];
    int total = response[1];
    bool loadingData = _vouchers.length == 0 &&
            _vouchers.length < limit ||
            _vouchers.length == total
        ? false
        : true;
    emit(GetAllVouchers(
        listVouchers: _vouchers, offset: offset, loadingData: loadingData));
  }
}
