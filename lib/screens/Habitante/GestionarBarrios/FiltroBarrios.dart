import 'dart:html';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/models/solicitud_model.dart';
import 'package:optimijac/screens/Administrador/GestionarComunas/addPresidente_Comuna.dart';

class FiltroBarrios extends StatefulWidget {
  final String comunaId,idHabitante;
  FiltroBarrios(this.idHabitante,this.comunaId, {Key? key}) : super(key: key);

  @override
  State<FiltroBarrios> createState() => _FiltroBarriosState();
}

class _FiltroBarriosState extends State<FiltroBarrios> {
  String docId = '';
  bool IsVisiblePresident = false;
  bool IsVisibleButton = false;
  String nombreDos = '', documentIdPresident = '';
  @override
  void initState() {
    verificarPresidente(widget.comunaId);
    getComunaDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot ds;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff04b554),
          centerTitle: true,
          title: Text(
            'Optimijac',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Barrios')
                  .where('comunaId', isEqualTo: widget.comunaId)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 2.0,
                                  mainAxisSpacing: 4.0),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ds = snapshot.data!.docs[index];
                            docId = ds.id;

                            return GestureDetector(
                              onTap: () {
                                crearSolicitud(
                                    context,
                                    widget.idHabitante,
                                    widget.comunaId,
                                    snapshot.data!.docs[index]['id']);
                              },
                              child: _buildCard(
                                  snapshot.data!.docs[index]['nombre'],
                                  snapshot.data!.docs[index]
                                      ['numeroHabitantes'],
                                  index + 1),
                            );
                          }),
                    ),
                  ],
                );
              },
            ),
          )),
    );
  }

  void verificarPresidente(var comunaId) async {
    String pCId = '';
    await FirebaseFirestore.instance
        .collection('comunas')
        .where('comunaId', isEqualTo: comunaId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        pCId = documentData['presidenteComunaId'];
      }
      print(pCId);
    });

    //
    String nombre = '';
    await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('id', isEqualTo: pCId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        nombre = documentData['nombres'] + ' ' + documentData['apellidos'];
      }
      print(nombre);
    });
    nombreDos = nombre;
    if (pCId == '') {
      setState(() {
        IsVisibleButton = true;
      });
    } else {
      setState(() {
        IsVisiblePresident = true;
      });
    }
  }

  void getComunaDocId() async {
    final ref = await FirebaseFirestore.instance
        .collection('comunas')
        .where('comunaId', isEqualTo: widget.comunaId)
        .get();
    setState(() {
      documentIdPresident = ref.docs[0].id;
    });
  }

  Widget _buildCard(var nombre, var numeroHabitantes, int cardIndex) {
    return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 80.0,
              width: 80.0,
              child: FittedBox(
                child: Icon(
                  Icons.business_rounded,
                ),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              nombre,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              'Habitantes: ' + numeroHabitantes,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
          ],
        ),
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }

  void eliminarBarrio(var id) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar Barrios'),
              content: Column(
                children: [
                  Text('Estas Seguro que deseas eliminar el barrio?'),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      final docBarrio = FirebaseFirestore.instance
                          .collection("Barrios")
                          .doc(docId);

                      //mapeo
                      docBarrio.delete();
                      Fluttertoast.showToast(msg: "Barrio Eliminado");
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

void crearSolicitud(
    context, String idhabitante, String idComuna, String idbarrio) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Asignar presidente'),
            content:
                Text('Esta Seguro que desea solicitar unirse este barrio?'),
            actions: [
              TextButton(
                onPressed: () {
                  final docsolicitud =
                      FirebaseFirestore.instance.collection("Solicitud").doc();
                  //mapeo
                  final solicitud = Solicitud(
                      id: docsolicitud.id,
                      comunaId: idComuna,
                      barrioId: idbarrio,
                      habitanteId: idhabitante);
                  final json = solicitud.toJson();

                  //crear el documento y escribir en Firebae
                  docsolicitud.set(json);
   Fluttertoast.showToast(msg: "Solicitud Enviada");
                  Navigator.pop(context);
                },
                child: Text(
                  'unirse',
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
