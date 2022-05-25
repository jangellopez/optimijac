import 'package:flutter/material.dart';

class Habitantes extends StatefulWidget {
  Habitantes({Key? key}) : super(key: key);

  @override
  State<Habitantes> createState() => _HabitantesState();
}

class _HabitantesState extends State<Habitantes> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("Habitantes page"),
      ),
    );
  }
}