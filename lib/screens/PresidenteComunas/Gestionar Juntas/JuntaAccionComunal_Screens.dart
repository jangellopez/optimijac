import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/Administrador/GestionarComunas/FiltroComuna_barrios.dart';

import '../../../models/junta_model.dart';
import '../../../shared/widget_Share.dart';

class addJac extends StatefulWidget {
  final String barrioId;
  addJac(this.barrioId, {Key? key}) : super(key: key);

  @override
  State<addJac> createState() => _addJacState();
}

class _addJacState extends State<addJac> {
  late TextEditingController nombreJAC;

  // Firebase
  // final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nombreJAC = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff04b554),
          centerTitle: true,
          title: Text(
            'Optimijac',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Texto
                textowigetShared('Registrar JAC'),
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
                            hintText: 'Nombre JAC'),
                        controller: nombreJAC,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese un Nombre.");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                            return ("Por Favor, Ingrese un Nombre valido.");
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),

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
                        crearJunta(nombreJAC.text, widget.barrioId);
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
    );
  }

  Future crearJunta(String nombre, String barrioId) async {
    if (_formKey.currentState!.validate()) {
      final docJAC = FirebaseFirestore.instance.collection("Junta").doc();
      //mapeo
      final junta = Junta(id: docJAC.id, nombre: nombre, barrioId: barrioId);
      final json = junta.toJson();

      //crear el documento y escribir en Firebae
      await docJAC.set(json);
      final docBarrio =
          FirebaseFirestore.instance.collection("Barrios").doc(widget.barrioId);

      //crear el documento y escribir en Firebae
      docBarrio
          .update({'juntaId': docJAC.id})
          .then((value) => {
                Fluttertoast.showToast(msg: "Barrio Completado"),
              })
          .catchError((e) {
            Fluttertoast.showToast(msg: e!.message);
          });

      Fluttertoast.showToast(msg: "Junta Creado");
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(msg: "Algo ocurrio mal!");
    }
  }
}
