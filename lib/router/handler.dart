import 'package:fluro/fluro.dart';
import 'package:flutter_shop/pages/details_page.dart';
import 'package:flutter_shop/pages/index_page.dart';

Handler rootHandler = new Handler(handlerFunc: (_, params) => IndexPage());

Handler detailHandler = new Handler(handlerFunc: (context, param) {
  String goodsId = param['id']?.first;
  return DetailsPage(goodsId: goodsId);
});
