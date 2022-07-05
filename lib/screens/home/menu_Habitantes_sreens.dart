import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/Administrador/GestionPresidentes/addPC_screens.dart';
import 'package:optimijac/screens/Administrador/GestionarComunas/Consulta_comunas_screens.dart';
import 'package:optimijac/screens/Habitante/Gestionar%20Solicitud/gestionSolicitud.dart';
import 'package:optimijac/screens/Habitante/GestionarComunas/consultaComunas.dart';

import '../login/login_screens.dart';
import 'drawer_header.dart';

class Menu_Habitante extends StatefulWidget {
  final String email, rolIdentificado;
  Menu_Habitante(this.email, this.rolIdentificado, {Key? key})
      : super(key: key);

  @override
  State<Menu_Habitante> createState() => _Menu_HabitanteState();
}

class _Menu_HabitanteState extends State<Menu_Habitante> {
  String auxx = '';
  final _auth = FirebaseAuth.instance;
  var currentPage = DrawerSections.consultarComunas;

  @override
  void initState() {
    obtenerIdHabitante(widget.email);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var container;
    if (currentPage == DrawerSections.consultarComunas) {
      print('llego: ' + auxx);
      container = consultaComunas(auxx);
    } else if (currentPage == DrawerSections.addPC_screens) {
      container = addPC();
    } else if (currentPage == DrawerSections.addPC_screens) {
       print('llego: ' + auxx);
      container = gestionSolicitud(auxx);
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
          menuItem(1, "Consultar Comunas", Icons.house_rounded,
              currentPage == DrawerSections.consultarComunas ? true : false),
          menuItem(2, "Gestionar PQRS", Icons.person_search,
              currentPage == DrawerSections.addPC_screens ? true : false),
          menuItem(3, "Gestionar Solicitud", Icons.person_search,
              currentPage == DrawerSections.solicitudConsultar ? true : false),
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
              currentPage = DrawerSections.consultarComunas;
            } else if (id == 2) {
              currentPage = DrawerSections.addPC_screens;
            } else if (id == 3) {
              currentPage = DrawerSections.solicitudConsultar;
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
  void obtenerIdHabitante(var email) async {
    String pCId = '';
    await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        pCId = documentData['id'];
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

enum DrawerSections { consultarComunas, addPC_screens,solicitudConsultar }
