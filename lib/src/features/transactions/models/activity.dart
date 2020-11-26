class Activity {
  final int id;
  final String description;
  final int type;

  Activity({
    this.id,
    this.description,
    this.type,
  });

  factory Activity.fromMap(Map map) {
    return Activity(
      id: map['id'],
      description: map['descripcion'],
      type: map['tipo']
    );
  }
}
