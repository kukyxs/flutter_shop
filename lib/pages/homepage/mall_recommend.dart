import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/router/routers.dart';

class RecommendWidget extends StatelessWidget {
  final List<Recommend> recommendList;

  RecommendWidget({Key key, @required this.recommendList}) : super(key: key);

  Widget _recommendTitle() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0))),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  Widget _recommendItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {
          Application.router.navigateTo(context, Routers.generateDetailsRouterPath(recommendList[index].goodsId));
        },
        child: Container(
          width: ScreenUtil().setWidth(250),
          height: ScreenUtil().setHeight(330),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12)), color: Colors.white),
          child: Column(children: <Widget>[
            Image.network(recommendList[index].image, height: ScreenUtil().setHeight(220)),
            Text('￥${recommendList[index].mallPrice}'),
            Text('￥${recommendList[index].price}', style: TextStyle(decoration: TextDecoration.lineThrough, decorationColor: Colors.red[700]))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      margin: const EdgeInsets.only(top: 6.0),
      child: Column(children: <Widget>[
        _recommendTitle(),
        Container(
          height: ScreenUtil().setHeight(300),
          child: ListView.builder(itemBuilder: _recommendItem, itemCount: this.recommendList.length, scrollDirection: Axis.horizontal),
        )
      ]),
    ));
  }
}
