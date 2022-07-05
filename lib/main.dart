import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:optimijac/screens/login/editar_perfil.dart';
import 'package:optimijac/screens/login/login_screens.dart';
import 'package:optimijac/screens/login/register_screens.dart';
//flutter run -d chrome --web-renderer html
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDlaLNftby2f3oySIPTJo7OG5UoJCzpHvw",
      appId: "1:827456482415:android:db772536ed2cefb181b19a",
      messagingSenderId: "827456482415",
      projectId: "optimijac",
      storageBucket: "optimijac.appspot.com"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Optimijac',
      theme: ThemeData(fontFamily: GoogleFonts.rubik().fontFamily),
      home: Login(),
    );
  }
}
