import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/cart_provide.dart';

class CartCountWidget extends StatelessWidget {
  final int count;
  final String goodsId;
  final CartProvide cartProvide;

  CartCountWidget({Key key, this.count, this.goodsId, this.cartProvide}) : super(key: key);

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
          // 减值操作，数量为 1 停止
          Expanded(
            child: InkWell(
              onTap: count == 1 ? null : () => cartProvide.increaseOrReduceOperation(goodsId, false),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(right: BorderSide(color: Colors.black54, width: 1.0)),
                  ),
                  child: Center(child: Text('－', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
            ),
          ),
          Expanded(child: Center(child: Text('$count', style: TextStyle(fontSize: 14.0, color: Colors.black))), flex: 2),
          // 加值操作
          Expanded(
            child: InkWell(
              onTap: () => cartProvide.increaseOrReduceOperation(goodsId, true),
              child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(left: BorderSide(color: Colors.black54, width: 1.0)),
                  ),
                  child: Center(child: Text('＋', style: TextStyle(fontSize: 16.0, color: Colors.black)))),
            ),
          )
        ],
      ),
    );
  }
}
