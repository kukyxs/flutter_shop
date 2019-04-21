import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/deatilspage/goods_comments.dart';
import 'package:flutter_shop/pages/deatilspage/goods_detail.dart';
import 'package:flutter_shop/pages/deatilspage/goods_handler.dart';
import 'package:flutter_shop/pages/deatilspage/sliver_header_bar.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';
import 'package:provide/provide.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  final _tabs = ['详情', '评论'];

  DetailsPage({Key key, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provide.value<GoodsDetailProvide>(context)
      ..changeDetails(goodsId)
      ..changeIndex(0);

    return Provide<GoodsDetailProvide>(builder: (_, widget, detailProvide) {
      var _detail = detailProvide.detail;

      return Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: _detail == null || _detail.data == null || _detail.data.goodInfo == null
              ? CupertinoActivityIndicator(radius: 12.0) // 无商品情况使用加载
              // 使用横向滑动列表展示不同页面
              : DefaultTabController(
                  length: _tabs.length,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerScrolled) => [
                          SliverOverlapAbsorber(
                            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                            child: SliverHeaderBar(detailProvide: detailProvide, tabs: _tabs, innerScrolled: innerScrolled),
                          )
                        ],
                    // 详情页面和评论页面列表
                    body: TabBarView(
                      children: [GoodsDetail(detailProvide: detailProvide), GoodsComments(detailProvide: detailProvide)],
                    ),
                  ),
                ),
        ),
        bottomNavigationBar: GoodsHandler(detailProvide: detailProvide),
      );
    });
  }
}
