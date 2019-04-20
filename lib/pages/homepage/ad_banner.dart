import 'package:flutter/material.dart';

class AdBanner extends StatelessWidget {
  final String bannerUrl;

  AdBanner({Key key, @required this.bannerUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(child: Image.network(bannerUrl));
  }
}
