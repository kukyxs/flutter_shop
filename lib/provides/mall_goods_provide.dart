import 'package:flutter/material.dart';

import '../entities/category_goods.dart';

class MallGoodsProvide with ChangeNotifier {
  List<CategoryGoodsInfo> _goodsList = [];

  List<CategoryGoodsInfo> get goodList => _goodsList;

  void changeGoodsList(List<CategoryGoodsInfo> list) {
    _goodsList.clear();
    _goodsList.addAll(list);
    notifyListeners();
  }
}
