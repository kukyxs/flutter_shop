import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/provides/cart_count_provide.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:flutter_shop/provides/home_provide.dart';
import 'package:flutter_shop/provides/page_index_provide.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_shop/shop_app.dart';
import 'package:provide/provide.dart';

import 'provides/goods_detail_provide.dart';
import 'provides/mall_goods_provide.dart';
import 'provides/sub_category_provide.dart';
import 'package:jpush_flutter/jpush_flutter.dart';

void main() {
  final providers = Providers()
    ..provide(Provider.function((_) => HomeProvide())) // 主页面
    ..provide(Provider.function((_) => PageIndexProvide())) // 主页面 tab 切换
    ..provide(Provider.function((_) => CartCountProvide())) // 详情页面购物车数量修改
    ..provide(Provider.function((_) => SubCategoryProvide())) // 分类页面切换
    ..provide(Provider.function((_) => MallGoodsProvide())) // 分类页面刷新加载
    ..provide(Provider.function((_) => GoodsDetailProvide())) // 商品详情页面
    ..provide(Provider.function((_) => CartProvide())); // 购物车持久化

  final Router router = Router();
  Routers.configureRouters(router);
  Application.router = router;

  final JPush push = JPush();
  Application.jPush = push;
  setUpJPush(push);

  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(ProviderNode(child: ShopApp(), providers: providers));

    // android 下透明状态栏
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    }
  });
}

setUpJPush(JPush jPush) {
  jPush.addEventHandler(onReceiveNotification: (Map<String, dynamic> message) async {
    print("flutter onReceiveNotification: $message");
  }, onOpenNotification: (Map<String, dynamic> message) async {
    print("flutter onOpenNotification: $message");
  }, onReceiveMessage: (Map<String, dynamic> message) async {
    print("flutter onReceiveMessage: $message");
  });

  jPush.setup(appKey: '696247cca94724deaab1cae5', channel: 'shop_dev', production: false, debug: true);
  jPush.getRegistrationID().then((rid) {
    print('jpush rid: $rid');
  });
}
