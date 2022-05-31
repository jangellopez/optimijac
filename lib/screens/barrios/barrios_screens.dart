import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'barrios_adicionar_screens.dart';

class Barrios extends StatefulWidget {
  Barrios({Key? key}) : super(key: key);

  @override
  State<Barrios> createState() => _BarriosState();
}

class _BarriosState extends State<Barrios> {
  String docId = '';

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot ds;

    return Scaffold(
      body: Container(

          //Texto
          padding: EdgeInsets.only(top: 20),
          child: Center(
            //Texto

            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('Barrios').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 4.0),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ds = snapshot.data!.docs[index];
                      docId = ds.id;

                      return GestureDetector(
                        onLongPress: () {
                          eliminarBarrio(snapshot.data!.docs[index]['id']);
                        },
                        child: _buildCard(
                            snapshot.data!.docs[index]['nombre'],
                            snapshot.data!.docs[index]['numeroHabitantes'],
                            index + 1),
                      );
                    });
              },
            ),
          )),

      //Boton flotante
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  //llamar el add barrio
                  AdicionarBarrios(), //Llamar la Vista TextoEjercicio
            ),
          ).then((resultado) {
            //metodo agregar del Firebase
            setState(() {});
          });
        },
        backgroundColor: Color(0xff04b554),
        child: Icon(Icons.add),
      ),
    );
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
