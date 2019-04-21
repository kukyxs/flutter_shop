import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';

class GoodsComments extends StatelessWidget {
  final GoodsDetailProvide detailProvide;

  GoodsComments({Key key, this.detailProvide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _detail = detailProvide.detail.data;

    return Builder(builder: (ctx) {
      return CustomScrollView(
        slivers: <Widget>[
          SliverOverlapInjector(handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx)),
          _detail.goodComments.isEmpty
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
                                Text('${_detail.goodComments[index].userName}'), // 评论者昵称
                                Text('${_detail.goodComments[index].comments}'), // 评论信息
                                Text('${DateTime.fromMillisecondsSinceEpoch(_detail.goodComments[index].discussTime)}'.split('.').first), // 评论时间
                              ],
                            ),
                          ),
                      childCount: _detail.goodComments.length),
                  itemExtent: 80.0),
          SliverToBoxAdapter(child: Image.network(_detail.advertesPicture.PICTURE_ADDRESS))
        ],
      );
    });
  }
}
