import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:provide/provide.dart';

import 'configs/application.dart';
import 'provides/goods_detail_provide.dart';
import 'provides/mall_goods_provide.dart';
import 'provides/sub_category_provide.dart';
import 'router/routers.dart';

void main() {
  final providers = Providers()
    ..provide(Provider.function((_) => SubCategoryProvide()))
    ..provide(Provider.function((_) => MallGoodsProvide()))
    ..provide(Provider.function((_) => GoodsDetailProvide()))
    ..provide(Provider.function((_) => CartProvide()));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(ProviderNode(child: ShopApp(), providers: providers));

    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  });
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Router router = Router();
    Routers.configureRouters(router);
    Application.router = router;

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
