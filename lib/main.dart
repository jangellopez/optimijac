import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimijac/screens/login/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDlaLNftby2f3oySIPTJo7OG5UoJCzpHvw",
      appId: "1:827456482415:android:db772536ed2cefb181b19a",
      messagingSenderId: "827456482415",
      projectId: "optimijac",
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Optimijac',
      theme: ThemeData(fontFamily: GoogleFonts.rubik().fontFamily),
      home: Login(),
    );
  }
}
