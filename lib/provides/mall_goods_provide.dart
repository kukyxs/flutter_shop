import 'package:flutter/material.dart';
import 'package:flutter_shop/entities/category_goods_entity.dart';

/// 分类页面商品列表加载
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

  // 更换商品大小类别调用
  void changeGoodsList(List<CategoryGoodsInfo> list) {
    _goodsList.clear();
    _goodsList.addAll(list);
    notifyListeners();
  }

  // 上拉加载更多
  void loadMoreGoodsList(List<CategoryGoodsInfo> list) {
    _goodsList.addAll(list);
    notifyListeners();
  }
}
