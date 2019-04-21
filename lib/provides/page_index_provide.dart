import 'package:flutter/material.dart';

/// 首页 tab 切换
class PageIndexProvide with ChangeNotifier {
  int _page = 0;

  int get page => _page;

  changePage(int page) {
    _page = page;
    notifyListeners();
  }
}
