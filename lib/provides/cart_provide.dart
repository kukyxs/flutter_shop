import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/preference_utils.dart';
import '../entities/goods_detail.dart';
import '../entities/cate_entity.dart';

class CartProvide with ChangeNotifier {
  String _shopCartList = '[]';
  List<CateEntity> _shopCarts = [];

  List<CateEntity> get shopCarts => _shopCarts;

  CartProvide() {
    restoreShopCarts().then((value) {
      _shopCartList = value;
      _shopCarts.clear();
      _shopCarts.addAll(_shopCartList == '[]' ? [] : CateEntity.fromJsonList(json.decode(_shopCartList)));
      notifyListeners();
    });
  }

  saveCarts(GoodInfoBean info, int count) {
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
    shopCarts.clear();
    shopCarts.addAll(carts.isEmpty ? [] : CateEntity.fromJsonList(carts));
    notifyListeners();
  }

  increaseOrReduceOperation(String goodsId, bool isIncrease) {
    List<dynamic> carts = json.decode(_shopCartList);

    carts.forEach((cart) {
      if (cart['goodsId'] == goodsId) {
        if (isIncrease) {
          cart['count'] += 1;
        } else {
          cart['count'] -= 1;
        }
      }
    });

    PreferenceUtils.instance.saveString('shop_cart', json.encode(carts));
    _shopCartList = json.encode(carts);
    shopCarts.clear();
    shopCarts.addAll(carts.isEmpty ? [] : CateEntity.fromJsonList(carts));
    notifyListeners();
  }

  removeCarts(String goodsId) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.removeWhere((e) => e['goodsId'] == goodsId);
    }

    PreferenceUtils.instance.saveString('shop_cart', json.encode(carts));
    _shopCartList = json.encode(carts);
    shopCarts.clear();
    shopCarts.addAll(carts.isEmpty ? [] : CateEntity.fromJsonList(carts));
    notifyListeners();
  }

  Future<String> restoreShopCarts() async {
    return PreferenceUtils.instance.getString('shop_cart', '[]');
  }
}
