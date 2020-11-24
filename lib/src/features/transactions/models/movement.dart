import 'package:intl/intl.dart';

class Movement {
  int id;
  int voucher;
  int account;
  String description;
  String auxiliary;
  String debit;
  String credit;

  Movement({
    this.id,
    this.voucher,
    this.account,
    this.description,
    this.auxiliary,
    this.debit,
    this.credit,
  });

  factory Movement.fromMap(Map map) {
    return Movement(
      id: map['orden'],
      voucher: map['registro'],
      account: map['cuentaId'],
      description: map['cuenta']['descripcion'],
      auxiliary: map['auxiliar']['favorito'],
      debit: NumberFormat.simpleCurrency().format(map['valorDb']),
      credit: NumberFormat.simpleCurrency().format(map['valorCr'])
    );
  }
}
