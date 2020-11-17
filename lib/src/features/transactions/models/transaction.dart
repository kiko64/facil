class Transaction {
  final int id;
  final int status;
  final String activity;
  final String date;
  final String auxiliary;
  final String value;

  Transaction({
    this.id,
    this.status,
    this.activity,
    this.date,
    this.auxiliary,
    this.value,
  });
  factory Transaction.fromMap(Map map) {
    return Transaction(
        id: map['ejecutar'],
        status: map['seguimiento'],
        activity: map['gAgenda']['descripcion'],
        date: map['fecha'],
        auxiliary: map['nombre'],
        value: map['valor']);
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
