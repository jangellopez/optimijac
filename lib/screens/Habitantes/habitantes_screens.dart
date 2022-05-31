import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Habitantes extends StatefulWidget {
  Habitantes({Key? key}) : super(key: key);

  @override
  State<Habitantes> createState() => _HabitantesState();
}

class _HabitantesState extends State<Habitantes> {
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
                              onTap: () {
                               
                              },
                              title: Text(snapshot.data!.docs[index]['nombres']+" "+snapshot.data!.docs[index]['apellidos']),
                              leading: CircleAvatar(
                                child: Text(snapshot.data!.docs[index]['nombres']
                                    .substring(0, 1)),
                              ),
                            );
                          });
                    }))));
  }
}
