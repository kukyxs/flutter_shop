class CategoryEntity {
  String code;
  String message;
  List<CategoryData> data;

  static CategoryEntity fromMap(Map<String, dynamic> map) {
    CategoryEntity category = new CategoryEntity();
    category.code = map['code'];
    category.message = map['message'];
    category.data = CategoryData.fromMapList(map['data']);
    return category;
  }

  static List<CategoryEntity> fromMapList(dynamic mapList) {
    List<CategoryEntity> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class CategoryData {
  String mallCategoryId;
  String mallCategoryName;
  String image;
  List<BxMallSubDtoListBean> bxMallSubDto;

  static CategoryData fromMap(Map<String, dynamic> map) {
    CategoryData dataListBean = new CategoryData();
    dataListBean.mallCategoryId = map['mallCategoryId'];
    dataListBean.mallCategoryName = map['mallCategoryName'];
    dataListBean.image = map['image'];
    dataListBean.bxMallSubDto = BxMallSubDtoListBean.fromMapList(map['bxMallSubDto']);
    return dataListBean;
  }

  static List<CategoryData> fromMapList(dynamic mapList) {
    List<CategoryData> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class BxMallSubDtoListBean {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  static BxMallSubDtoListBean fromMap(Map<String, dynamic> map) {
    BxMallSubDtoListBean bxMallSubDtoListBean = new BxMallSubDtoListBean();
    bxMallSubDtoListBean.mallSubId = map['mallSubId'];
    bxMallSubDtoListBean.mallCategoryId = map['mallCategoryId'];
    bxMallSubDtoListBean.mallSubName = map['mallSubName'];
    bxMallSubDtoListBean.comments = map['comments'];
    return bxMallSubDtoListBean;
  }

  static List<BxMallSubDtoListBean> fromMapList(dynamic mapList) {
    List<BxMallSubDtoListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
