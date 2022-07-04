import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Habitantes extends StatefulWidget {
  Habitantes({Key? key}) : super(key: key);

  @override
  State<Habitantes> createState() => _HabitantesState();
}

class _HabitantesState extends State<Habitantes> {
  final _auth = FirebaseAuth.instance;
  //lista de habitanes
  List<Habitantes> habitantes = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Habitantes')
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onLongPress: () {
                                eliminarHabitante(
                                    context,
                                    snapshot.data!.docs[index]['id'],
                                    snapshot.data!.docs[index]['nombres'],
                                    snapshot.data!.docs[index]['email']);
                              },
                              title: Text(snapshot.data!.docs[index]
                                      ['nombres'] +
                                  " " +
                                  snapshot.data!.docs[index]['apellidos']),
                              leading: CircleAvatar(
                                child: Text(snapshot
                                    .data!.docs[index]['nombres']
                                    .substring(0, 1)),
                              ),
                            );
                          }
                          );
                    }))));
  }

  void eliminarHabitante(context, var id, var nombre, var email) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar Habitante'),
              content: Text(
                  'Estas Seguro que deseas eliminar el Habitante $nombre?'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      final docHabitantes = FirebaseFirestore.instance
                          .collection("Habitantes")
                          .doc(id);
                      if (email != _auth.currentUser!.email.toString()) {
                        docHabitantes.delete();
                        Fluttertoast.showToast(msg: "Habitante Eliminado");
                      } else {
                        Fluttertoast.showToast(
                            msg: "No delete auth current user");
                      }

                      //mapeo

                      Navigator.pop(context);
                    });
                  },
                  child: Text(
                    'Eliminar',
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
}
