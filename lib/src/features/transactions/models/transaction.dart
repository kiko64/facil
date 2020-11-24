import 'package:intl/intl.dart';

class Transaction {
  final int id;
  final int status;
  final String activity;
  final String date;
  final String auxiliary;
  final String value;
  final String vouchers;

  Transaction({
    this.id,
    this.status,
    this.activity,
    this.date,
    this.auxiliary,
    this.value,
    this.vouchers
  });
  factory Transaction.fromMap(Map map) {
    return Transaction(
        id: map['ejecutar'],
        status: map['seguimiento'],
        activity: map['gAgenda']['descripcion'],
        date: map['fecha'],
        auxiliary: map['nombre'],
        value: NumberFormat.simpleCurrency().format(double.parse(map['valor'])),
        vouchers: map['registro']);
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'id': id,
  //     'name': name,
  //     'numberOfPages': numberOfPages,
  //     'price': price,
  //     'publicationDate': publicationDate,
  //     'status': status
  //   };
  // }
}
