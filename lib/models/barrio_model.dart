class Barrio {
  String id;
  final String nombre;
  final String comunaId;
  final String numeroHabitantes;

  Barrio(
      {this.id = '',
      required this.nombre,
      required this.comunaId,
      required this.numeroHabitantes});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'comunaId': comunaId,
        'numeroHabitantes': numeroHabitantes
      };
}
