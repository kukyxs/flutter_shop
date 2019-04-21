import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';

class GoodsDetail extends StatelessWidget {
  final GoodsDetailProvide detailProvide;

  GoodsDetail({Key key, this.detailProvide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (ctx) {
      var _detail = detailProvide.detail.data;

      return CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx)),
          // H5 详情
          SliverToBoxAdapter(child: Html(data: _detail.goodInfo.goodsDetail)),
          // 广告条
          SliverToBoxAdapter(child: Image.network(_detail.advertesPicture.PICTURE_ADDRESS))
        ],
      );
    });
  }
}
