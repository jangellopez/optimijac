import 'package:flutter/material.dart';

import '../../../shared/widget_Share.dart';

class RegistrarPqrs extends StatefulWidget {
  RegistrarPqrs({Key? key}) : super(key: key);

  @override
  State<RegistrarPqrs> createState() => _RegistrarPqrsState();
}

class _RegistrarPqrsState extends State<RegistrarPqrs> {
  String valorPeticion = 'Peticion';
  var itemsComuna = ['Peticion', 'Queja', 'Reclamo', 'Sugerencia'];

  late TextEditingController tituloController;
  late TextEditingController descripcionController;
  late TextEditingController tipoControlller;
  // Firebase
  // final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    tituloController = TextEditingController();
    descripcionController = TextEditingController();
    tipoControlller = TextEditingController();
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
              children: <Widget>[
                //Texto
                textowigetShared('Registrar PQRS'),
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
                            labelText: 'Tipo',
                            labelStyle: TextStyle(color: Color(0xff04b554))),
                        borderRadius: BorderRadius.circular(12),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: itemsComuna.map((String items) {
                          return DropdownMenuItem<String>(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            valorPeticion = newValue!;
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
                            hintText: 'Titulo'),
                        controller: tituloController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese un titulo.");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                            return ("Por Favor, Ingrese un titulo valido.");
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
                        maxLines: null,
                        cursorColor: Color(0xff04b554),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            fillColor: Color(0xff04b554),
                            hintText: 'Descripcion'),
                        controller: descripcionController,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Por Favor, Ingrese una descripcion.");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]").hasMatch(value)) {
                            return ("Por Favor, Ingrese una descripcion valida.");
                          }
                          return null;
                        },
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
                        padding: EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        //tipoControlller.text = valorPeticion;
                        /*crearBarrio(
                            nombreController.text, comunaControlller.text);*/
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
}
