const String alias = 't.';

class Transaction {
  final int id;
  final int status;
  final int idActivity;
  final String activity;
  final String date;
  final int docAuxiliary;
  final String auxiliary;
  final double value;
  final String account;
  final String desAccount;
  final String observation;
  final List images;
  final String vouchers;

  Transaction(
      {this.id,
      this.status,
      this.idActivity,
      this.activity,
      this.date,
      this.docAuxiliary,
      this.auxiliary,
      this.value,
      this.account,
      this.desAccount,
      this.observation,
      this.images,
      this.vouchers});
  factory Transaction.fromMap(Map map) {
    return Transaction(
        id: map['ejecutar'],
        status: map['seguimiento'],
        idActivity: map['agenda'],
        activity: map['gAgenda']['descripcion'],
        date: map['fecha'],
        docAuxiliary: map['documento'],
        auxiliary: map['nombre'],
        value: double.parse(map['valor']),
        account: map['cuenta'],
        desAccount: map['desCuenta'],
        observation: map['observacion'],
        images: [
          map['archivo0'],
          map['archivo1'],
          map['archivo2'],
          map['archivo3']
        ],
        vouchers: map['registro']);
  }
}
