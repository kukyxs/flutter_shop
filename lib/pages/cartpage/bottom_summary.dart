import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/cart_provide.dart';

class BottomCartSummary extends StatelessWidget {
  final CartProvide cartProvide;

  BottomCartSummary({Key key, this.cartProvide}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      height: 60.0,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Checkbox(
            value: cartProvide.allCheckedState,
            onChanged: (checkState) {
              cartProvide.allCheckStateChange(checkState);
            },
            activeColor: Colors.pink),
        Text('全选', style: TextStyle(color: Colors.black, fontSize: 15.0)),
        // 合计价格
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
                        Text('￥${cartProvide.allCheckedPrice}', style: TextStyle(color: Colors.red[700], fontSize: 16.0)),
                      ],
                    ),
                    Text('满10元免费配送，预购免费配送', style: TextStyle(color: Colors.black, fontSize: 10.0))
                  ],
                ))),
        // 结算按钮
        RaisedButton(
          onPressed: () {},
          child: Text('结算(${cartProvide.allCheckedCount})', style: TextStyle(color: Colors.white)),
          color: Colors.pink,
        )
      ]),
    );
  }
}
