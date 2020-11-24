import 'package:intl/intl.dart';

class Voucher {
  final int id;
  final int status;
  final String date;
  final String auxiliary;
  final String value;
  Voucher({
    this.id,
    this.status,
    this.date,
    this.auxiliary,
    this.value,
  });
  factory Voucher.fromMap(Map map) {
    return Voucher(
        id: map['registro'],
        status: map['seguimiento'],
        date: map['fechaContable'],
        auxiliary: map['nombre'],
        value: NumberFormat.simpleCurrency().format(map['valor'])     
        );
  }
}
