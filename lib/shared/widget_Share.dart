import 'package:flutter/material.dart';

//Reutilizable de Foto para llamarlo y solo enviarle Foto
Image logoWidget(String imageNane) {
  return Image.asset(imageNane);
}

TextField textoWidget(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Color(0xff04b554),

    decoration: InputDecoration(
      //icono
      prefixIcon: Icon(
        icon,
        color: Color(0xff04b554),
      ),
      //TEXTO
      labelText: text,
      fillColor: Color(0xff04b554),
      //Border
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(width: 1.5, style: BorderStyle.none)),
    ), // Input Decoration
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  ); // TextField
}

//Alerta
Future<dynamic> alertaWidget(BuildContext context, String mensaje) {
  return showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('¡ALERTA!'),
            content: Text(mensaje.toString()),
          ));
}

//Textos principales
Text textowigetShared(String texto) {
  return Text(
    texto,
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 32),
  );
}
