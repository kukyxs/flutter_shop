import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/entities/category_entity.dart';
import 'package:flutter_shop/entities/category_goods_entity.dart';
import 'package:flutter_shop/provides/mall_goods_provide.dart';
import 'package:flutter_shop/provides/sub_category_provide.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<CategoryData> categories = <CategoryData>[];
  GlobalKey<EasyRefreshState> _refreshKey = GlobalKey();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey();
  ScrollController _gridController = ScrollController();
  ScrollController _topNavController = ScrollController();
  int selectPosition = 0;

  @override
  void initState() {
    super.initState();
    _requestCategories();
  }

  @override
  void dispose() {
    _gridController.dispose();
    _topNavController.dispose();
    super.dispose();
  }

  void _requestCategories() {
    getCategories().then((response) {
      setState(() {
        categories.addAll(CategoryEntity.fromMap(json.decode(response.data)).data);
        // 默认初始值列表
        Provide.value<SubCategoryProvide>(context).changeLeftHeadCategories(categories[0].bxMallSubDto);
        Provide.value<SubCategoryProvide>(context).changeCategory(categories[0].mallCategoryId);
        _requestGoodsList();
      });
    });
  }

  // 获取右侧标签下的商品列表
  void _requestGoodsList() {
    getMallGoods(Provide.value<SubCategoryProvide>(context).categoryId, Provide.value<SubCategoryProvide>(context).subCategoryId,
            Provide.value<MallGoodsProvide>(context).page)
        .then((response) {
      Map<String, dynamic> jsonFormat = json.decode(response.data);
      // 返回有数据才解析
      if (jsonFormat['data'] != null) {
        CategoryGoodsEntity goods = CategoryGoodsEntity.fromMap(jsonFormat);
        if (Provide.value<MallGoodsProvide>(context).page == 1) {
          Provide.value<MallGoodsProvide>(context).changeGoodsList(goods.data);
        } else {
          Provide.value<MallGoodsProvide>(context).loadMoreGoodsList(goods.data);
        }
        Provide.value<MallGoodsProvide>(context).increasePage();
      } else {
        // 无数据返回情况
        if (Provide.value<MallGoodsProvide>(context).page == 1)
          Provide.value<MallGoodsProvide>(context).changeGoodsList([]);
        else {
          Fluttertoast.showToast(msg: '没有更多啦~');
          Provide.value<MallGoodsProvide>(context).loadMoreGoodsList([]);
        }
      }
    });
  }

  // 左侧大类导航列表 item
  InkWell _leftCategoryItem(int index, BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() => selectPosition = index);
        Provide.value<SubCategoryProvide>(context).changeLeftHeadCategories(categories[index].bxMallSubDto);
        Provide.value<SubCategoryProvide>(context).changeCategory(categories[index].mallCategoryId);
        Provide.value<MallGoodsProvide>(context).initialPage();
        _requestGoodsList();
        _gridController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        _topNavController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.decelerate);
      },
      child: Container(
        color: index == selectPosition ? Colors.black12 : Colors.white,
        height: 60.0,
        child: Text(categories[index].mallCategoryName, style: TextStyle(fontSize: 15.0, color: Colors.black)),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
    );
  }

  // 右侧头部导航列表 item
  Widget _subCategoryNav(int index, BxMallSubDtoListBean subDto) {
    return InkWell(
        onTap: () {
          Provide.value<SubCategoryProvide>(context).changeSubCategorySelect(subDto.mallSubId);
          Provide.value<SubCategoryProvide>(context).changeSubCategoryIndex(index);
          Provide.value<MallGoodsProvide>(context).initialPage();
          _requestGoodsList();
          _gridController.animateTo(0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            subDto.mallSubName,
            style: TextStyle(color: index == Provide.value<SubCategoryProvide>(context).subIndex ? Colors.pink : Colors.black),
          ),
        ));
  }

  // 右侧商品列表 item
  Widget _goodsItem(CategoryGoodsInfo info, BuildContext context) {
    return InkWell(
      onTap: () => Application.router.navigateTo(context, Routers.generateDetailsRouterPath(info.goodsId)),
      child: Container(
        margin: const EdgeInsets.all(2.0),
        alignment: Alignment.center,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Image.network(info.image, width: MediaQuery.of(context).size.width * 0.4, height: MediaQuery.of(context).size.width * 0.4),
            Text('${info.goodsName}', style: TextStyle(fontSize: 14.0, color: Colors.black), overflow: TextOverflow.ellipsis),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
              Text('￥${info.presentPrice}', style: TextStyle(fontSize: 14.0)),
              Text('￥${info.oriPrice}', style: TextStyle(color: Colors.black26, decoration: TextDecoration.lineThrough, fontSize: 12.0))
            ])
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'), centerTitle: true),
      body: Row(children: <Widget>[
        // 左侧栏
        Container(
          width: 100.0,
          child: ListView.separated(
              itemBuilder: (context, index) => _leftCategoryItem(index, context),
              separatorBuilder: (context, index) => Divider(height: 1.0, color: Colors.black12),
              itemCount: categories.length),
        ),
        // 分割线
        VerticalDivider(width: 1.0, color: Colors.black12),
        // 右侧栏
        Expanded(
            child: Column(
          children: <Widget>[
            // 头部导航
            Provide<SubCategoryProvide>(
              builder: (_, child, subCategories) => Container(
                    color: Colors.white,
                    height: 50.0,
                    child: ListView.builder(
                      controller: _topNavController,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) => _subCategoryNav(index, subCategories.subCategories[index]),
                      itemCount: subCategories.subCategories.length,
                    ),
                  ),
            ),
            Divider(height: 1.0, color: Colors.black12),
            // 物品展示
            Expanded(
              child: Provide<MallGoodsProvide>(
                builder: (context, widget, goodsProvide) => goodsProvide.goodList.isEmpty
                    // 当前商品分类无商品情况
                    ? Center(
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          Image.asset('images/empty.png', width: 60.0, height: 60.0),
                          Text('啊哦...目前未找到该分类下的商品'),
                        ]),
                      )
                    // 当前商品列表下有数据情况
                    : EasyRefresh(
                        key: _refreshKey,
                        refreshHeader: BallPulseHeader(key: _headerKey, color: Colors.pink),
                        refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink),
                        loadMore: () {
                          _requestGoodsList();
                        },
                        child: GridView.builder(
                            controller: _gridController,
                            itemCount: goodsProvide.goodList.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, childAspectRatio: 2 / 3, mainAxisSpacing: 1.0, crossAxisSpacing: 1.0),
                            itemBuilder: (_, index) => _goodsItem(goodsProvide.goodList[index], context)),
                      ),
              ),
            )
          ],
        ))
      ]),
    );
  }
}
