import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage('assets/images/logoverde144.png')),
          SizedBox(height: 10),
          Text(
            'Optimijac',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 48),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: TextField(
                  cursorColor: Color(0xff04b554),
                  decoration: InputDecoration(
                      icon:
                          Icon(Icons.person_rounded, color: Color(0xff04b554)),
                      border: InputBorder.none,
                      fillColor: Color(0xff04b554),
                      hintText: 'Usuario'),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: TextField(
                  cursorColor: Color(0xff04b554),
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock, color: Color(0xff04b554)),
                      suffixIcon: IconButton(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                          icon: Icon(_isObscure
                              ? Icons.visibility
                              : Icons.visibility_off, color: Color(0xff04b554)),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          }),
                      border: InputBorder.none,
                      fillColor: Color(0xff04b554),
                      hintText: 'Contraseña'),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: Color(0xff04b554),
                  borderRadius: BorderRadius.circular(12)),
              child: Center(
                child: Text(
                  'Ingresar',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No estás registrado? ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                'Crea una cuenta',
                style: TextStyle(
                    color: Color(0xff04b554), fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
