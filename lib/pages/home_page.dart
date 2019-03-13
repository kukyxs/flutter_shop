import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/ball_pulse_footer.dart';
import 'package:flutter_easyrefresh/ball_pulse_header.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/service_method.dart';

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
  List _hots = [];

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
        print(json.decode(val.data));
        setState(() {
          _hots.addAll(json.decode(val.data)['data']);
          _page++;
          _isLoadingHots = false;
        });
      });
    }
  }

  Widget _hotItems(Map hot) {
    return InkWell(
        onTap: () {},
        child: Container(
            color: Colors.white,
            margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.network(hot['image']),
                Text(hot['name'], textAlign: TextAlign.center, maxLines: 1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('￥${hot['mallPrice']}'),
                    Text('￥${hot['price']}',
                        style: TextStyle(color: Colors.black45, decoration: TextDecoration.lineThrough))
                  ],
                )
              ],
            )));
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
                var data = json.decode(snapshot.data.toString());
                List<Map> bannerImages = (data['data']['slides'] as List).cast();
                List<Map> categories = (data['data']['category'] as List).cast();
                String bannerUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
                String leaderImage = data['data']['shopInfo']['leaderImage'];
                String phone = data['data']['shopInfo']['leaderPhone'];
                List<Map> recommendLists = (data['data']['recommend'] as List).cast();
                String floor1Pic = data['data']['floor1Pic']['PICTURE_ADDRESS'];
                List<Map> floor1 = (data['data']['floor1'] as List).cast();
                String floor2Pic = data['data']['floor2Pic']['PICTURE_ADDRESS'];
                List<Map> floor2 = (data['data']['floor2'] as List).cast();
                String floor3Pic = data['data']['floor3Pic']['PICTURE_ADDRESS'];
                List<Map> floor3 = (data['data']['floor3'] as List).cast();

                return EasyRefresh(
                    key: _refreshKey,
                    refreshHeader: BallPulseHeader(key: _headerKey, color: Colors.pink),
                    refreshFooter: BallPulseFooter(key: _footerKey, color: Colors.pink),
                    loadMore: () => _requestHots(),
                    child: CustomScrollView(
                        controller: _outController,
                        physics: BouncingScrollPhysics(),
                        slivers: <Widget>[
                          BannerDiy(bannerImages: bannerImages),
                          TopNavigatorBar(categories: categories),
                          AdBanner(bannerUrl: bannerUrl),
                          LeaderPhone(imageUrl: leaderImage, phone: phone),
                          RecommendWidget(recommendList: recommendLists),
                          FloorTitle(floorPic: floor1Pic),
                          FloorContent(floorContent: floor1),
                          FloorTitle(floorPic: floor2Pic),
                          FloorContent(floorContent: floor2),
                          FloorTitle(floorPic: floor3Pic),
                          FloorContent(floorContent: floor3),
                          HotGoodsTitle(),
                          SliverGrid.count(
                              crossAxisCount: 2,
                              childAspectRatio: 0.7,
                              children: _hots.map((hot) => _hotItems(hot)).toList())
                        ]));
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

class BannerDiy extends StatelessWidget {
  final List<Map> bannerImages;

  BannerDiy({Key key, @required this.bannerImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      height: ScreenUtil().setHeight(320),
      child: Swiper(
        itemCount: bannerImages.length,
        itemBuilder: (context, int index) => Image.network('${bannerImages[index]['image']}', fit: BoxFit.fill),
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    ));
  }
}

class TopNavigatorBar extends StatelessWidget {
  final List<Map> categories;

  TopNavigatorBar({Key key, @required this.categories}) : super(key: key);

  Widget _buildCategoryItem(context, item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [Image.network(item['image'], width: ScreenUtil().setWidth(95)), Text(item['mallCategoryName'])],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (categories.length > 10) categories.removeRange(10, categories.length);
    return SliverToBoxAdapter(
        child: Container(
            alignment: Alignment.center,
            height: ScreenUtil().setHeight(320),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 5,
                children: categories.map((item) => _buildCategoryItem(context, item)).toList(),
              ),
            )));
  }
}

class AdBanner extends StatelessWidget {
  final String bannerUrl;

  AdBanner({Key key, @required this.bannerUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Container(child: Image.network(bannerUrl)));
  }
}

class LeaderPhone extends StatelessWidget {
  final String imageUrl;
  final String phone;

  LeaderPhone({Key key, @required this.imageUrl, @required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            child: InkWell(
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
                onTap: () async {
                  var url = 'tel:$phone';
                  var canLauncher = await canLaunch(url);
                  if (canLauncher)
                    launch(url);
                  else
                    print('url error');
                })));
  }
}

class RecommendWidget extends StatelessWidget {
  final List recommendList;

  RecommendWidget({Key key, @required this.recommendList}) : super(key: key);

  Widget _recommendTitle() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0))),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  Widget _recommendItem(BuildContext context, int index) {
    return InkWell(
        onTap: () {},
        child: Container(
          width: ScreenUtil().setWidth(250),
          height: ScreenUtil().setHeight(330),
          decoration: BoxDecoration(border: Border(left: BorderSide(color: Colors.black12)), color: Colors.white),
          child: Column(children: <Widget>[
            Image.network(recommendList[index]['image'], height: ScreenUtil().setHeight(220)),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text('￥${recommendList[index]['price']}',
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.double,
                    decorationColor: Colors.red))
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
            margin: const EdgeInsets.only(top: 6.0),
            child: Column(children: <Widget>[
              _recommendTitle(),
              Container(
                height: ScreenUtil().setHeight(300),
                child: ListView.builder(
                    itemBuilder: _recommendItem,
                    itemCount: this.recommendList.length,
                    scrollDirection: Axis.horizontal),
              )
            ])));
  }
}

class FloorTitle extends StatelessWidget {
  final String floorPic;

  FloorTitle({Key key, @required this.floorPic}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(child: Image.network(floorPic), padding: const EdgeInsets.symmetric(vertical: 12.0)));
  }
}

class FloorContent extends StatelessWidget {
  final List<Map> floorContent;

  FloorContent({Key key, @required this.floorContent}) : super(key: key);

  Widget _topRow() {
    return Row(children: <Widget>[
      Image.network(floorContent[0]['image'], width: ScreenUtil().setWidth(375)),
      Column(children: <Widget>[
        Image.network(floorContent[1]['image'], width: ScreenUtil().setWidth(375)),
        Image.network(floorContent[2]['image'], width: ScreenUtil().setWidth(375))
      ])
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: InkWell(
      child: Container(
        child: Column(children: <Widget>[
          _topRow(),
          Row(children: <Widget>[
            Image.network(floorContent[3]['image'], width: ScreenUtil().setWidth(375)),
            Image.network(floorContent[4]['image'], width: ScreenUtil().setWidth(375))
          ])
        ]),
      ),
      onTap: () {},
    ));
  }
}

class HotGoodsTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      alignment: Alignment.center,
      child: Text('火爆专区', style: TextStyle(color: Colors.black)),
      padding: const EdgeInsets.symmetric(vertical: 8.0),
    ));
  }
}
