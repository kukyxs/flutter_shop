import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';
import '../service/service_method.dart';
import 'package:provide/provide.dart';
import '../entities/goods_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  final _tabs = ['详情', '评论'];

  DetailsPage({Key key, this.goodsId}) : super(key: key);

  Widget _detail(GoodInfoBean info) {
    return Builder(
        builder: (context) => CustomScrollView(slivers: <Widget>[
              SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverToBoxAdapter(child: Text.rich(TextSpan(text: info.goodsDetail)))
            ]));
  }

  Widget _comment(GoodInfoBean info) {
    return Builder(
        builder: (context) => CustomScrollView(slivers: <Widget>[
              SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context)),
              SliverToBoxAdapter(child: Text.rich(TextSpan(text: info.goodsDetail)))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    getGoodsDetail(goodsId).then((val) =>
        Provide.value<GoodsDetailProvide>(context).changeDetails(GoodsDetailModel.fromMap(json.decode(val.data))));

    return Provide<GoodsDetailProvide>(
        builder: (context, child, detailProvide) => detailProvide.detail == null
            ? Scaffold(
                body: Center(
                  child: CupertinoActivityIndicator(),
                ),
              )
            : Scaffold(
                body: DefaultTabController(
                    length: _tabs.length,
                    child: NestedScrollView(
                        headerSliverBuilder: (context, innerScrolled) => [
                              SliverOverlapAbsorber(
                                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                                child: SliverAppBar(
                                  forceElevated: innerScrolled,
                                  pinned: true,
                                  centerTitle: true,
                                  title: Text(detailProvide.detail.data.goodInfo.goodsName,
                                      maxLines: 1, overflow: TextOverflow.ellipsis),
                                  // 顶部显示
                                  flexibleSpace: FlexibleSpaceBar(
                                    collapseMode: CollapseMode.pin,
                                    background: Container(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0, 12.0, 12.0),
                                      color: CupertinoColors.white,
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                                        Image.network(detailProvide.detail.data.goodInfo.image1),
                                        Padding(
                                            padding: const EdgeInsets.only(top: 20.0),
                                            child: Text(detailProvide.detail.data.goodInfo.goodsName,
                                                style: TextStyle(fontSize: 18.0, color: Colors.black))),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                                          child: Text('编号：${detailProvide.detail.data.goodInfo.goodsSerialNumber}'),
                                        ),
                                        Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                                          Text('￥${detailProvide.detail.data.goodInfo.presentPrice}',
                                              style: TextStyle(fontSize: 16.0, color: Colors.red)),
                                          Padding(
                                              padding: const EdgeInsets.only(left: 16.0),
                                              child: Text('市场价：', style: TextStyle(color: Colors.black))),
                                          Text('￥${detailProvide.detail.data.goodInfo.oriPrice}',
                                              style: TextStyle(
                                                  decoration: TextDecoration.lineThrough, color: Colors.black26)),
                                        ]),
                                      ]),
                                    ),
                                  ),
                                  expandedHeight: ScreenUtil().setHeight(850),
                                  bottom: TabBar(
                                      tabs: _tabs.map((tab) => Text(tab, style: TextStyle(fontSize: 18.0))).toList()),
                                ),
                              )
                            ],
                        body: TabBarView(children: [
                          _detail(detailProvide.detail.data.goodInfo),
                          _comment(detailProvide.detail.data.goodInfo)
                        ]))),
                //
                bottomNavigationBar: BottomAppBar(
                    child: Container(
                  height: ScreenUtil().setHeight(100),
                  child: Card(
                    margin: const EdgeInsets.all(0.0),
                    child: Row(children: <Widget>[
                      IconButton(
                          icon: Icon(CupertinoIcons.shopping_cart, size: 32.0, color: Colors.pink), onPressed: () {}),
                      Expanded(
                          child: InkWell(
                              child: Container(
                                  color: Colors.green,
                                  alignment: Alignment.center,
                                  child: Text('加入购物车', style: TextStyle(color: Colors.white, fontSize: 18.0))),
                              onTap: () {})),
                      Expanded(
                          child: InkWell(
                              child: Container(
                                  color: Colors.red,
                                  alignment: Alignment.center,
                                  child: Text('立即购买', style: TextStyle(color: Colors.white, fontSize: 18.0))),
                              onTap: () {}))
                    ]),
                  ),
                )),
              ));
  }
}
