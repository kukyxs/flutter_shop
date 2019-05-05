import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/deatilspage/details_page.dart';
import 'package:flutter_shop/pages/index_page.dart';
import 'package:flutter_shop/pages/map_page.dart';
import 'package:flutter_shop/pages/settings_page.dart';

Handler rootHandler = new Handler(handlerFunc: (_, params) => IndexPage());

Handler detailHandler = new Handler(handlerFunc: (context, param) {
  String goodsId = param['id']?.first;
  return DetailsPage(goodsId: goodsId);
});

Handler mapHandler = new Handler(handlerFunc: (_, param) => MapPage());

Handler settingHandler = new Handler(handlerFunc: (_, param) => SettingsPage());
