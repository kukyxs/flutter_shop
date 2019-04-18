import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';

class TopNavigatorBar extends StatelessWidget {
  final List<Category> categories;

  TopNavigatorBar({Key key, @required this.categories}) : super(key: key);

  Widget _buildCategoryItem(BuildContext context, Category item) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [Image.network(item.image, width: ScreenUtil().setWidth(95)), Text(item.mallCategoryName)],
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
