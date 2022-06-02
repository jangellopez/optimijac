class Habitante {
  String id;
  final String tipoIdetificacion;
  final String idetificacion;
  final String nombres;
  final String apellidos;
  final String fechaNacimiento;
  final String edad;
  final String genero;
  final String telefono;
  final String direccion;
  final String email;
  final String password;
  final String imageUrl;

  Habitante(
      {this.id = '',
      required this.tipoIdetificacion,
      required this.idetificacion,
      required this.nombres,
      required this.apellidos,
      required this.fechaNacimiento,
      required this.edad,
      required this.genero,
      required this.telefono,
      required this.direccion,
      required this.email,
      required this.password,
      required this.imageUrl});

  Map<String, dynamic> toJson() => {
        'id': id,
        'tipoIdetificacion': tipoIdetificacion,
        'idetificacion': idetificacion,
        'nombres': nombres,
        'apellidos': apellidos,
        'fechaNacimiento': fechaNacimiento,
        'edad': edad,
        'genero': genero,
        'telefono': telefono,
        'direccion': direccion,
        'email': email,
        'password': password,
        'imageUrl': imageUrl
      };
}
