import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provides/cart_count_provide.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';
import 'package:flutter_shop/provides/page_provide.dart';
import 'package:provide/provide.dart';

import '../entities/goods_detail.dart';
import '../service/service_method.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  final _tabs = ['详情', '评论'];

  DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getGoodsDetail(goodsId).then((val) => Provide.value<GoodsDetailProvide>(context).changeDetails(GoodsDetailModel.fromMap(json.decode(val.data))));
    Provide.value<GoodsDetailProvide>(context).changeIndex(0);

    return NestedType(tabs: _tabs);
  }
}

class NestedType extends StatelessWidget {
  final List<String> tabs;

  NestedType({Key key, this.tabs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provide<GoodsDetailProvide>(builder: (_, widget, detailProvide) {
      var _detail = detailProvide.detail;

      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: _detail == null || _detail.data == null || _detail.data.goodInfo == null
              ? CupertinoActivityIndicator(radius: 12.0) // 无商品情况使用加载
              // 使用横向滑动列表展示不同页面
              : DefaultTabController(
                  length: tabs.length,
                  child: NestedScrollView(
                      headerSliverBuilder: (context, innerScrolled) => [
                            SliverOverlapAbsorber(
                              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                              child: SliverAppBar(
                                pinned: true,
                                centerTitle: true,
                                // 商品名
                                title: Text(
                                  _detail.data.goodInfo.goodsName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                forceElevated: innerScrolled,
                                // 折叠头部信息
                                flexibleSpace: FlexibleSpaceBar(
                                  collapseMode: CollapseMode.pin,
                                  background: Container(
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    height: 560.0,
                                    child: Column(
                                      children: <Widget>[
                                        Image.network(_detail.data.goodInfo.image1, height: 340),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                                              child: Text(_detail.data.goodInfo.goodsName, style: TextStyle(fontSize: 18.0, color: Colors.black)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                                              child: Text('编号：${_detail.data.goodInfo.goodsSerialNumber}'),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                                              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                                                Text('￥${_detail.data.goodInfo.presentPrice}', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                                                Padding(
                                                    padding: const EdgeInsets.only(left: 16.0),
                                                    child: Text('市场价：', style: TextStyle(color: Colors.black))),
                                                Text('￥${_detail.data.goodInfo.oriPrice}',
                                                    style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black26)),
                                              ]),
                                            ),
                                            Container(
                                              height: 8.0,
                                              color: Colors.black12,
                                              margin: const EdgeInsets.only(top: 4.0),
                                            ),
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.all(12.0),
                                              child: Text('说明：>急速送达 >正品保证', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                                            ),
                                            Container(height: 8.0, color: Colors.black12)
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // 折叠高度
                                expandedHeight: 560.0,
                                bottom: TabBar(
                                    indicator: BoxDecoration(color: Colors.transparent),
                                    labelColor: Colors.pink,
                                    indicatorWeight: .0,
                                    indicatorColor: Colors.pink,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    unselectedLabelColor: Colors.black,
                                    labelPadding: EdgeInsets.zero,
                                    tabs: tabs
                                        .map((tab) => Container(
                                              height: 60.0,
                                              color: Colors.white,
                                              alignment: Alignment.center,
                                              child: Text(tab, style: TextStyle(fontSize: 18.0)),
                                            ))
                                        .toList()),
                              ),
                            )
                          ],
                      // 详情页面和评论页面列表
                      body: TabBarView(children: [
                        Builder(
                            builder: (ctx) => CustomScrollView(
                                  // 详情页面 H5
                                  slivers: <Widget>[
                                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx)),
                                    SliverToBoxAdapter(child: Html(data: _detail.data.goodInfo.goodsDetail)),
                                    // 广告条
                                    SliverToBoxAdapter(child: Image.network(detailProvide.detail.data.advertesPicture.PICTURE_ADDRESS))
                                  ],
                                )),
                        Builder(
                            // 评论页面
                            builder: (ctx) => CustomScrollView(
                                  slivers: <Widget>[
                                    SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx)),
                                    _detail.data.goodComments.isEmpty
                                        // 无评论
                                        ? SliverToBoxAdapter(child: Container(alignment: Alignment.center, height: 60.0, child: Text('暂时没有评论哦~')))
                                        // 评论列表
                                        : SliverFixedExtentList(
                                            delegate: SliverChildBuilderDelegate(
                                                (_, index) => Container(
                                                      color: Colors.white,
                                                      padding: const EdgeInsets.only(left: 12.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text('${_detail.data.goodComments[index].userName}'),
                                                          Text('${_detail.data.goodComments[index].comments}'),
                                                          Text('${DateTime.fromMillisecondsSinceEpoch(_detail.data.goodComments[index].discussTime)}'
                                                              .split('.')
                                                              .first),
                                                        ],
                                                      ),
                                                    ),
                                                childCount: _detail.data.goodComments.length),
                                            itemExtent: 80.0),
                                    SliverToBoxAdapter(child: Image.network(detailProvide.detail.data.advertesPicture.PICTURE_ADDRESS))
                                  ],
                                ))
                      ])),
                ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          height: 60.0,
          child: Card(
            margin: const EdgeInsets.all(0.0),
            child: Row(children: <Widget>[
              Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  IconButton(
                      icon: Icon(CupertinoIcons.shopping_cart, size: 32.0, color: Colors.pink),
                      onPressed: () {
                        Navigator.pop(context);
                        Provide.value<PageIndexProvide>(context).changePage(2);
                      }),
                  Provide<CartProvide>(
                      builder: (_, child, carts) => DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0, left: 4.0, right: 4.0),
                              child: Text('${carts.allCartCount}', style: TextStyle(color: Colors.white)),
                            ),
                          ))
                ],
              ),
              Expanded(
                  child: Builder(
                builder: (ctx) => InkWell(
                    child: Container(
                        color: Colors.green,
                        alignment: Alignment.center,
                        child: Text('加入购物车', style: TextStyle(color: Colors.white, fontSize: 18.0))),
                    onTap: () {
                      /// 加入购物车
                      Provide.value<CartCountProvide>(context).initCount();
                      showModalBottomSheet(
                          context: ctx,
                          builder: (context) => Provide<CartCountProvide>(builder: (_, child, cartCount) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                                  height: 100.0,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('购买数量', style: TextStyle(color: Colors.black, fontSize: 12.0)),
                                      Row(
                                        children: <Widget>[
                                          /// 数量部件
                                          Container(
                                            width: 120.0,
                                            height: 30.0,
                                            decoration: ShapeDecoration(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(Radius.circular(2.0)), side: BorderSide(color: Colors.black54)),
                                            ),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Expanded(
                                                    child: InkWell(
                                                  onTap: cartCount.shopCount == 1 ? () {} : () => cartCount.decrease(),
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        border: Border(right: BorderSide(color: Colors.black54, width: 1.0)),
                                                      ),
                                                      child: Center(child: Text('-', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
                                                )),
                                                Expanded(
                                                    child: Center(
                                                        child: Text('${cartCount.shopCount}', style: TextStyle(fontSize: 14.0, color: Colors.black))),
                                                    flex: 2),
                                                Expanded(
                                                    child: InkWell(
                                                  onTap: () => cartCount.increase(),
                                                  child: DecoratedBox(
                                                      decoration: BoxDecoration(
                                                        border: Border(left: BorderSide(color: Colors.black54, width: 1.0)),
                                                      ),
                                                      child: Center(child: Text('+', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
                                                ))
                                              ],
                                            ),
                                          ),

                                          /// 加入购物车按钮
                                          Padding(
                                            padding: const EdgeInsets.only(left: 30.0),
                                            child: OutlineButton(
                                                onPressed: () {
                                                  Provide.value<CartProvide>(context)
                                                      .saveCarts(detailProvide.detail.data.goodInfo, cartCount.shopCount);
                                                  Navigator.pop(context);
                                                },
                                                child: Text('确定加入购物车')),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }));
                    }),
              )),
              Expanded(
                  child: InkWell(
                      child: Container(
                          color: Colors.red, alignment: Alignment.center, child: Text('立即购买', style: TextStyle(color: Colors.white, fontSize: 18.0))),
                      onTap: () {
                        Provide.value<CartProvide>(context).shopCarts.forEach((e) => print('${e.goodsName} - ${e.count}件'));
                      }))
            ]),
          ),
        )),
      );
    });
  }
}
