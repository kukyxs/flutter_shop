import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/entities/shopping_cart_entity.dart';
import 'package:flutter_shop/pages/cartpage/cart_count.dart';
import 'package:flutter_shop/provides/cart_provide.dart';

class ShoppingCartList extends StatelessWidget {
  final CartProvide cartProvide;

  ShoppingCartList({Key key, this.cartProvide}) : super(key: key);

  /// 列表小计
  Widget _cartSummaryItem() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '共${cartProvide.allCheckedCount}件商品',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            '小计：￥${cartProvide.allCheckedPrice}',
            style: TextStyle(color: Colors.red[700]),
          )
        ],
      ),
    );
  }

  /// 前置部分，checkbox image
  Widget _leadingPart(ShoppingCartEntity entity) {
    return Row(
      children: <Widget>[
        Checkbox(
            value: entity.isChecked,
            onChanged: (checkState) {
              // 修改商品选择状态
              cartProvide.changeCartState(entity.goodsId, checkState);
            },
            activeColor: Colors.pink),
        // 商品图标
        DecoratedBox(
          decoration: ShapeDecoration(shape: RoundedRectangleBorder(), color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Image.network(entity.goodsImg, height: 80.0, width: 80.0),
          ),
        )
      ],
    );
  }

  /// 中间部分，商品名 计数器
  Widget _middlePart(ShoppingCartEntity entity) {
    return Expanded(
      child: Container(
        height: 80.0, // 该部件同图片同高
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              entity.goodsName,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            // 数量管理器
            CartCountWidget(
              count: entity.count,
              goodsId: entity.goodsId,
              cartProvide: cartProvide,
            )
          ],
        ),
      ),
    );
  }

  /// 尾部价格部分
  Widget _trailingPart(ShoppingCartEntity entity) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '￥${(entity.count * entity.price).toStringAsFixed(2)}',
          style: TextStyle(color: Colors.black, fontSize: 16.0),
        ),
        Text(
          '￥${(entity.count * entity.orgPrice).toStringAsFixed(2)}',
          style: TextStyle(color: Colors.black54, fontSize: 14.0, decoration: TextDecoration.lineThrough),
        ),
        InkWell(
            child: Icon(CupertinoIcons.delete, size: 32.0),
            onTap: () {
              cartProvide.removeCarts(entity.goodsId);
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (_, index) => index == cartProvide.shopCarts.length
          ? _cartSummaryItem()
          : Container(
              color: Colors.white,
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: <Widget>[
                  _leadingPart(cartProvide.shopCarts[index]),
                  _middlePart(cartProvide.shopCarts[index]),
                  _trailingPart(cartProvide.shopCarts[index])
                ],
              ),
            ),
      separatorBuilder: (_, index) => Divider(height: 1.0, color: Colors.black26),
      itemCount: cartProvide.shopCarts.length + 1,
    );
  }
}
