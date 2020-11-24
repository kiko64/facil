part of 'voucher_cubit.dart';

abstract class VoucherState extends Equatable {
  const VoucherState();

  @override
  List<Object> get props => [];
}

class VoucherInitial extends VoucherState {}

class VoucherLoading extends VoucherState {}

class GetAllVouchers extends VoucherState {
  const GetAllVouchers({this.listVouchers, this.offset, this.loadingData});
  final List<Voucher> listVouchers;
  final int offset;
  final bool loadingData;
  @override
  List<Object> get props {
    return [listVouchers, offset, loadingData];
  }

  @override
  String toString() =>
      'List Books { posts: ${listVouchers.toString()}, offset: $offset, loadingData: $loadingData}';
}
