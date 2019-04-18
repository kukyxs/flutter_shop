import 'package:flutter/material.dart';

import '../entities/goods_detail.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel _detail; // 商品详情
  int _detailIndex; // 详情页的 tabIndex

  GoodsDetailModel get detail => _detail;

  int get detailIndex => _detailIndex;

  changeDetails(GoodsDetailModel detail) {
    _detail = detail;
    notifyListeners();
  }

  changeIndex(int index) {
    _detailIndex = index;
    notifyListeners();
  }
}
