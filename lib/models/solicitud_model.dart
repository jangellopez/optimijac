class Solicitud {
  String id;
  final String comunaId;
  final String barrioId;
  final String habitanteId;

factory Solicitud.fromMap(Map<String, dynamic> map) {
    return Solicitud(
        id: map['id'],
        comunaId: map['comunaId'],
        barrioId: map['barrioId'],
        habitanteId: map['habitanteId'],
      );
  }
  Solicitud(
      {this.id = '',
      required this.comunaId,
      required this.barrioId,
      required this.habitanteId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'comunaId': comunaId,
        'barrioId': barrioId,
        'habitanteId': habitanteId,
      };
}
