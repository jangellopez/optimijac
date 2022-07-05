import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/models/habitantes_model.dart';

import '../../../models/junta_model.dart';

class ConsultaJuntas extends StatefulWidget {
  ConsultaJuntas({Key? key}) : super(key: key);

  @override
  State<ConsultaJuntas> createState() => _ConsultaJuntasState();
}

class _ConsultaJuntasState extends State<ConsultaJuntas> {
  final _auth = FirebaseAuth.instance;
  TextEditingController _searchview = TextEditingController();
  //lista de habitanes
  List<ConsultaJuntas> habitantes = [];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            child: new Center(
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('Junta')
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
Future<List<Junta>> getAll() async {
  var snapshot = await FirebaseFirestore.instance.collection('Junta').get();
  List<Junta> junta = [];
  snapshot.docs.forEach((doc) {
    junta.add(Junta.fromMap(doc.data()));
  });
  return junta;
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

        List<Junta> junta = snapshot.data as List<Junta>;
        if (junta == null || junta.isEmpty) {
          return Text("No hay ningun Junta registrado");
        }

        if (text.isNotEmpty) {
          var t = text.toLowerCase();
          junta = junta.where((h) => h.nombre.contains(t)).toList();
        }

        return ListView.builder(
            itemCount: junta.length,
            itemBuilder: (BuildContext context, int index) {
              var h = junta[index];
              return TextButton(
                onPressed: () {},
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff04b554),
                            child: Icon(Icons.holiday_village),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NOMBRE: ' + h.nombre),
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
