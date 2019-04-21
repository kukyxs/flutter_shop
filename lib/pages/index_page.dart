import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/pages/cartpage/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/homepage/home_page.dart';
import 'package:flutter_shop/pages/mempage/mem_page.dart';
import 'package:flutter_shop/provides/page_index_provide.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _bottomTabs = <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心'))
    ];

    final _tabPages = <Widget>[HomePage(), CategoryPage(), CartPage(), MemPage()];

    return Provide<PageIndexProvide>(
        builder: (_, child, pageProvide) => Scaffold(
              backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
              body: IndexedStack(index: pageProvide.page, children: _tabPages),
              bottomNavigationBar: BottomNavigationBar(
                items: _bottomTabs,
                type: BottomNavigationBarType.fixed,
                currentIndex: pageProvide.page,
                onTap: (value) {
                  Provide.value<PageIndexProvide>(context).changePage(value);
                },
              ),
            ));
  }
}
