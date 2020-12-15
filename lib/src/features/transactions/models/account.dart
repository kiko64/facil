class Account {
  final int id;
  final String description;
  final int type;

  Account({
    this.id,
    this.description,
    this.type,
  });

  factory Account.fromMap(Map map) {
    return Account(
      id: map['cuenta'],
      description: map['desCuenta'],
      type: map['tipo']
    );
  }
}
