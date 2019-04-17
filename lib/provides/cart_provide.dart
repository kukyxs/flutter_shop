import 'dart:convert';

import 'package:flutter/material.dart';
import '../utils/preference_utils.dart';
import '../entities/goods_detail.dart';
import '../entities/cate_entity.dart';

class CartProvide with ChangeNotifier {
  bool _isAllChecked = false;
  int _allSelectedCount = 0;
  double _allSelectedPrice = 0.0;
  String _shopCartList = '[]';
  List<CateEntity> _shopCarts = [];

  bool get allCheckedState => _isAllChecked;

  int get allCheckedCount => _allSelectedCount;

  double get allCheckedPrice => _allSelectedPrice;

  List<CateEntity> get shopCarts => _shopCarts;

  CartProvide() {
    restoreShopCarts().then((value) {
      _shopCartList = value;
      _shopCarts.clear();
      _shopCarts.addAll(_shopCartList == '[]' ? [] : CateEntity.fromJsonList(json.decode(_shopCartList)));
      _allInfoStateCheck();
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
        'isChecked': true,
      });
    }

    _notifyChanges(carts);
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

    _notifyChanges(carts);
  }

  removeCarts(String goodsId) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.removeWhere((e) => e['goodsId'] == goodsId);
    }

    _notifyChanges(carts);
  }

  changeCartState(String goodsId, bool checked) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.forEach((cart) {
        if (cart['goodsId'] == goodsId) {
          cart['isChecked'] = checked;
        }
      });
    }

    _notifyChanges(carts);
  }

  allCheckStateChange(bool checkState) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.forEach((cart) {
        cart['isChecked'] = checkState;
      });
    }

    _notifyChanges(carts);
  }

  _notifyChanges(List carts) {
    PreferenceUtils.instance.saveString('shop_cart', json.encode(carts));
    _shopCartList = json.encode(carts);
    _shopCarts.clear();
    _shopCarts.addAll(carts.isEmpty ? [] : CateEntity.fromJsonList(carts));
    _allInfoStateCheck();
    notifyListeners();
  }

  void _allInfoStateCheck() {
    _allSelectedCount = 0;
    _allSelectedPrice = 0.0;
    _isAllChecked = true;

    _shopCarts.forEach((e) {
      if (!e.isChecked) {
        _isAllChecked = false;
      } else {
        _allSelectedCount += e.count;
        _allSelectedPrice += e.count * e.price;
      }
    });
  }

  Future<String> restoreShopCarts() async {
    return PreferenceUtils.instance.getString('shop_cart', '[]');
  }
}
