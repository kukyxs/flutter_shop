import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/entities/hot_goods.dart';
import 'package:flutter_shop/pages/homepage/ad_banner.dart';
import 'package:flutter_shop/pages/homepage/banner_diy.dart';
import 'package:flutter_shop/pages/homepage/floor_part.dart';
import 'package:flutter_shop/pages/homepage/hot_part.dart';
import 'package:flutter_shop/pages/homepage/lead_phone.dart';
import 'package:flutter_shop/pages/homepage/mall_recommend.dart';
import 'package:flutter_shop/pages/homepage/top_nativator.dart';
import 'package:flutter_shop/service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  GlobalKey<EasyRefreshState> _refreshKey = GlobalKey();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey();
  ScrollController _outController = ScrollController();

  // 防止多次请求
  bool _isLoadingHots = false;
  bool _showBackTop = false;
  int _page = 0;
  List<HotGoodsData> _hots = [];

  @override
  void initState() {
    super.initState();
    _requestHots();

    _outController.addListener(() {
      setState(() => _showBackTop = _outController.position.pixels >= window.physicalSize.height);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  _requestHots() {
    if (!_isLoadingHots) {
      setState(() => _isLoadingHots = true);

      getHomePageHots(_page).then((val) {
        setState(() {
          var e = HotGoodsEntity.fromJson(json.decode(val.data));
          _hots.addAll(e.data);
          _page++;
          _isLoadingHots = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primarySwatch: Colors.pink, iconTheme: IconThemeData(color: Colors.pink)),
        child: Scaffold(
          appBar: AppBar(title: Text('百姓生活+'), centerTitle: true),
          body: FutureBuilder(
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var homeEntity = HomePageEntity.fromJson(json.decode(snapshot.data.toString()));

                return EasyRefresh(
                    key: _refreshKey,
                    refreshHeader: BallPulseHeader(key: _headerKey, color: Colors.pink),
                    refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink),
                    loadMore: () => _requestHots(),
                    child: CustomScrollView(
                      controller: _outController,
                      physics: BouncingScrollPhysics(),
                      slivers: <Widget>[
                        BannerDiy(bannerImages: homeEntity.data.slides),
                        TopNavigatorBar(categories: homeEntity.data.category),
                        AdBanner(bannerUrl: homeEntity.data.advertesPicture.pICTUREADDRESS),
                        LeaderPhone(imageUrl: homeEntity.data.shopInfo.leaderImage, phone: homeEntity.data.shopInfo.leaderPhone),
                        RecommendWidget(recommendList: homeEntity.data.recommend),
                        FloorTitle(floorPic: homeEntity.data.floor1Pic.pICTUREADDRESS),
                        FloorContent(floorContent: homeEntity.data.floor1),
                        FloorTitle(floorPic: homeEntity.data.floor2Pic.pICTUREADDRESS),
                        FloorContent(floorContent: homeEntity.data.floor2),
                        FloorTitle(floorPic: homeEntity.data.floor3Pic.pICTUREADDRESS),
                        FloorContent(floorContent: homeEntity.data.floor3),
                        HotGoodsTitle(),
                        SliverGrid.count(crossAxisCount: 2, childAspectRatio: 0.7, children: _hots.map((hot) => HotItem(hot: hot)).toList())
                      ],
                    ));
              } else {
                return Center(child: CupertinoActivityIndicator(radius: 12.0));
              }
            },
            future: getHomePageContent(),
          ),
          floatingActionButton: _showBackTop
              ? FloatingActionButton(
              onPressed: () {
                _outController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
              },
              mini: true,
              child: Icon(Icons.vertical_align_top))
              : null,
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
