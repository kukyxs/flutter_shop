import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/mem_page.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), title: Text('分类')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), title: Text('购物车')),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled), title: Text('会员中心'))
  ];

  final _tabPages = <Widget>[HomePage(), CategoryPage(), CartPage(), MemPage()];

  var _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1344)..init(context);

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      body: IndexedStack(index: _currentPageIndex, children: _tabPages),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabs,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPageIndex,
        onTap: (value) {
          setState(() => _currentPageIndex = value);
        },
      ),
    );
  }
}
