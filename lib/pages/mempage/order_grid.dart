import 'package:flutter/material.dart';

class OrderGrid extends StatelessWidget {
  final _icons = [Icons.payment, Icons.timer, Icons.airport_shuttle, Icons.textsms];
  final _titles = ['待付款', '待发货', '待收货', '待评价'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 4,
      child: GridView.count(
        crossAxisCount: _icons.length,
        children: List.generate(
            _icons.length,
            (index) => InkWell(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[Icon(_icons[index]), Padding(padding: const EdgeInsets.all(4.0), child: Text(_titles[index]))],
                  ),
                  onTap: () {},
                )),
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
