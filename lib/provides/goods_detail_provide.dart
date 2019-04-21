import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/service_url.dart';
import 'package:flutter_shop/entities/goods_detail_entity.dart';
import 'package:flutter_shop/service/service_method.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailEntity _detail; // 商品详情
  int _detailIndex; // 详情页的 tabIndex

  GoodsDetailEntity get detail => _detail;

  int get detailIndex => _detailIndex;

  changeDetails(String id) async {
    _detail = await getGoodsDetail(id);
    notifyListeners();
  }

  changeIndex(int index) {
    _detailIndex = index;
    notifyListeners();
  }

  Future<GoodsDetailEntity> getGoodsDetail(String id) async {
    var response = await request(servicePath['getGoodDetailById'], formData: {'goodId': id});
    return GoodsDetailEntity.fromMap(json.decode(response.data));
  }
}
