import 'package:flutter/material.dart';

class MemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 40.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.pink[300], Colors.blue[100]], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: Column(
        children: <Widget>[
          ClipOval(
            child: Image.asset('images/avatar.jpg', width: 100.0, height: 100.0),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Kuky_xs', style: TextStyle(color: Colors.black, fontSize: 18.0)),
          )
        ],
      ),
    );
  }
}
