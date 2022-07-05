import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:optimijac/screens/Habitante%20si/GestionarBarrios/FiltroBarrios.dart';
import 'package:optimijac/screens/barrios/addMiembro_Barrio.dart';
import 'package:optimijac/screens/Administrador/GestionarComunas/FiltroComuna_barrios.dart';

class consultaComunas extends StatefulWidget {
  final String idHabitante;
  consultaComunas(this.idHabitante,{Key? key}) : super(key: key);

  @override
  State<consultaComunas> createState() => _consultaComunasState();
}

class _consultaComunasState extends State<consultaComunas> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Center(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('comunas').snapshots(),
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
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FiltroBarrios(widget.idHabitante,
                                snapshot.data!.docs[index]['comunaId'])));
                      },
                      child: _buildCard(
                          snapshot.data!.docs[index]['nombre'],
                          snapshot.data!.docs[index]['numeroBarrios'],
                          index + 1),
                    );
                  });
            },
          ),
        ));
  }

  Widget _buildCard(var nombre, var numeroBarrios, int cardIndex) {
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
              'Barrios: ' + numeroBarrios,
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
