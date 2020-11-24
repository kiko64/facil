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
    List<Voucher> _vouchers = await _voucherRepository.getAllVoucher(
        registros: registros, offset: offset, limit: limit);
    bool loadingData =
        _vouchers.length == 0 && _vouchers.length < limit ? false : true;
    emit(GetAllVouchers(
        listVouchers: _vouchers, offset: offset, loadingData: loadingData));
  }
}
