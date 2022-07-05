import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/PresidenteComunas/Gestionar%20Barrios/PJbarrios_screens.dart';
import 'package:optimijac/screens/PresidenteComunas/Gestionar%20Juntas/ConsultaJuntas.dart';

import '../login/login_screens.dart';
import 'drawer_header.dart';

class Menu_PJ extends StatefulWidget {
  final String email, rolIdentificado;
  Menu_PJ(this.email, this.rolIdentificado, {Key? key}) : super(key: key);

  @override
  State<Menu_PJ> createState() => _Menu_PJState();
}

class _Menu_PJState extends State<Menu_PJ> {
  String auxx = '';
  final _auth = FirebaseAuth.instance;
  TextEditingController id = TextEditingController();
  var currentPage = DrawerSections.filtroBarrios;
 @override
  void initState() {
     obtenerIdComuna(widget.email);

    super.initState();
  }

//////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.filtroBarrios) {
     
      print('llego: ' + auxx);
      container = ConsultarBarrios(auxx);
    } else if (currentPage == DrawerSections.filtroJac) {
      container = ConsultaJuntas();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff04b554),
        centerTitle: true,
        title: Text(
          'Optimijac',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: IconButton(
                onPressed: () {
                  _signOut();
                },
                icon: Icon(Icons.logout_rounded)),
          )
        ],
      ),
      body: container,
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [HeaderDrawer(widget.email), drawerList()],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerList() {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Gestionar Barrios", Icons.house_rounded,
              currentPage == DrawerSections.filtroBarrios ? true : false),
          menuItem(2, "Gestionar Juntas", Icons.person_search,
              currentPage == DrawerSections.filtroJac ? true : false),
        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.filtroBarrios;
            } else if (id == 2) {
              currentPage = DrawerSections.filtroJac;
            }
          });
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.black,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _signOut() async {
    Fluttertoast.showToast(msg: "Logout Successfull");
    await _auth.signOut().then((value) => Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => Login())));
  }

  ///////////////////////////////////////////////
  void obtenerIdComuna(var email) async {
    String pCId = '';
    await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        pCId = documentData['comunaId'];
      }
    });

    if (pCId == '') {
      setState(() {
        auxx = '';
      });
    } else {
      setState(() {
        auxx = pCId;
      });
    }
  }
}

enum DrawerSections { filtroBarrios, filtroJac }
