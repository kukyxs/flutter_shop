import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活家'),
      ),
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> bannerImages = (data['data']['slides'] as List).cast();
            List<Map> categories = (data['data']['category'] as List).cast();
            String bannerUrl = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String phone = data['data']['shopInfo']['leaderPhone'];
            return CustomScrollView(physics: BouncingScrollPhysics(), slivers: <Widget>[
              BannerDiy(bannerImages: bannerImages),
              TopNavigatorBar(categories: categories),
              AdBanner(bannerUrl: bannerUrl),
              LeaderPhone(imageUrl: leaderImage, phone: phone),
            ]);
          } else {
            return Center(child: Text('Loading...'));
          }
        },
        future: getHomePageContent(),
      ),
    );
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
