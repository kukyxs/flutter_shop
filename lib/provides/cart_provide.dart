import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/entities/goods_detail_entity.dart';
import 'package:flutter_shop/entities/shopping_cart_entity.dart';
import 'package:flutter_shop/utils/preference_utils.dart';

class CartProvide with ChangeNotifier {
  bool _isAllChecked = false; // 是否全选
  int _allSelectedCount = 0; // 选中的物品数量
  int _allCartCount = 0; // 购物车内全部的物品数量
  double _allSelectedPrice = 0.0; // 选中物品的全部价格
  String _shopCartList = '[]'; // 用于持久化
  List<ShoppingCartEntity> _shopCarts = []; // 购物车物品列表

  bool get allCheckedState => _isAllChecked;

  int get allCartCount => _allCartCount;

  int get allCheckedCount => _allSelectedCount;

  double get allCheckedPrice => _allSelectedPrice;

  List<ShoppingCartEntity> get shopCarts => _shopCarts;

  CartProvide() {
    PreferenceUtils.instance.getString('shop_cart', '[]').then((value) {
      _shopCartList = value;
      _shopCarts.clear();
      _shopCarts.addAll(_shopCartList == '[]' ? [] : ShoppingCartEntity.fromJsonList(json.decode(_shopCartList)));
      _allInfoStateCheck();
      notifyListeners();
    });
  }

  /// 保存物品到购物车，可随意选择数量
  saveCarts(GoodInfoBean info, int count) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    var included = false;

    if (carts.isNotEmpty) {
      carts.forEach((cart) {
        // 不是空列表的情况下，判断是否已经存在该物品，存在则添加，并设置状态位
        if (cart['goodsId'] == info.goodsId) {
          cart['count'] += count;
          included = true;
        }
      });
    }

    // 不存在该商品的时候则全部加入到列表
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

  /// 增加/减少商品数量
  increaseOrReduceOperation(String goodsId, bool isIncrease) {
    List<dynamic> carts = json.decode(_shopCartList);

    // 已经存在的情况下才增加减少，修改数量值
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

  /// 移除购物车内的某个商品
  removeCarts(String goodsId) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.removeWhere((e) => e['goodsId'] == goodsId);
    }

    _notifyChanges(carts);
  }

  /// 修改特定商品在购物车的选中状态
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

  /// 全选状态修改
  allCheckStateChange(bool checkState) {
    List<dynamic> carts = _shopCartList == '[]' ? [] : json.decode(_shopCartList);

    if (carts.isNotEmpty) {
      carts.forEach((cart) {
        cart['isChecked'] = checkState; // 所有状态跟随全选修改
      });
    }

    _notifyChanges(carts);
  }

  /// 更新购物车状态封装方法
  _notifyChanges(List carts) {
    PreferenceUtils.instance.saveString('shop_cart', json.encode(carts));
    _shopCartList = json.encode(carts);
    _shopCarts.clear();
    _shopCarts.addAll(carts.isEmpty ? [] : ShoppingCartEntity.fromJsonList(carts));
    _allInfoStateCheck();
    notifyListeners();
  }

  /// 数量，全选状态修改封装
  void _allInfoStateCheck() {
    _allCartCount = 0;
    _allSelectedCount = 0;
    _allSelectedPrice = 0.0;
    _isAllChecked = true;

    _shopCarts.forEach((e) {
      _allCartCount += e.count; // 全部数量
      if (!e.isChecked) {
        _isAllChecked = false; // 如果一个未选中，则全选为 false
      } else {
        _allSelectedCount += e.count;
        _allSelectedPrice += e.count * e.price;
      }
    });
  }
}
