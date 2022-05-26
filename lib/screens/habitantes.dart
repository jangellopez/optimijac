import 'package:firebase_auth/firebase_auth.dart';
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
        child: Column(
          children: <Widget>[
            Text(
              'Habitantes',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 48),
            ),
            SizedBox(height: 20),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff04b554),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    //Navigator.push(context,MaterialPageRoute(builder: (context) => Menu()));
                    //logOut();
                  },
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        'LogOut',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }


}
