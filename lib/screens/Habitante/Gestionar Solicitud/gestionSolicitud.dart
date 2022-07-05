import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/models/solicitud_model.dart';

class gestionSolicitud extends StatefulWidget {
  final String idHabitante;
  gestionSolicitud(this.idHabitante, {Key? key}) : super(key: key);

  @override
  State<gestionSolicitud> createState() => _gestionSolicitudState();
}

String varGlobal = '';

class _gestionSolicitudState extends State<gestionSolicitud> {
final _auth = FirebaseAuth.instance;
  TextEditingController _searchview = TextEditingController();
  //lista de habitanes
  List<gestionSolicitud> habitantes = [];

  @override
  Widget build(BuildContext context) {
    setState(() {
      varGlobal=widget.idHabitante;
    });
    return new Scaffold(
        body: new Container(
            child: new Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Solicitud')
                        .where('habitanteId', isEqualTo: widget.idHabitante)
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
Future<List<Solicitud>> getAll() async {
  var snapshot = await FirebaseFirestore.instance.collection('Solicitud').where('habitanteId', isEqualTo: varGlobal).get();
  List<Solicitud> habitante = [];
  snapshot.docs.forEach((doc) {
    habitante.add(Solicitud.fromMap(doc.data()));
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

        List<Solicitud> habitantes = snapshot.data as List<Solicitud>;
        if (habitantes == null || habitantes.isEmpty) {
          return Text("No hay ninguna solicitud registrado");
        }


        return ListView.builder(
            itemCount: habitantes.length,
            itemBuilder: (BuildContext context, int index) {
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
                            backgroundColor: Color(0xff04b554),
                            child: Icon(Icons.person),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ' + h.id),
                            Text('BARRIO: ' + h.barrioId),
                            Text('COMUNA: ' + h.comunaId),
                            Text('HABITANTE: ' + h.habitanteId)
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
                      .update({'rRol': 'MIEMBRO JAC'})
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
