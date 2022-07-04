import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/Habitantes/editar_perfil.dart';
import 'package:optimijac/shared/widget_Share.dart';

import '../../models/habitantes_model.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Controller
  TextEditingController _usuarioTextoController = TextEditingController();
  TextEditingController _passwordTextoController = TextEditingController();
  TextEditingController _confirmarPassTextoController = TextEditingController();
  //VisiblePassword
  bool _isObscure = true;
  bool _isObscureDos = true;
  // Firebase
  final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();
  var imageDefaultUrl = "";

  @override
  void initState() {
    loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //imagenes
                  logoWidget("assets/images/logoverde144.png"),
                  SizedBox(height: 10),
                  //Texto
                  Text(
                    'OptimiJAC',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 48),
                  ),
                  SizedBox(height: 25),
                  //Texto email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          cursorColor: Color(0xff04b554),
                          decoration: InputDecoration(
                              icon: Icon(Icons.person_rounded,
                                  color: Color(0xff04b554)),
                              border: InputBorder.none,
                              fillColor: Color(0xff04b554),
                              hintText: 'Email'),
                          controller: _usuarioTextoController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese su email.");
                            }
                            //Expression regulares para el email
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Por Favor, Ingrese un email valido.");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Texto Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          cursorColor: Color(0xff04b554),
                          obscureText: _isObscure,
                          controller: _passwordTextoController,
                          validator: (value) {
                            RegExp regExp = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese su contraseña.");
                            }
                            //Expression regulares para el email
                            if (!regExp.hasMatch(value)) {
                              return ("Por Favor, Ingrese un contraseña valida. (Min. 6 Caracteres)");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Color(0xff04b554)),
                              suffixIcon: IconButton(
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xff04b554)),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              border: InputBorder.none,
                              fillColor: Color(0xff04b554),
                              hintText: 'Contraseña'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Texto confirmar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          cursorColor: Color(0xff04b554),
                          obscureText: _isObscureDos,
                          controller: _confirmarPassTextoController,
                          validator: (value) {
                            RegExp regExp = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese su contraseña.");
                            } else if (value != _passwordTextoController.text) {
                              return ("Las contraseñas tienen que ser iguales.");
                            }
                            //Expression regulares para el email
                            if (!regExp.hasMatch(value)) {
                              return ("Por Favor, Ingrese un contraseña valida. (Min. 6 Caracteres)");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Color(0xff04b554)),
                              suffixIcon: IconButton(
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                      _isObscureDos
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xff04b554)),
                                  onPressed: () {
                                    setState(() {
                                      _isObscureDos = !_isObscureDos;
                                    });
                                  }),
                              border: InputBorder.none,
                              fillColor: Color(0xff04b554),
                              hintText: 'Confirmar Contraseña'),
                        ),
                      ),
                    ),
                  ),
                  //Boton
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: Color(0xff04b554),
                            padding: EdgeInsets.all(20)),
                        onPressed: () {
                          registrar(
                              _usuarioTextoController.text,
                              _passwordTextoController.text,
                              _confirmarPassTextoController.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: Text(
                              'Registrar',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  //link de ingresar a crear cuenta
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Ya estás registrado? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Inicia sesión',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff04b554),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  //registrar Funcion
  void registrar(String email, String password, String confirmPassword) async {
    if (_formKey.currentState!.validate()) {
      //crear en colleccion
      final docHabitante =
          FirebaseFirestore.instance.collection("Habitantes").doc();

      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "Usuario Creado"),
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => EditarPerfil(
                        email, password, docHabitante.id, imageDefaultUrl)))
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
      //mapeo
      final habitante = Habitante(
        id: docHabitante.id,
        tipoIdetificacion: '',
        idetificacion: '',
        nombres: '',
        apellidos: '',
        fechaNacimiento: '',
        edad: '',
        genero: '',
        telefono: '',
        direccion: '',
        email: email,
        password: password,
        imageUrl: imageDefaultUrl,
        rRol: 'HABITANTE',
        comunaId: '',
        barrioId: '',
      );

      final json = habitante.toJson();

      //crear el documento y escribir en Firebae
      await docHabitante.set(json);

      Fluttertoast.showToast(msg: "Complete su Perfil");
      //Navigator.pop(context);
    }
  }
  //colocar imagen predeterminada
  Future<void> loadImage() async {
    var imageUrl = await FirebaseStorage.instance
        .ref()
        .child('avatar_default.jpg')
        .getDownloadURL();
    setState(() {
      imageDefaultUrl = imageUrl;
    });
  }
}
