import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/models/habitantes_model.dart';

class addPC extends StatefulWidget {
  addPC({Key? key}) : super(key: key);

  @override
  State<addPC> createState() => _addPCState();
}

class _addPCState extends State<addPC> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _searchview = TextEditingController();
  //lista de habitanes
  List<addPC> habitantes = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Habitantes')
                        .where('rRol', isNotEqualTo: 'PRESIDENTE COMUNA')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container(
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey.shade200, width: 1),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: TextFormField(
                                      onChanged: (value) {
                                        setState(() {});
                                      },
                                      cursorColor: Color(0xff04b554),
                                      decoration: InputDecoration(
                                          icon: Icon(Icons.search_rounded,
                                              color: Color(0xff04b554)),
                                          border: InputBorder.none,
                                          fillColor: Color(0xff04b554),
                                          hintText: 'Buscar'),
                                      controller: _searchview,
                                      keyboardType: TextInputType.text,
                                    ),
                                  ),
                                )),
                            SizedBox(height: 10),
                            Expanded(
                              child: Rows(
                                text: _searchview.text,
                              ),
                            )
                          ],
                        ),
                      );
                    }))));
  }
}

////////////////////////////////////////////////////////////////////////////////////////
Future<List<Habitante>> getAll() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Habitantes')
      .where('rRol', isNotEqualTo: 'PRESIDENTE COMUNA')
      .get();
  List<Habitante> habitante = [];
  snapshot.docs.forEach((doc) {
    habitante.add(Habitante.fromMap(doc.data()));
  });
  return habitante;
}

////////////////////////////////////////////////////////////////////////////////////////
class Rows extends StatelessWidget {
  final String text;

  Rows({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(child: CircularProgressIndicator());
        }

        List<Habitante> habitantes = snapshot.data as List<Habitante>;
        if (habitantes == null || habitantes.isEmpty) {
          return Text("No hay ningun habitante registrado");
        }

        if (text.isNotEmpty) {
          var t = text.toLowerCase();
          habitantes = habitantes
              .where((h) => h.nombres.contains(t) || h.apellidos.contains(t))
              .toList();
        }

        return ListView.builder(
            itemCount: habitantes.length,
            itemBuilder:  (BuildContext context, int index) {
              var h = habitantes[index];
              return TextButton(
                 onPressed: () {
                  modificar(context, h.id);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor:Color(0xff04b554),
                            child: Icon(Icons.person),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NOMBRE: '+
                             h.nombres + " " + h.apellidos
                            ),
                            Text('EMAIL: '+h.email),
                            Text('TELEFONO: '+h.telefono),
                            Text('EDAD: '+h.edad)
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
            
      },
    );
  }
}

void modificar(context, String id) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Modificar Rol'),
            content: Text('Estas Seguro que deseas modificar el Habitante'),
            actions: [
              TextButton(
                onPressed: () {
                  //crear en colleccion
                  final docHabitante = FirebaseFirestore.instance
                      .collection("Habitantes")
                      .doc(id);
                  //crear el documento y escribir en Firebae
                  docHabitante
                      .update({'rRol': 'PRESIDENTE COMUNA'})
                      .then((value) => {
                            Fluttertoast.showToast(msg: "Modificado"),
                          })
                      .catchError((e) {
                        Fluttertoast.showToast(msg: e!.message);
                      });

                  //mapeo

                  Navigator.pop(context);
                },
                child: Text(
                  'Modificar',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ));
}
