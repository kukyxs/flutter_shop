import 'package:flutter/material.dart';
import 'package:flutter_shop/entities/home_page_entity.dart';
import 'package:flutter_shop/provides/page_index_provide.dart';
import 'package:provide/provide.dart';

class TopNavigatorBar extends StatelessWidget {
  final List<Category> categories;

  TopNavigatorBar({Key key, @required this.categories}) : super(key: key);

  Widget _buildCategoryItem(BuildContext context, Category item) {
    return InkWell(
      onTap: () {
        Provide.value<PageIndexProvide>(context).changePage(1);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(item.image, width: MediaQuery.of(context).size.width / 8),
          Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Text(item.mallCategoryName, style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (categories.length > 10) categories.removeRange(10, categories.length);
    return SliverToBoxAdapter(
      child: SizedBox(
        height: MediaQuery.of(context).size.width * 2 / 5,
        child: GridView.count(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          childAspectRatio: 1.0,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 5,
          children: categories.map((item) => _buildCategoryItem(context, item)).toList(),
        ),
      ),
    );
  }
}
