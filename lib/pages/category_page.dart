import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../entities/category.dart';
import '../provides/sub_category_provide.dart';
import '../service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  List<CategoryData> categories = <CategoryData>[];
  int selectPosition = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _requestCategories();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _requestCategories() {
    getCategories().then((response) {
      setState(() {
        categories.addAll(CategoryEntity.fromMap(json.decode(response.data)).data);
        // 默认初始值列表
        Provide.value<SubCategoryProvide>(context).changeBxCategories(categories[0].bxMallSubDto);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'), centerTitle: true),
      body: Row(children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(180),
          child: ListView.separated(
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    setState(() => selectPosition = index);
                    Provide.value<SubCategoryProvide>(context).changeBxCategories(categories[index].bxMallSubDto);
                  },
                  child: Container(
                    color: index == selectPosition ? Colors.black12 : Colors.white,
                    height: ScreenUtil().setHeight(120),
                    child:
                        Text(categories[index].mallCategoryName, style: TextStyle(fontSize: 15.0, color: Colors.black)),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(height: 1.0, color: Colors.black12);
              },
              itemCount: categories.length),
        ),
        VerticalDivider(width: 1.0, color: Colors.black12),
        Expanded(
            child: Column(
          children: <Widget>[
            Provide<SubCategoryProvide>(
                builder: (context, _, subCategories) => Container(
                      color: Colors.white,
                      width: ScreenUtil().setWidth(570),
                      height: ScreenUtil().setHeight(80),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (_, index) => SubCategoryNav(subDto: subCategories.subCategories[index]),
                        itemCount: subCategories.subCategories.length,
                      ),
                    )),
            Divider(height: 1.0, color: Colors.black12)
          ],
        ))
      ]),
    );
  }
}

class SubCategoryNav extends StatelessWidget {
  final BxMallSubDtoListBean subDto;

  SubCategoryNav({Key key, @required this.subDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          height: ScreenUtil().setHeight(80),
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(subDto.mallSubName),
        ));
  }
}
