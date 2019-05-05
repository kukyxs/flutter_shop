import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/pages/mempage/mem_header.dart';
import 'package:flutter_shop/pages/mempage/mem_tile.dart';
import 'package:flutter_shop/pages/mempage/order_grid.dart';
import 'package:flutter_shop/router/routers.dart';

class MemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          MemHeader(),
          MemTile(leading: Icons.border_all, title: "我的订单", action: () {}),
          Divider(height: 2.0, color: Colors.black38),
          OrderGrid(),
          Container(height: 8.0, color: Colors.black12),
          MemTile(leading: Icons.bookmark_border, title: "领取优惠券", action: () {}),
          Divider(height: 2.0, color: Colors.black38),
          MemTile(leading: Icons.bookmark_border, title: "已领取优惠券", action: () {}),
          Divider(height: 2.0, color: Colors.black38),
          MemTile(leading: Icons.my_location, title: "地址管理", action: () {}),
          Container(height: 8.0, color: Colors.black12),
          MemTile(leading: Icons.phone, title: "客服电话", action: () {}),
          Divider(height: 2.0, color: Colors.black38),
          MemTile(leading: Icons.info_outline, title: "关于商城", action: () {}),
          Container(height: 8.0, color: Colors.black12),
          MemTile(leading: Icons.settings, title: "设置", action: () => Application.router.navigateTo(context, Routers.settings)),
        ],
      ),
    );
  }
}
