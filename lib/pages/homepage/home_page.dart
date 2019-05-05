import 'dart:ui';

import 'package:amap_base/amap_base.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/pages/homepage/ad_banner.dart';
import 'package:flutter_shop/pages/homepage/banner_diy.dart';
import 'package:flutter_shop/pages/homepage/floor_part.dart';
import 'package:flutter_shop/pages/homepage/hot_part.dart';
import 'package:flutter_shop/pages/homepage/lead_phone.dart';
import 'package:flutter_shop/pages/homepage/mall_recommend.dart';
import 'package:flutter_shop/pages/homepage/top_nativator.dart';
import 'package:flutter_shop/provides/home_provide.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:provide/provide.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<EasyRefreshState> _refreshKey = GlobalKey();
  final GlobalKey<RefreshHeaderState> _headerKey = GlobalKey();
  final GlobalKey<RefreshFooterState> _footerKey = GlobalKey();
  final ScrollController _outController = ScrollController();
  final _mapLocation = AMapLocation();

  @override
  Widget build(BuildContext context) {
    _mapLocation.init();

    Permissions().requestPermission().then((granted) {
      if (granted) {
        _mapLocation
            .getLocation(LocationClientOptions(
          isOnceLocation: true,
          isNeedAddress: true,
          locatingWithReGeocode: true,
        ))
            .then((location) {
          print('location:(${location.longitude}, ${location.latitude}), ${location.district}');
          Provide.value<HomeProvide>(context)
            ..initHomeEntity(location.longitude, location.latitude)
            ..changeDistrict(location.district, location.longitude, location.latitude);
        });
      } else {
        Provide.value<HomeProvide>(context).initHomeEntity(115.02932, 35.76189);
      }
    });

    Provide.value<HomeProvide>(context).initHotGoodsList();

    _outController.addListener(() {
      Provide.value<HomeProvide>(context).enableBack(_outController.position.pixels >= window.physicalSize.height);
    });

    return Theme(
      data: ThemeData(primarySwatch: Colors.pink, iconTheme: IconThemeData(color: Colors.pink)),
      child: Provide<HomeProvide>(
          builder: (_, widget, homeProvide) => Scaffold(
                appBar: AppBar(
                  title: Text('百姓生活+'),
                  centerTitle: true,
                  leading: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_on, color: Colors.white, size: 12.0),
                          Expanded(
                            child: Text(homeProvide.district, style: TextStyle(fontSize: 12.0), overflow: TextOverflow.ellipsis, maxLines: 1),
                          )
                        ],
                      ),
                    ),
                    onTap: () => Application.router.navigateTo(context, Routers.map, transition: TransitionType.fadeIn),
                  ),
                ),
                body: homeProvide.homeEntity == null
                    ? Center(child: CupertinoActivityIndicator(radius: 12.0))
                    : EasyRefresh(
                        key: _refreshKey,
                        refreshHeader: BallPulseHeader(key: _headerKey, color: Colors.pink),
                        refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink),
                        loadMore: () => homeProvide.loadMoreHotGoods(),
                        child: CustomScrollView(
                          controller: _outController,
                          physics: BouncingScrollPhysics(),
                          slivers: <Widget>[
                            BannerDiy(bannerImages: homeProvide.homeEntity.data.slides),
                            TopNavigatorBar(categories: homeProvide.homeEntity.data.category),
                            AdBanner(bannerUrl: homeProvide.homeEntity.data.advertesPicture.pICTUREADDRESS),
                            LeaderPhone(
                              imageUrl: homeProvide.homeEntity.data.shopInfo.leaderImage,
                              phone: homeProvide.homeEntity.data.shopInfo.leaderPhone,
                            ),
                            RecommendWidget(recommendList: homeProvide.homeEntity.data.recommend),
                            FloorTitle(floorPic: homeProvide.homeEntity.data.floor1Pic.pICTUREADDRESS),
                            FloorContent(floorContent: homeProvide.homeEntity.data.floor1),
                            FloorTitle(floorPic: homeProvide.homeEntity.data.floor2Pic.pICTUREADDRESS),
                            FloorContent(floorContent: homeProvide.homeEntity.data.floor2),
                            FloorTitle(floorPic: homeProvide.homeEntity.data.floor3Pic.pICTUREADDRESS),
                            FloorContent(floorContent: homeProvide.homeEntity.data.floor3),
                            HotGoodsTitle(),
                            SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              children: homeProvide.hodGoodsList.map((hot) => HotItem(hot: hot)).toList(),
                            )
                          ],
                        ),
                      ),
                floatingActionButton: homeProvide.showBack
                    ? FloatingActionButton(
                        onPressed: () {
                          _outController.animateTo(0.0, duration: Duration(milliseconds: 500), curve: Curves.decelerate);
                        },
                        mini: true,
                        child: Icon(Icons.vertical_align_top))
                    : null,
              )),
    );
  }
}
