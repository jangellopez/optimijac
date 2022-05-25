import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimijac/screens/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Optimijac',
      theme: ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily
      ),
      home: Login(),
    );
  }
}