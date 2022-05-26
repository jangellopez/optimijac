import 'package:flutter/material.dart';
import 'package:optimijac/models/comuna_model.dart';

class Comunas extends StatefulWidget {
  Comunas({Key? key}) : super(key: key);

  @override
  State<Comunas> createState() => _ComunasState();
}

class _ComunasState extends State<Comunas> {
  List _listaComunas = comuna;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Center(
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 4.0),
            itemCount: _listaComunas.length,
            itemBuilder: (context, index) {
              return _buildCard(_listaComunas[index].nombre,
                  _listaComunas[index].numeroBarrios, index + 1);
            }),
      ),
    );
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
            Text('Barrios: ' +
              numeroBarrios,
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
