import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:optimijac/screens/home/menu_Habitantes_sreens.dart';
import 'package:optimijac/screens/home/menu_MiembroJ_sreens.dart';
import 'package:optimijac/screens/home/menu_PJ_sreens.dart';
import 'package:optimijac/screens/login/register_screens.dart';
import 'package:optimijac/screens/home/menu_Admin_sreens.dart';
import 'package:optimijac/shared/widget_Share.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //Controller
  TextEditingController _usuarioTextoController = TextEditingController();
  TextEditingController _passwordTextoController = TextEditingController();
  TextEditingController _rolController = TextEditingController();
  //VisiblePassword
  bool _isObscure = true;
  String rolIdentificado = '';
  // Firebase
  final _auth = FirebaseAuth.instance;
  //Key formulario
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  //imagenes
                  logoWidget("assets/images/logoverde144.png"),
                  SizedBox(height: 10),
                  //Texto
                  Text(
                    'OptimiJAC',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 48),
                  ),
                  SizedBox(height: 25),
                  //Texto User
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          cursorColor: Color(0xff04b554),
                          decoration: InputDecoration(
                              icon: Icon(Icons.person_rounded,
                                  color: Color(0xff04b554)),
                              border: InputBorder.none,
                              fillColor: Color(0xff04b554),
                              hintText: 'Usuario'),
                          controller: _usuarioTextoController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese su email.");
                            }
                            //Expression regulares para el email
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9+_.-]+.[a-z]")
                                .hasMatch(value)) {
                              return ("Por Favor, Ingrese un email valido.");
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  //Texto Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade200, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                        child: TextFormField(
                          cursorColor: Color(0xff04b554),
                          obscureText: _isObscure,
                          controller: _passwordTextoController,
                          validator: (value) {
                            RegExp regExp = new RegExp(r'^.{6,}$');
                            if (value!.isEmpty) {
                              return ("Por Favor, Ingrese su contrase??a.");
                            }
                            //Expression regulares para el email
                            if (!regExp.hasMatch(value)) {
                              return ("Por Favor, Ingrese un contrase??a valida. (Min. 6 Caracteres)");
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Color(0xff04b554)),
                              suffixIcon: IconButton(
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                      _isObscure
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Color(0xff04b554)),
                                  onPressed: () {
                                    setState(() {
                                      _isObscure = !_isObscure;
                                    });
                                  }),
                              border: InputBorder.none,
                              fillColor: Color(0xff04b554),
                              hintText: 'Contrase??a'),
                        ),
                      ),
                    ),
                  ),
                  //Boton
                  SizedBox(height: 20),
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            primary: Color(0xff04b554),
                            padding: EdgeInsets.all(20)),
                        onPressed: () {
                          //Navigator.push(context,MaterialPageRoute(builder: (context) => Menu()));
                          singIn(_usuarioTextoController.text,
                              _passwordTextoController.text);
                        },
                        child: Container(
                          decoration: BoxDecoration(
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
                      )),
                  //link de ingresar a crear cuenta
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'No est??s registrado? ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder: (BuildContext context, animation1,
                                        animation2) =>
                                    Register(),
                                transitionDuration: Duration.zero,
                              ));
                        },
                        child: Text(
                          'Crea una cuenta',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Color(0xff04b554),
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//Login Funcion

  void singIn(String email, String password) async {
    String rRol = '';
    await FirebaseFirestore.instance
        .collection('Habitantes')
        .where('email', isEqualTo: email)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        Map<String, dynamic> documentData = value.docs.single.data();
        rRol = documentData['rRol'];
      }
    });

    print('rol identificado: ' + rRol);
    if (_formKey.currentState!.validate()) {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => {
                Fluttertoast.showToast(msg: "Login Successfull"),
                print('Envio: ' + rRol),
                if (rRol == 'HABITANTE')
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Menu_Habitante(email, rRol))),
                  }
                ////////////////////////////////////////////////////////
                else if (rRol == 'ADMINISTRADOR')
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Menu_Admin(email, rRol))),
                  }
                ////////////////////////////////////////////////////////
                else if (rRol == 'PRESIDENTE COMUNA')
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Menu_PJ(email, rRol))),
                  }
                ////////////////////////////////////////////////////////
                else if (rRol == 'MIEMBRO JAC')
                  {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => Menu_Miembro(email, rRol))),
                  }
              })
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
