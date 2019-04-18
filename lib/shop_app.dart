import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Shop',
        theme: ThemeData(primaryColor: Colors.pink),
      ),
    );
  }
}
