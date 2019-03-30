import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;

  DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text(this.goodsId)));
  }
}
