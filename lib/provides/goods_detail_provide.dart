import 'package:flutter/material.dart';

import '../entities/goods_detail_entity.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailEntity _detail; // 商品详情
  int _detailIndex; // 详情页的 tabIndex

  GoodsDetailEntity get detail => _detail;

  int get detailIndex => _detailIndex;

  changeDetails(GoodsDetailEntity detail) {
    _detail = detail;
    notifyListeners();
  }

  changeIndex(int index) {
    _detailIndex = index;
    notifyListeners();
  }
}
