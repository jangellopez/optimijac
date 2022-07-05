class Barrio {
  String id;
  final String nombre;
  final String comunaId;
  final String numeroHabitantes;
  final String juntaId;

factory Barrio.fromMap(Map<String, dynamic> map) {
    return Barrio(
        id: map['id'],
        nombre: map['nombre'],
        comunaId: map['comunaId'],
        numeroHabitantes: map['numeroHabitantes'],
        juntaId: map['juntaId'],
      );
  }
  Barrio(
      {this.id = '',
      required this.nombre,
      required this.comunaId,
      required this.numeroHabitantes,
      required this.juntaId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'comunaId': comunaId,
        'numeroHabitantes': numeroHabitantes,
        'juntaId': juntaId
      };
}
