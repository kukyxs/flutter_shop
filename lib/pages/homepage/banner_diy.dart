import 'package:flutter/material.dart';
import 'package:flutter_shop/configs/application.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/router/routers.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerDiy extends StatelessWidget {
  final List<Slides> bannerImages;

  BannerDiy({Key key, @required this.bannerImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 180.0,
        child: Swiper(
          itemCount: bannerImages.length,
          itemBuilder: (context, int index) => InkWell(
                child: Image.network('${bannerImages[index].image}', fit: BoxFit.fill),
                onTap: () => Application.router.navigateTo(context, Routers.generateDetailsRouterPath(bannerImages[index].goodsId)),
              ),
          pagination: SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
  }
}
