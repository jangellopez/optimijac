class Habitante {
  String id;
  final String cedula;
  final String nombre;
  final String apellido;
  final String email;
  final String password;


  Habitante(
      {this.id = '',
      required this.cedula,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.password});


  Map<String, dynamic> toJson() => {
        'id': id,
        'cedula': cedula,
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'password': password
      };
}
