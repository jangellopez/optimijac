class Junta {
  String id;
  final String nombre;
  final String barrioId;


factory Junta.fromMap(Map<String, dynamic> map) {
    return Junta(
        id: map['id'],
        nombre: map['nombre'],
        barrioId: map['barrioId'],
      );
  }
  Junta(
      {this.id = '',
      required this.nombre,
      required this.barrioId});

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'barrioId': barrioId,
      };
}
