class GoodsDetailEntity {
  String code;
  String message;
  GoodsDetailInfo data;

  static GoodsDetailEntity fromMap(Map<String, dynamic> map) {
    GoodsDetailEntity model = new GoodsDetailEntity();
    model.code = map['code'];
    model.message = map['message'];
    model.data = GoodsDetailInfo.fromMap(map['data']);
    return model;
  }

  static List<GoodsDetailEntity> fromMapList(dynamic mapList) {
    List<GoodsDetailEntity> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GoodsDetailInfo {
  AdvertesPictureBean advertesPicture;
  GoodInfoBean goodInfo;
  List<GoodCommentsListBean> goodComments;

  static GoodsDetailInfo fromMap(Map<String, dynamic> map) {
    GoodsDetailInfo dataBean = new GoodsDetailInfo();
    dataBean.advertesPicture = AdvertesPictureBean.fromMap(map['advertesPicture']);
    dataBean.goodInfo = GoodInfoBean.fromMap(map['goodInfo']);
    dataBean.goodComments = GoodCommentsListBean.fromMapList(map['goodComments']);
    return dataBean;
  }

  static List<GoodsDetailInfo> fromMapList(dynamic mapList) {
    List<GoodsDetailInfo> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class AdvertesPictureBean {
  // ignore: non_constant_identifier_names
  String PICTURE_ADDRESS;

  // ignore: non_constant_identifier_names
  String TO_PLACE;

  static AdvertesPictureBean fromMap(Map<String, dynamic> map) {
    AdvertesPictureBean advertesPictureBean = new AdvertesPictureBean();
    advertesPictureBean.PICTURE_ADDRESS = map['PICTURE_ADDRESS'];
    advertesPictureBean.TO_PLACE = map['TO_PLACE'];
    return advertesPictureBean;
  }

  static List<AdvertesPictureBean> fromMapList(dynamic mapList) {
    List<AdvertesPictureBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GoodInfoBean {
  String image5;
  String image3;
  String image4;
  String goodsId;
  String isOnline;
  String image1;
  String image2;
  String goodsSerialNumber;
  String comPic;
  String shopId;
  String goodsName;
  String goodsDetail;
  int amount;
  double oriPrice;
  double presentPrice;
  int state;

  static GoodInfoBean fromMap(Map<String, dynamic> map) {
    GoodInfoBean goodInfoBean = new GoodInfoBean();
    goodInfoBean.image5 = map['image5'];
    goodInfoBean.image3 = map['image3'];
    goodInfoBean.image4 = map['image4'];
    goodInfoBean.goodsId = map['goodsId'];
    goodInfoBean.isOnline = map['isOnline'];
    goodInfoBean.image1 = map['image1'];
    goodInfoBean.image2 = map['image2'];
    goodInfoBean.goodsSerialNumber = map['goodsSerialNumber'];
    goodInfoBean.comPic = map['comPic'];
    goodInfoBean.shopId = map['shopId'];
    goodInfoBean.goodsName = map['goodsName'];
    goodInfoBean.goodsDetail = map['goodsDetail'];
    goodInfoBean.amount = map['amount'];
    goodInfoBean.oriPrice = map['oriPrice'] + 0.0;
    goodInfoBean.presentPrice = map['presentPrice'] + 0.0;
    goodInfoBean.state = map['state'];
    return goodInfoBean;
  }

  static List<GoodInfoBean> fromMapList(dynamic mapList) {
    List<GoodInfoBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GoodCommentsListBean {
  String comments;
  String userName;

  // ignore: non_constant_identifier_names
  int SCORE;
  int discussTime;

  static GoodCommentsListBean fromMap(Map<String, dynamic> map) {
    GoodCommentsListBean goodCommentsListBean = new GoodCommentsListBean();
    goodCommentsListBean.comments = map['comments'];
    goodCommentsListBean.userName = map['userName'];
    goodCommentsListBean.SCORE = map['SCORE'];
    goodCommentsListBean.discussTime = map['discussTime'];
    return goodCommentsListBean;
  }

  static List<GoodCommentsListBean> fromMapList(dynamic mapList) {
    List<GoodCommentsListBean> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}
