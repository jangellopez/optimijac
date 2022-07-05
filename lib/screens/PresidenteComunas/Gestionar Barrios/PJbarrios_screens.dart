import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/PresidenteComunas/Gestionar%20Barrios/DetalleBarrio.dart';
import 'package:optimijac/screens/PresidenteComunas/Gestionar%20Barrios/barrios_adicionar_screens.dart';

class ConsultarBarrios extends StatefulWidget {
  final String idComuna;
  ConsultarBarrios(this.idComuna, {Key? key}) : super(key: key);

  @override
  State<ConsultarBarrios> createState() => _ConsultarBarriosState();
}

class _ConsultarBarriosState extends State<ConsultarBarrios> {
  String docId = '', idBarrio='';
  String nombreDos = '', documentIdPresident = '';
  @override
  void initState() {
    verificarPresidente(widget.idComuna);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

          //Texto
          padding: EdgeInsets.only(top: 20),
          child: Center(
            //Texto

            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('Barrios')
                  .where('comunaId', isEqualTo: widget.idComuna)
                  .snapshots(),
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
                          idBarrio = snapshot.data!.docs[index]['id'];

                           Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetalleBarrio(widget.idComuna, idBarrio))); 
                        },
                        onLongPress: () {},
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
                  AdicionarBarrios(widget.idComuna), //Llamar la Vista TextoEjercicio
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

  void eliminarBarrio(context, var id, var nombre) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Eliminar Barrios'),
              content:
                  Text('Estas Seguro que deseas eliminar el barrio $nombre?'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      final docBarrio = FirebaseFirestore.instance
                          .collection("Barrios")
                          .doc(id);

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

  void verificarPresidente(var comunaId) async {
    String pCId = '';
    await FirebaseFirestore.instance
        .collection('comunas')
        .where('comunaId', isEqualTo: comunaId)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        pCId = documentData['presidenteComunaId'];
      }
      print(pCId);
    });
  }

  void getBarrioId(String id) async {
    final ref = await FirebaseFirestore.instance
        .collection('Barrios')
        .where('comunaId', isEqualTo: widget.idComuna)
        .get();
    setState(() {
      documentIdPresident = ref.docs[0].id;
    });
  }
}
