import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

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
  final String rRol;
  final String comunaId;
  final String barrioId;

  factory Habitante.fromMap(Map<String, dynamic> map) {
    return Habitante(
        id: map['id'],
        tipoIdetificacion: map['tipoIdetificacion'],
        idetificacion: map['idetificacion'],
        nombres: map['nombres'],
        apellidos: map['apellidos'],
        fechaNacimiento: map['fechaNacimiento'],
        edad: map['edad'],
        genero: map['genero'],
        telefono: map['telefono'],
        direccion: map['direccion'],
        email: map['email'],
        password: map['password'],
        imageUrl: map['imageUrl'],
        rRol: map['rRol'],
        comunaId: map['comunaId'],
        barrioId: map['barrioId']);
  }
  Habitante({
    this.id = '',
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
    required this.imageUrl,
    required this.rRol,
    required this.comunaId,
    required this.barrioId,
  });

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
        'imageUrl': imageUrl,
        'rRol': rRol,
        'comunaId': comunaId,
        'barrioId': barrioId
      };
}