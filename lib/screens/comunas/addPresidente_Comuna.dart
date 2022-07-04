import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/comunas/comunas_screens.dart';

class AddPresidenteComuna extends StatefulWidget {
  final String docId;
  AddPresidenteComuna(
    this.docId, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddPresidenteComuna> createState() => _AddPresidenteComuna();
}

class _AddPresidenteComuna extends State<AddPresidenteComuna> {
  //Variables

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
      body: Container(

          //Texto
          padding: EdgeInsets.only(top: 20),
          child: Center(
              //Texto
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Habitantes')
                      .where('rRol', isEqualTo: 'PRESIDENTE COMUNA')
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
                            onTap: () {
                              asignarPresidente(context, widget.docId,
                                  snapshot.data!.docs[index]['id']);
                              //Navigator.pop(context); 
                            },
                            title: Text(snapshot.data!.docs[index]['nombres'] +
                                " " +
                                snapshot.data!.docs[index]['apellidos']),
                            leading: CircleAvatar(
                              child: Text(snapshot.data!.docs[index]['nombres']
                                  .substring(0, 1)),
                            ),
                          );
                        });
                  }))),
    );
    //Texto
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
}

void asignarPresidente(context, String id, String idPresidente) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Asignar presidente'),
            content: Text('Esta Seguro que desea asignar este presidente?'),
            actions: [
              TextButton(
                onPressed: () {
                  //crear en colleccion
                  final docHabitante =
                      FirebaseFirestore.instance.collection("comunas").doc(id);
                  //crear el documento y escribir en Firebae
                  docHabitante
                      .update({'presidenteComunaId': idPresidente})
                      .then((value) => {
                            Fluttertoast.showToast(msg: "Asignado"),
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
