import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../configs/service_url.dart';

Future getHomePageContent() =>
    request(servicePath['homePageContent'], formData: {'lon': '115.02932', 'lat': '35.76189'});

Future getHomePageHots(int page) => request(servicePath['homePageHotPart'], formData: {'page': page});

Future getCategories() => request(servicePath['getCategory']);

Future getMallGoods(String categoryId, String categorySubId, int page) => request(servicePath['getMallGoods'],
    formData: categorySubId != null
        ? {'categoryId': categoryId, 'categorySubId': categorySubId, 'page': page}
        : {'categoryId': categoryId, 'page': page});

Future request(String url, {Map formData}) async {
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
      print(response.data.toString());
      return response;
    } else {
      throw Exception('Net Error');
    }
  } catch (e) {
    return print('ERROR: $e');
  }
}
