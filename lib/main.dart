import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'configs/application.dart';
import 'provides/mall_goods_provide.dart';
import 'provides/sub_category_provide.dart';
import 'router/routers.dart';

void main() {
  final providers = Providers()
    ..provide(Provider.function((_) => SubCategoryProvide()))
    ..provide(Provider.function((_) => MallGoodsProvide()));

  runApp(ProviderNode(child: ShopApp(), providers: providers));
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
