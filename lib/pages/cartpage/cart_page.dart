import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cartpage/bottom_summary.dart';
import 'package:flutter_shop/pages/cartpage/empty_cart.dart';
import 'package:flutter_shop/pages/cartpage/shopping_cart_list.dart';
import 'package:flutter_shop/provides/cart_provide.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
        builder: (_, child, cartProvide) => Scaffold(
              appBar: AppBar(title: Text('购物车'), centerTitle: true),
              body: cartProvide.shopCarts.isEmpty
                  // 购物车为空情况
                  ? EmptyShoppingCart()
                  // 购物车非空情况
                  : ShoppingCartList(cartProvide: cartProvide),
              bottomNavigationBar: cartProvide.shopCarts.isEmpty
                  ? null
                  : BottomAppBar(
                      child: BottomCartSummary(cartProvide: cartProvide),
                    ),
            ));
  }
}
