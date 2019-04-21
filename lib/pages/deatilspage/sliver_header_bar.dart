import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';

class SliverHeaderBar extends StatelessWidget {
  final GoodsDetailProvide detailProvide;
  final List<String> tabs;
  final bool innerScrolled;
  final double _expandedHeight = 560.0;

  SliverHeaderBar({Key key, this.detailProvide, this.tabs, this.innerScrolled}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _detail = detailProvide.detail;
    return SliverAppBar(
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
      flexibleSpace: HeaderFlex(detailProvide: detailProvide, expandedHeight: _expandedHeight),
      // 折叠高度
      expandedHeight: _expandedHeight,
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
    );
  }
}

class HeaderFlex extends StatelessWidget {
  final GoodsDetailProvide detailProvide;
  final double expandedHeight;

  HeaderFlex({Key key, this.detailProvide, this.expandedHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _detail = detailProvide.detail.data;

    return FlexibleSpaceBar(
      collapseMode: CollapseMode.pin,
      background: Container(
        alignment: Alignment.center,
        color: Colors.white,
        height: expandedHeight,
        child: Column(
          children: <Widget>[
            Image.network(_detail.goodInfo.image1, height: 340), // 图片
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 商品名
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 12.0, right: 12.0),
                  child: Text(
                    _detail.goodInfo.goodsName,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                ),
                // 商品编号
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                  child: Text('编号：${_detail.goodInfo.goodsSerialNumber}'),
                ),
                // 商品价格
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 12.0, right: 12.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
                    Text('￥${_detail.goodInfo.presentPrice}', style: TextStyle(fontSize: 16.0, color: Colors.red)),
                    Padding(padding: const EdgeInsets.only(left: 16.0), child: Text('市场价：', style: TextStyle(color: Colors.black))),
                    Text('￥${_detail.goodInfo.oriPrice}', style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.black26)),
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
    );
  }
}
