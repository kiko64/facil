class Auxiliary {
  final int id;
  final String description;
  final int type;

  Auxiliary({this.id, this.description, this.type});

  factory Auxiliary.fromMap(Map map) {
    return Auxiliary(
      id: map['id'],
      description: map['descripcion'],
      type: map['tipo']
    );
  }
}
