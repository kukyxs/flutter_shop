import 'package:flutter/material.dart';

class CartCountProvide with ChangeNotifier {
  int _count = 1;

  int get shopCount => _count;

  initCount() {
    _count = 1;
    notifyListeners();
  }

  increase() {
    _count += 1;
    notifyListeners();
  }

  decrease() {
    _count -= 1;
    notifyListeners();
  }
}
