import 'package:flutter/material.dart';

/// 用于购物车的选择数量
class CartCountProvide with ChangeNotifier {
  int _count = 1;

  int get shopCount => _count;

  initCount() {
    _count = 1; // 打开时候初始化
    notifyListeners();
  }

  increase() {
    _count += 1; // 增加按钮
    notifyListeners();
  }

  decrease() {
    _count -= 1; // 减少按钮
    notifyListeners();
  }
}
