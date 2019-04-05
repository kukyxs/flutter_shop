import 'package:flutter/material.dart';
import '../entities/goods_detail.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel _detail;
  int _detailIndex;

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
