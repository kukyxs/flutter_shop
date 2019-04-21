import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/cart_count_provide.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:flutter_shop/provides/goods_detail_provide.dart';
import 'package:flutter_shop/provides/page_index_provide.dart';
import 'package:provide/provide.dart';

class GoodsHandler extends StatelessWidget {
  final GoodsDetailProvide detailProvide;

  GoodsHandler({Key key, this.detailProvide}) : super(key: key);

  Widget _countOperator(CartCountProvide cartCount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: InkWell(
            onTap: cartCount.shopCount == 1 ? () {} : () => cartCount.decrease(),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black54, width: 1.0)),
                ),
                child: Center(child: Text('－', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
          ),
        ),
        Expanded(child: Center(child: Text('${cartCount.shopCount}', style: TextStyle(fontSize: 14.0, color: Colors.black))), flex: 2),
        Expanded(
          child: InkWell(
            onTap: () => cartCount.increase(),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black54, width: 1.0)),
                ),
                child: Center(child: Text('＋', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
          ),
        )
      ],
    );
  }

  _countModalSheet(BuildContext ctx) {
    Provide.value<CartCountProvide>(ctx).initCount(); // 购买数量初始化为 1
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
                  Row(children: <Widget>[
                    Container(
                      width: 120.0,
                      height: 30.0,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          side: BorderSide(color: Colors.black54),
                        ),
                      ),
                      child: _countOperator(cartCount),
                    ),

                    // 加入购物车按钮
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: OutlineButton(
                          child: Text('确定加入购物车'),
                          onPressed: () {
                            Provide.value<CartProvide>(context).saveCarts(detailProvide.detail.data.goodInfo, cartCount.shopCount);
                            Navigator.pop(context);
                          }),
                    )
                  ])
                ],
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Container(
        height: 60.0,
        child: Card(
          margin: const EdgeInsets.all(0.0),
          child: Row(children: <Widget>[
            // 购物车按钮
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
                      ),
                )
              ],
            ),
            // 加入购物车
            Expanded(
              child: Builder(
                builder: (ctx) => InkWell(
                      child: Container(
                          color: Colors.green,
                          alignment: Alignment.center,
                          child: Text('加入购物车', style: TextStyle(color: Colors.white, fontSize: 18.0))),
                      onTap: () {
                        _countModalSheet(ctx);
                      },
                    ),
              ),
            ),
            // 立即购买
            Expanded(
              child: InkWell(
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: Text('立即购买', style: TextStyle(color: Colors.white, fontSize: 18.0)),
                  ),
                  onTap: () {}),
            )
          ]),
        ),
      ),
    );
  }
}
