import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/preference_utils.dart';
import '../entities/goods_detail.dart';

class CartProvide with ChangeNotifier {
  String _shopCartList = '[]';

  String get shopCartList => _shopCartList;

  saveCarts(GoodInfoBean info, int count) async {
    _shopCartList = await restoreShopCarts();

    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    var included = false;

    if (carts.isNotEmpty) {
      carts.forEach((cart) {
        if (cart['goodsId'] == info.goodsId) {
          cart['count'] += count;
          included = true;
        }
      });
    }

    if (!included) {
      carts.add({
        'goodsName': info.goodsName,
        'goodsId': info.goodsId,
        'goodsImg': info.image1,
        'orgPrice': info.oriPrice,
        'price': info.presentPrice,
        'count': count,
      });
    }

    PreferenceUtils.instance.saveString('shop_cart', json.encode(carts));
    _shopCartList = json.encode(carts);

    notifyListeners();
  }

  Future<String> restoreShopCarts() async {
    return PreferenceUtils.instance.getString('shop_cart', '[]');
  }
}
