import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/entities/hot_goods_entity.dart';
import 'package:flutter_shop/router/routers.dart';

/// 火爆专区标题
class HotGoodsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        alignment: Alignment.center,
        child: Text('火爆专区', style: TextStyle(color: Colors.black)),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
      ),
    );
  }
}

/// 火爆专区
class HotItem extends StatelessWidget {
  final HotGoodsData hot;

  HotItem({Key key, this.hot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, Routers.generateDetailsRouterPath(hot.goodsId));
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.network(hot.image),
            Text(hot.name, textAlign: TextAlign.center, maxLines: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('￥${hot.mallPrice}'),
                Text('￥${hot.price}', style: TextStyle(color: Colors.black45, decoration: TextDecoration.lineThrough))
              ],
            )
          ],
        ),
      ),
    );
  }
}
