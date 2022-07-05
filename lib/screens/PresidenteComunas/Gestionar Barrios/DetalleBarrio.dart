
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:optimijac/screens/PresidenteComunas/Gestionar%20Juntas/JuntaAccionComunal_Screens.dart';

class DetalleBarrio extends StatefulWidget {
  final String comunaId, barrioId;
  DetalleBarrio(this.comunaId, this.barrioId, {Key? key}) : super(key: key);

  @override
  State<DetalleBarrio> createState() => _DetalleBarrioState();
}

class _DetalleBarrioState extends State<DetalleBarrio> {
  String docId = '';
  bool IsVisibleJunta = false;
  bool IsVisibleButton = false;
  String nombreDos = '', documentIdPresident = '';
  @override
  void initState() {
    verificarPresidente(widget.barrioId);
    getComunaDocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot ds;
    print('id barrio: ' + widget.barrioId);
    print('id comuna: ' + widget.comunaId);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff04b554),
          centerTitle: true,
          title: Text(
            'Optimijac',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.only(top: 20),
          child: Center(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Barrios')
                  .where('id', isEqualTo: widget.barrioId)
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                          height: 200,
                          child: Row(children: <Widget>[
                            Container(
                              child: Container(
                                child:
                                    const Text(" JUNTA DE ACCION COMUNAL:  "),
                              ),
                            ),
                            Visibility(
                                visible: IsVisibleJunta,
                                child: Text('   ' + nombreDos)),
                            Visibility(
                              visible: IsVisibleButton == true,
                              child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: ElevatedButton(
                                    //decorar
                                    child: Icon(Icons.add),
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xff04b554),
                                    ),
                                    //accion

                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              //llamar el add

                                              addJac(widget.barrioId), //Llamar la Vista TextoEjercicio
                                        ),
                                      ).then((resultado) {
                                        //metodo agregar del Firebase
                                        setState(() {});
                                      });
                                    },
                                  )),
                            ),
                          ])), //Row 1/2
                      SizedBox(height: 10),
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

                              return Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                         SizedBox(height: 10),
                                        Expanded(
                                          child: 
                                        Text('ID: ' +
                                            snapshot.data!.docs[index]['id']),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: Text('NOMBRE: ' +
                                              snapshot.data!.docs[index]
                                                  ['nombre']),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: Text('NUMERO HABITANTES: ' +
                                              snapshot.data!.docs[index]
                                                  ['numeroHabitantes']),
                                        ),
                                        SizedBox(height: 10),
                                        Expanded(
                                          child: Text('COMUNA: ' +
                                              snapshot.data!.docs[index]
                                                  ['comunaId']),
                                        )
 
                                      ],
                                    )
                                  ],
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }

  void verificarPresidente(var barrioId) async {
    String pCId = '';
    await FirebaseFirestore.instance
        .collection('Barrios')
        .where('id', isEqualTo: barrioId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        pCId = documentData['juntaId'];
      }
      print('pcid: '+pCId);
    });

  //
    String nombre = '';
    await FirebaseFirestore.instance
        .collection('Junta')
        .where('id', isEqualTo: pCId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        nombre = documentData['nombre'];
      }
      print('nombre: '+nombre);
    });
    nombreDos = nombre;
    if (pCId == '') {
      setState(() {
        IsVisibleButton = true;
      });
    } else {
      setState(() {
        IsVisibleJunta = true;
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

}
