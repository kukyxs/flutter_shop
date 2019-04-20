import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/entities/hot_goods.dart';

import '../configs/service_url.dart';

Future<HomePageEntity> getHomePageContent() async {
  var response = await request(servicePath['homePageContent'], formData: {'lon': '115.02932', 'lat': '35.76189'});
  return HomePageEntity.fromJson(json.decode(response.data.toString()));
}

Future<HotGoodsEntity> getHomePageHots(int page) async {
  var response = await request(servicePath['homePageHotPart'], formData: {'page': page});
  return HotGoodsEntity.fromJson(json.decode(response.data));
}

Future<Response> getCategories() => request(servicePath['getCategory']);

Future<Response> getMallGoods(String categoryId, String categorySubId, int page) => request(servicePath['getMallGoods'],
    formData:
        categorySubId != null ? {'categoryId': categoryId, 'categorySubId': categorySubId, 'page': page} : {'categoryId': categoryId, 'page': page});

Future<Response> getGoodsDetail(String id) => request(servicePath['getGoodDetailById'], formData: {'goodId': id});

Future<Response> request(String url, {Map formData}) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType = ContentType.parse('application/x-www-form-urlencoded');
    if (formData == null) {
      response = await dio.post(url);
    } else {
      response = await dio.post(url, data: formData);
    }
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Net Error');
    }
  } catch (e) {
    print('ERROR: $e');
    return null;
  }
}
