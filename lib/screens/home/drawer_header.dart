import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff04b554),
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/300'),
              ),
            ),
          ),
          Text(
            "nombre usuario",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            "2022",
            style: TextStyle(
              color: Colors.grey[200],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}