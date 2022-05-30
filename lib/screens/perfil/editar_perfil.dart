import 'package:flutter/material.dart';

class EditarPerfil extends StatefulWidget {
  EditarPerfil({Key? key}) : super(key: key);

  @override
  State<EditarPerfil> createState() => _EditarPerfilState();
}

class _EditarPerfilState extends State<EditarPerfil> {
  String valorTipoId = 'Cedula';
  String valorGenero = 'Masculino';

  var itemsTipoId = ['Cedula', 'Tarjeta identidad'];

  var itemsGenero = ['Masculino', 'Femenino'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Editar perfil',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 32),
              ),
              SizedBox(height: 10),
              Center(
                child: Stack(children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/300'),
                    foregroundColor: Colors.transparent,
                    radius: 70,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 4,
                      child: ClipOval(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          color: Colors.white,
                          child: ClipOval(
                            child: Container(
                              padding: EdgeInsets.all(8),
                              color: Color(0xff04b554),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )),
                ]),
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
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: DropdownButtonFormField<String>(
                      hint: Text('Seleccionar'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Tipo identificacion',
                        labelStyle: TextStyle(
                          color: Color(0xff04b554)
                        )
                      ),
                      borderRadius: BorderRadius.circular(12),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: itemsTipoId.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          valorTipoId = newValue!;
                        });
                      },
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Cedula'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Nombres'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Apellidos'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Fecha de nacimiento'),
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
                    child: DropdownButtonFormField<String>(
                      hint: Text('Seleccionar'),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Genero',
                        labelStyle: TextStyle(
                          color: Color(0xff04b554)
                        )
                      ),
                      borderRadius: BorderRadius.circular(12),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: itemsGenero.map((String items) {
                        return DropdownMenuItem<String>(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          valorGenero = newValue!;
                        });
                      },
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Telefono'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Dirección'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Color(0xff04b554),
                          hintText: 'Correo'),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      cursorColor: Color(0xff04b554),
                      decoration: InputDecoration(
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
                      'Aceptar',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
