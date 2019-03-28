import 'package:flutter/material.dart';

import '../entities/category_goods.dart';

class MallGoodsProvide with ChangeNotifier {
  var _page = 1;

  List<CategoryGoodsInfo> _goodsList = [];

  List<CategoryGoodsInfo> get goodList => _goodsList;

  int get page => _page;

  void increasePage() {
    _page++;
  }

  void initialPage() {
    _page = 1;
  }

  void changeGoodsList(List<CategoryGoodsInfo> list) {
    _goodsList.clear();
    _goodsList.addAll(list);
    notifyListeners();
  }

  void loadMoreGoodsList(List<CategoryGoodsInfo> list) {
    _goodsList.addAll(list);
    notifyListeners();
  }
}
