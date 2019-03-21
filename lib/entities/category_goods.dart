class CategoryGoodsBean {
  String code;
  String message;
  List<CategoryGoodsInfo> data;

  static CategoryGoodsBean fromMap(Map<String, dynamic> map) {
    CategoryGoodsBean bean = new CategoryGoodsBean();
    bean.code = map['code'];
    bean.message = map['message'];
    bean.data = CategoryGoodsInfo.fromMapList(map['data']);
    return bean;
  }

  static List<CategoryGoodsBean> fromMapList(dynamic mapList) {
    List<CategoryGoodsBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class CategoryGoodsInfo {
  String image;
  String goodsId;
  String goodsName;
  double oriPrice;
  double presentPrice;

  static CategoryGoodsInfo fromMap(Map<String, dynamic> map) {
    CategoryGoodsInfo dataListBean = new CategoryGoodsInfo();
    dataListBean.image = map['image'];
    dataListBean.goodsId = map['goodsId'];
    dataListBean.goodsName = map['goodsName'];
    dataListBean.oriPrice = map['oriPrice'] + 0.0;
    dataListBean.presentPrice = map['presentPrice'] + 0.0;
    return dataListBean;
  }

  static List<CategoryGoodsInfo> fromMapList(dynamic mapList) {
    List<CategoryGoodsInfo> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
