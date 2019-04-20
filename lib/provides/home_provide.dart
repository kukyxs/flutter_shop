import 'package:flutter/material.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/entities/hot_goods.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomeProvide with ChangeNotifier {
  HomePageEntity _homeEntity; // 首页显示内容
  List<HotGoodsData> _hotGoodsList = []; // 火爆专区
  int _page = 0;
  bool _showBack = false;

  HomePageEntity get homeEntity => _homeEntity;

  List<HotGoodsData> get hodGoodsList => _hotGoodsList;

  bool get showBack => _showBack;

  initHomeEntity() async {
    _homeEntity = await getHomePageContent();
    notifyListeners();
  }

  initHotGoodsList() async {
    _page = 0;
    var hot = await getHomePageHots(_page);
    _hotGoodsList.clear();
    _hotGoodsList.addAll(hot.data);
    notifyListeners();
  }

  loadMoreHotGoods() async {
    _page++;
    var moreHot = await getHomePageHots(_page);
    _hotGoodsList.addAll(moreHot.data);
    notifyListeners();
  }

  enableBack(bool state) {
    _showBack = state;
    notifyListeners();
  }
}
