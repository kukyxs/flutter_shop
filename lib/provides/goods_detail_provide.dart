import 'package:flutter/material.dart';
import '../entities/goods_detail.dart';

class GoodsDetailProvide with ChangeNotifier {
  GoodsDetailModel _detail;

  GoodsDetailModel get detail => _detail;

  void changeDetails(GoodsDetailModel detail) {
    _detail = detail;
    notifyListeners();
  }
}
