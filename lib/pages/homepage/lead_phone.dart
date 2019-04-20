import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LeaderPhone extends StatelessWidget {
  final String imageUrl;
  final String phone;

  LeaderPhone({Key key, @required this.imageUrl, @required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: Container(
      child: InkWell(
          child: Image.network(imageUrl, fit: BoxFit.cover),
          onTap: () async {
            var url = 'tel:$phone';
            if (await canLaunch(url)) launch(url);
          }),
    ));
  }
}
