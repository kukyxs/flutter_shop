import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/provides/page_index_provide.dart';
import 'package:provide/provide.dart';

class EmptyShoppingCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
