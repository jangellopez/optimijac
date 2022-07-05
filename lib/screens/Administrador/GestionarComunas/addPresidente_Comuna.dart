import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/models/habitantes_model.dart';

class AddPresidenteComuna extends StatefulWidget {
  final String docId;
  AddPresidenteComuna(
    this.docId, {
    Key? key,
  }) : super(key: key);

  @override
  State<AddPresidenteComuna> createState() => _AddPresidenteComuna();
}

String idcomuna = '';
String auz = '';

class _AddPresidenteComuna extends State<AddPresidenteComuna> {
  //Variables
  TextEditingController _searchview = TextEditingController();
  @override
  Widget build(BuildContext context) {
    auz = widget.docId;
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
                    return Container(
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
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

//obtener todo
Future<List<Habitante>> getAll() async {
  var snapshot = await FirebaseFirestore.instance
      .collection('Habitantes')
      .where('rRol', isEqualTo: 'PRESIDENTE COMUNA')
      .get();
  List<Habitante> habitante = [];
  snapshot.docs.forEach((doc) {
    habitante.add(Habitante.fromMap(doc.data()));
  });
  return habitante;
}

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

        List<Habitante> habitantes = snapshot.data as List<Habitante>;
        if (habitantes == null || habitantes.isEmpty) {
          return Text("No hay ningun habitante registrado");
        }

        if (text.isNotEmpty) {
          var t = text.toLowerCase();
          habitantes = habitantes
              .where((h) => h.nombres.contains(t) || h.apellidos.contains(t))
              .toList();
        }

        return ListView.builder(
            itemCount: habitantes.length,
            itemBuilder: (BuildContext context, int index) {
              var h = habitantes[index];
              return TextButton(
                onPressed: () {
                  asignarPresidente(context, auz, h.id);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            backgroundColor: Color(0xff04b554),
                            child: Icon(Icons.person),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('NOMBRE: ' + h.nombres + " " + h.apellidos),
                            Text('EMAIL: ' + h.email),
                            Text('TELEFONO: ' + h.telefono),
                            Text('EDAD: ' + h.edad)
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

void asignarPresidente(context, String id, String idPresidente) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text('Asignar presidente'),
            content: Text('Esta Seguro que desea asignar este presidente?'),
            actions: [
              TextButton(
                onPressed: () {
                  //COMUNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
                  final docComuna =
                      FirebaseFirestore.instance.collection("comunas").doc(id);
                  //crear el documento y escribir en Firebae
                  docComuna
                      .update({'presidenteComunaId': idPresidente})
                      .then((value) => {
                            Fluttertoast.showToast(msg: "Asignado"),
                          })
                      .catchError((e) {
                        Fluttertoast.showToast(msg: e!.message);
                      });

                  //COMUNAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA ID
                  String pCId = '';
                  final docAxu = FirebaseFirestore.instance
                      .collection('comunas')
                      .doc(id)
                      .get()
                      .then((value) {
                    if (value.exists) {
                      Map<String, dynamic>? documentData = value.data();
                      pCId = documentData!['comunaId'];
                    }

                    idcomuna = pCId;
                    final docHabitante = FirebaseFirestore.instance
                        .collection("Habitantes")
                        .doc(idPresidente);

                    //crear el documento y escribir en Firebae
                    docHabitante
                        .update({'comunaId': idcomuna})
                        .then((value) => {
                              Fluttertoast.showToast(msg: "Perfil Completado"),
                            })
                        .catchError((e) {
                          Fluttertoast.showToast(msg: e!.message);
                        });
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
