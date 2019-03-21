import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:provide/provide.dart';
import 'provides/sub_category_provide.dart';
import 'provides/mall_goods_provide.dart';

void main() {
  final providers = Providers()
    ..provide(Provider.function((_) => SubCategoryProvide()))
    ..provide(Provider.function((_) => MallGoodsProvide()));

  runApp(ProviderNode(child: ShopApp(), providers: providers));
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Shop',
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}
