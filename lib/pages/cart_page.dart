import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:flutter_shop/provides/page_provide.dart';
import 'package:provide/provide.dart';
import 'package:flutter/cupertino.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
        builder: (_, child, carts) => Scaffold(
              appBar: AppBar(title: Text('购物车'), centerTitle: true),
              body: carts.shopCarts.isEmpty
                  // 购物车为空情况
                  ? Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DecoratedBox(
                              decoration: ShapeDecoration(shape: CircleBorder(), color: Colors.black12),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(CupertinoIcons.shopping_cart, size: 50.0, color: Colors.white),
                              )),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text('购物车还空着，快去挑选商品吧~', style: TextStyle(fontSize: 12.0, color: Colors.black26)),
                          ),
                          RaisedButton(
                              onPressed: () => Provide.value<PageIndexProvide>(context).changePage(0),
                              child: Text('随便逛逛', style: TextStyle(color: Colors.white)),
                              color: Colors.pink)
                        ],
                      ),
                    )
                  // 购物车非空情况
                  : ListView.separated(
                      itemBuilder: (_, index) {
                        if (index == carts.shopCarts.length) {
                          // 购物车商品小计 item
                          return Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('共${carts.allCheckedCount}件商品', style: TextStyle(color: Colors.black)),
                                Text('小计：￥${carts.allCheckedPrice}', style: TextStyle(color: Colors.red[700]))
                              ],
                            ),
                          );
                        } else {
                          // 购物车商品列表 item
                          return Container(
                            color: Colors.white,
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Checkbox(
                                    value: carts.shopCarts[index].isChecked,
                                    onChanged: (checkState) {
                                      // 修改商品选择状态
                                      Provide.value<CartProvide>(context).changeCartState(carts.shopCarts[index].goodsId, checkState);
                                    },
                                    activeColor: Colors.pink),
                                // 商品图标
                                DecoratedBox(
                                  decoration: ShapeDecoration(shape: RoundedRectangleBorder(), color: Colors.black12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(1.0),
                                    child: Image.network(carts.shopCarts[index].goodsImg, height: 80.0, width: 80.0),
                                  ),
                                ),
                                // 中间件
                                Expanded(
                                    child: Container(
                                  height: 80.0, // 该部件同图片同高
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        carts.shopCarts[index].goodsName,
                                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      // 数量管理器
                                      CartCountWidget(
                                        count: carts.shopCarts[index].count,
                                        goodsId: carts.shopCarts[index].goodsId,
                                      )
                                    ],
                                  ),
                                )),
                                // 商品价格
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text('￥${(carts.shopCarts[index].count * carts.shopCarts[index].price).toStringAsFixed(2)}',
                                        style: TextStyle(color: Colors.black, fontSize: 16.0)),
                                    Text(
                                      '￥${(carts.shopCarts[index].count * carts.shopCarts[index].orgPrice).toStringAsFixed(2)}',
                                      style: TextStyle(color: Colors.black54, fontSize: 14.0, decoration: TextDecoration.lineThrough),
                                    ),
                                    InkWell(
                                        child: Icon(CupertinoIcons.delete, size: 32.0),
                                        onTap: () {
                                          Provide.value<CartProvide>(context).removeCarts(carts.shopCarts[index].goodsId);
                                        })
                                  ],
                                )
                              ],
                            ),
                          );
                        }
                      },
                      separatorBuilder: (_, index) => Divider(height: 1.0, color: Colors.black26),
                      itemCount: carts.shopCarts.length + 1,
                    ),
              bottomNavigationBar: carts.shopCarts.isEmpty
                  ? null
                  : BottomAppBar(
                      child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                      height: 60.0,
                      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
                        Checkbox(
                            value: carts.allCheckedState,
                            onChanged: (checkState) {
                              carts.allCheckStateChange(checkState);
                            },
                            activeColor: Colors.pink),
                        Text('全选', style: TextStyle(color: Colors.black, fontSize: 15.0)),
                        Expanded(
                            child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Text('合计：', style: TextStyle(color: Colors.black, fontSize: 18.0)),
                                        Text('￥${carts.allCheckedPrice}', style: TextStyle(color: Colors.red[700], fontSize: 16.0)),
                                      ],
                                    ),
                                    Text('满10元免费配送，预购免费配送', style: TextStyle(color: Colors.black, fontSize: 10.0))
                                  ],
                                ))),
                        RaisedButton(
                          onPressed: () {},
                          child: Text('结算(${carts.allCheckedCount})', style: TextStyle(color: Colors.white)),
                          color: Colors.pink,
                        )
                      ]),
                    )),
            ));
  }
}

class CartCountWidget extends StatelessWidget {
  final int count;
  final String goodsId;

  CartCountWidget({Key key, this.count, this.goodsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 30.0,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(2.0)), side: BorderSide(color: Colors.black54)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: InkWell(
            onTap: count == 1 ? null : () => Provide.value<CartProvide>(context).increaseOrReduceOperation(goodsId, false),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(right: BorderSide(color: Colors.black54, width: 1.0)),
                ),
                child: Center(child: Text('-', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
          )),
          Expanded(child: Center(child: Text('$count', style: TextStyle(fontSize: 14.0, color: Colors.black))), flex: 2),
          Expanded(
              child: InkWell(
            onTap: () => Provide.value<CartProvide>(context).increaseOrReduceOperation(goodsId, true),
            child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(left: BorderSide(color: Colors.black54, width: 1.0)),
                ),
                child: Center(child: Text('+', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
          ))
        ],
      ),
    );
  }
}
