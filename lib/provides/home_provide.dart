import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/service_url.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/entities/hot_goods_entity.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomeProvide with ChangeNotifier {
  HomePageEntity _homeEntity; // 首页显示内容
  List<HotGoodsData> _hotGoodsList = []; // 火爆专区
  int _page = 0;
  bool _showBack = false;
  String _district = '定位失败';
  double _longitude = 115.02932;
  double _latitude = 35.76189;

  HomePageEntity get homeEntity => _homeEntity;

  List<HotGoodsData> get hodGoodsList => _hotGoodsList;

  bool get showBack => _showBack;

  String get district => _district;

  double get longitude => _longitude;

  double get latitude => _latitude;

  changeDistrict(String value, double longitude, double latitude) {
    _district = value;
    _longitude = longitude;
    _latitude = latitude;
    notifyListeners();
  }

  initHomeEntity(double lon, double lat) async {
    _homeEntity = await _getHomePageContent(lon, lat);
    notifyListeners();
  }

  initHotGoodsList() async {
    _page = 0;
    var hot = await _getHomePageHots(_page);
    _hotGoodsList.clear();
    _hotGoodsList.addAll(hot.data);
    notifyListeners();
  }

  loadMoreHotGoods() async {
    _page++;
    var moreHot = await _getHomePageHots(_page);
    _hotGoodsList.addAll(moreHot.data);
    notifyListeners();
  }

  enableBack(bool state) {
    _showBack = state;
    notifyListeners();
  }

  Future<HomePageEntity> _getHomePageContent(double lon, double lat) async {
    var response = await request(servicePath['homePageContent'], formData: {'lon': /*'115.02932'*/ lon, 'lat': /*'35.76189'*/ lat });
    return HomePageEntity.fromJson(json.decode(response.data.toString()));
  }

  Future<HotGoodsEntity> _getHomePageHots(int page) async {
    var response = await request(servicePath['homePageHotPart'], formData: {'page': page});
    return HotGoodsEntity.fromJson(json.decode(response.data));
  }
}
