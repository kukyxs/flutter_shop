import 'package:flutter/material.dart';

class MemTile extends StatelessWidget {
  final IconData leading;
  final String title;
  final VoidCallback action;

  MemTile({Key key, this.leading, this.title, this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(leading),
      title: Text(title, style: TextStyle(color: Colors.black, fontSize: 16.0)),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: action,
    );
  }
}
