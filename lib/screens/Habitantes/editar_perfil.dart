import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/home/menu_sreens.dart';
import 'package:optimijac/shared/widget_Share.dart';

import '../../models/habitantes_model.dart';

class EditarPerfil extends StatefulWidget {
  //variables obtenidas
  final String email, password, id;
  EditarPerfil(this.email, this.password, this.id, {Key? key})
      : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  //Variables
  String valorTipoId = 'Cedula';
  String valorGenero = 'Masculino';
  var itemsTipoId = ['Cedula', 'Tarjeta identidad', 'Pasaporte'];
  var itemsGenero = ['Masculino', 'Femenino'];
  var aux = false;
  //Controler
  late TextEditingController idController;
  late TextEditingController tipoDocumentoController;
  late TextEditingController idetificacionController;
  late TextEditingController nombresController;
  late TextEditingController apellidosController;
  late TextEditingController fechaNacimientoController;
  late TextEditingController edadController;
  late TextEditingController generoController;
  late TextEditingController telefonoController;
  late TextEditingController direccionController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  // Firebase
  final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    idController = TextEditingController();
    tipoDocumentoController = TextEditingController();
    idetificacionController = TextEditingController();
    nombresController = TextEditingController();
    apellidosController = TextEditingController();
    fechaNacimientoController = TextEditingController();
    edadController = TextEditingController();
    generoController = TextEditingController();
    telefonoController = TextEditingController();
    direccionController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textowigetShared('Editar perfil'),
                SizedBox(height: 10),
                Center(
                  child: Stack(children: [
                    CircleAvatar(
                      backgroundImage:
                          NetworkImage('https://i.pravatar.cc/300'),
                      foregroundColor: Colors.transparent,
                      radius: 70,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 4,
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(3),
                            color: Colors.white,
                            child: ClipOval(
                              child: Container(
                                padding: EdgeInsets.all(8),
                                color: Color(0xff04b554),
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )),
                  ]),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: DropdownButtonFormField<String>(
                        hint: Text('Seleccionar'),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Tipo identificacion',
                            labelStyle: TextStyle(color: Color(0xff04b554))),
                        borderRadius: BorderRadius.circular(12),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsTipoId.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            valorTipoId = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Cedula'),
                        controller: idetificacionController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese su Cedula.");
                          }
                          //Expression regulares para el email
                          if (!RegExp("^[0-9]").hasMatch(value)) {
                            return ("Por Favor, Ingrese una Cedula valido.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Nombres'),
                        controller: nombresController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese sus Nombres.");
                          }
                          //Expression regulares para el email
                          if (!RegExp("^[a-zA-Z0-9]").hasMatch(value)) {
                            return ("Por Favor, Ingrese Nombres validos.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Apellidos'),
                        controller: apellidosController,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese sus Apellidos.");
                          }
                          //Expression regulares para el email
                          if (!RegExp("^[a-zA-Z0-9]").hasMatch(value)) {
                            return ("Por Favor, Ingrese Apellidos validos.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: _inputDateBirth(context),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: DropdownButtonFormField<String>(
                        hint: Text('Seleccionar'),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Genero',
                            labelStyle: TextStyle(color: Color(0xff04b554))),
                        borderRadius: BorderRadius.circular(12),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsGenero.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            valorGenero = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Telefono'),
                        controller: telefonoController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese un telefono.");
                          }
                          //Expression regulares para el email
                          if (!RegExp("^[0-9]").hasMatch(value)) {
                            return ("Por Favor, Ingrese un telefono valida.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Dirección'),
                        controller: direccionController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese su Direccion.");
                          }
                          //Expression regulares para el email
                          if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                            return ("Por Favor, Ingrese una direccion valida.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: widget.email),
                        controller: emailController,
                        readOnly: true,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.grey.shade200, width: 1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextFormField(
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: widget.password),
                        controller: passwordController,
                        readOnly: true,
                      ),
                    ),
                  ),
                ),
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
                        emailController.text = widget.email;
                        passwordController.text = widget.password;
                        idController.text = widget.id;
                        tipoDocumentoController.text = valorTipoId;
                        generoController.text = valorGenero;
                        //print(fechaNacimientoController.text);
                        //print(edadController.text);
                        modificar(emailController.text, passwordController.text,
                            idController.text);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                          child: Text(
                            'Aceptar',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //metodos edad
  late var anoActual, mesActual, anoNaci, mesNaci;
  Widget _inputDateBirth(BuildContext _context) {
    return TextField(
      enableInteractiveSelection: false,
      controller: fechaNacimientoController,
      decoration: InputDecoration(
          hintText: 'Seleccione fecha de nacimiento',
          labelText: 'Fecha de Nacimiento',
          suffixIcon: Icon(Icons.perm_contact_calendar),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          icon: Icon(Icons.calendar_today)),
      onTap: () {
        FocusScope.of(_context).requestFocus(new FocusNode());
        _selectedDate(context);
      },
    );
  }

  //fecha de naacimiento
  _selectedDate(BuildContext _context) async {
    DateTime fechaActual;
    int edadd;
    int valor = 1;
    DateTime? picke = await showDatePicker(
        context: _context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1700),
        lastDate: DateTime(2032));

    fechaActual = DateTime.now();
    if (picke != null) {
      setState(() {
        fechaNacimientoController.text = picke.toString().substring(0, 10);
        if (fechaActual.month < picke.month) {
          edadd = int.parse((fechaActual.year - picke.year).toString());
          edadController.text = (edadd - valor).toString();
        } else if (fechaActual.month > picke.month) {
          edadController.text = (fechaActual.year - picke.year).toString();
        }
      });
    }
  }

  //registrar Funcion
  void modificar(String email, String password, String id) async {
    if (_formKey.currentState!.validate()) {
      //crear en colleccion
      final docHabitante =
          FirebaseFirestore.instance.collection("Habitantes").doc(id);

      //mapeo
      final habitante = Habitante(
        id: id,
        tipoIdetificacion: tipoDocumentoController.text,
        idetificacion: idetificacionController.text,
        nombres: nombresController.text,
        apellidos: apellidosController.text,
        fechaNacimiento: fechaNacimientoController.text,
        edad: edadController.text,
        genero: generoController.text,
        telefono: telefonoController.text,
        direccion: direccionController.text,
        email: email,
        password: password,
      );
      //print(habitante.toJson().toString());
      final json = habitante.toJson();

      //crear el documento y escribir en Firebae
      await docHabitante
          .update(json)
          .then((value) => {
                Fluttertoast.showToast(msg: "Perfil Completado"),
                singIn(email, password),
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  //Login Funcion
  void singIn(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              Fluttertoast.showToast(msg: "Bienvenido"),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Menu(email))),
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
