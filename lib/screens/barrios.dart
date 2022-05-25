import 'package:flutter/material.dart';

class Barrios extends StatefulWidget {
  Barrios({Key? key}) : super(key: key);

  @override
  State<Barrios> createState() => _BarriosState();
}

class _BarriosState extends State<Barrios> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Barrios page"),
      ),
    );
  }
}
