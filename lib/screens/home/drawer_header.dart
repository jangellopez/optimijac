import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  final String email;
  HeaderDrawer(this.email, {Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff04b554),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: getImage(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(snapshot.data.toString()),
                  );
                } else {
                  return CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 30,
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Text(snapshot.data!,
                      style: TextStyle(color: Colors.white, fontSize: 20));
                } else {
                  return Text('');
                }
              }),
          Text(
            '${FirebaseAuth.instance.currentUser!.email}',
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Future<String> getData() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('email', isEqualTo: widget.email)
        .get();

    String nombres = "";
    querySnapshot.docs.forEach(
      (snapshot) {
        nombres += snapshot.data()['nombres'] as String;
      },
    );

    return nombres;
  }

  Future<String> getImage() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('email', isEqualTo: widget.email)
        .get();

    String nombres = "";
    querySnapshot.docs.forEach(
      (snapshot) {
        nombres += snapshot.data()['imageUrl'] as String;
      },
    );

    return nombres;
  }
}
