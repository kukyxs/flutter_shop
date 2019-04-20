import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/router/routers.dart';

class FloorTitle extends StatelessWidget {
  final String floorPic;

  FloorTitle({Key key, @required this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Container(child: Image.network(floorPic), padding: const EdgeInsets.symmetric(vertical: 12.0)));
  }
}

class FloorContent extends StatelessWidget {
  final List<Floor> floorContent;

  FloorContent({Key key, @required this.floorContent}) : super(key: key);

  Widget _goodsImg(Floor floorItem, context) {
    return InkWell(
        child: Image.network(floorItem.image, width: MediaQuery.of(context).size.width / 2),
        onTap: () => Application.router.navigateTo(context, Routers.generateDetailsRouterPath(floorItem.goodsId)));
  }

  Widget _topRow(context) {
    return Row(children: <Widget>[
      _goodsImg(floorContent[0], context),
      Column(children: <Widget>[
        _goodsImg(floorContent[1], context),
        _goodsImg(floorContent[2], context),
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: InkWell(
      child: Container(
        child: Column(children: <Widget>[
          _topRow(context),
          Row(children: <Widget>[
            _goodsImg(floorContent[3], context),
            _goodsImg(floorContent[4], context),
          ])
        ]),
      ),
      onTap: () {},
    ));
  }
}
