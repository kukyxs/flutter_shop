import 'package:flutter/material.dart';
import '../entities/category.dart';

class SubCategoryProvide with ChangeNotifier {
  List<BxMallSubDtoListBean> _bxMallSubs = [];

  List<BxMallSubDtoListBean> get subCategories => _bxMallSubs;

  void changeBxCategories(List<BxMallSubDtoListBean> categories) {
    BxMallSubDtoListBean allSubDto = BxMallSubDtoListBean()
      ..mallCategoryId = '00'
      ..mallSubId = '00'
      ..comments = ''
      ..mallSubName = '全部';

    _bxMallSubs.clear();
    _bxMallSubs.add(allSubDto);
    _bxMallSubs.addAll(categories);

    notifyListeners();
  }
}
