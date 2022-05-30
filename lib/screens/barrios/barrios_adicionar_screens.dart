import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/barrio_model.dart';
import '../../shared/widget_Share.dart';

class AdicionarBarrios extends StatefulWidget {
  AdicionarBarrios({Key? key}) : super(key: key);

  @override
  State<AdicionarBarrios> createState() => _AdicionarBarrios();
}

class _AdicionarBarrios extends State<AdicionarBarrios> {
  //objeto barrio
  var aux = false;
  //Controler
  late TextEditingController nombreController;
  late TextEditingController numeroHabitanteController;
  late TextEditingController comunaControlller;
  // Firebase
  // final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nombreController = TextEditingController();
    numeroHabitanteController = TextEditingController();
    comunaControlller = TextEditingController();
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
                    'Registro Barrios',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),

                  //TEXTOSSSSSSSSSSSSSSSSSSSSSSSSS
                  //Texto NOMBRE BARRIOOO
                  SizedBox(height: 25),
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
                              hintText: 'Nombre Barrio'),
                          controller: nombreController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese un nombre.");
                            }
                            //Expression regulares para el email
                            if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                              return ("Por Favor, Ingrese un nombre valido.");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  //Texto NOMBRE BARRIOOO
                  SizedBox(height: 25),
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
                              hintText: 'id Comuna'),
                          controller: comunaControlller,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese una Comuna.");
                            }
                            //Expression regulares para el email
                            if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                              return ("Por Favor, Ingrese una Comuna valido.");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  //BOTONESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          primary: Color(0xff04b554),
                          padding: EdgeInsets.all(20),
                        ),
                        onPressed: () {
                          crearBarrio(
                              nombreController.text, comunaControlller.text);
                         
                        },
                        child: Container(
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future crearBarrio(String name, String cominaID) async {
    if (_formKey.currentState!.validate()) {
      final docBarrio = FirebaseFirestore.instance.collection("Barrios").doc();

      //mapeo
      final barrio = Barrio(
        id: docBarrio.id,
        nombre: name,
        comunaId: cominaID,
        numeroHabitantes: "15",
      );

      final json = barrio.toJson();

      //crear el documento y escribir en Firebae
      await docBarrio.set(json);
      
      Fluttertoast.showToast(msg: "Barrio Creado");
      Navigator.pop(context);
    } else {
     
      Fluttertoast.showToast(msg: "Algo ocurrio mal!");
    }
  }
}
