import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';
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
    return Provide<GoodsDetailProvide>(
        builder: (_, widget, detailProvide) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(detailProvide.detail == null ? '' : '${detailProvide.detail.data.goodInfo.goodsName}',
                    maxLines: 1, overflow: TextOverflow.ellipsis),
              ),
              body: Container(
                child: detailProvide.detail == null
                    ? CupertinoActivityIndicator(radius: 12.0)
                    : ListView(
                        children: <Widget>[
                          Image.network(detailProvide.detail.data.goodInfo.image1, height: 300.0),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                            child: Text(detailProvide.detail.data.goodInfo.goodsName, style: TextStyle(fontSize: 18.0, color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                            child: Text('编号：${detailProvide.detail.data.goodInfo.goodsSerialNumber}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                            child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                              Text('￥${detailProvide.detail.data.goodInfo.presentPrice}', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                              Padding(padding: const EdgeInsets.only(left: 16.0), child: Text('市场价：', style: TextStyle(color: Colors.black))),
                              Text('￥${detailProvide.detail.data.goodInfo.oriPrice}',
                                  style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black26)),
                            ]),
                          ),
                          Container(height: 12.0, color: Colors.black12, margin: const EdgeInsets.only(top: 8.0)),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(12.0),
                            child: Text('说明：>急速送达 >正品保证', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                          ),
                          Container(height: 12.0, color: Colors.black12),
                          DefaultTabController(
                            length: _tabs.length,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: 50.0,
                                    child: TabBar(
                                      tabs: _tabs.map((tab) => Text(tab, style: TextStyle(fontSize: 18.0))).toList(),
                                      indicatorColor: Colors.pink,
                                      labelColor: Colors.pink,
                                      unselectedLabelColor: Colors.black,
                                      onTap: (index) => detailProvide.changeIndex(index),
                                    )),
                                Container(
                                  child: Column(
                                    children: <Widget>[
                                      Html(data: detailProvide.detail.data.goodInfo.goodsDetail),
                                      Image.network(detailProvide.detail.data.advertesPicture.PICTURE_ADDRESS)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
              bottomNavigationBar: BottomAppBar(
                  child: Container(
                height: ScreenUtil().setHeight(100),
                child: Card(
                  margin: const EdgeInsets.all(0.0),
                  child: Row(children: <Widget>[
                    IconButton(icon: Icon(CupertinoIcons.shopping_cart, size: 32.0, color: Colors.pink), onPressed: () {}),
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
