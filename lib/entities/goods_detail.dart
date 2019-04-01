class GoodsDetailModel {
  String code;
  String message;
  GoodDetailInfo data;

  static GoodsDetailModel fromMap(Map<String, dynamic> map) {
    GoodsDetailModel detail = new GoodsDetailModel();
    detail.code = map['code'];
    detail.message = map['message'];
    detail.data = GoodDetailInfo.fromMap(map['data']);
    return detail;
  }

  static List<GoodsDetailModel> fromMapList(dynamic mapList) {
    List<GoodsDetailModel> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class GoodDetailInfo {
  AdvertesPictureBean advertesPicture;
  GoodInfoBean goodInfo;

  static GoodDetailInfo fromMap(Map<String, dynamic> map) {
    GoodDetailInfo dataBean = new GoodDetailInfo();
    dataBean.advertesPicture = AdvertesPictureBean.fromMap(map['advertesPicture']);
    dataBean.goodInfo = GoodInfoBean.fromMap(map['goodInfo']);
    return dataBean;
  }

  static List<GoodDetailInfo> fromMapList(dynamic mapList) {
    List<GoodDetailInfo> list = new List(mapList.length);
    for (int i = 0; i < mapList.length; i++) {
      list[i] = fromMap(mapList[i]);
    }
    return list;
  }
}

class AdvertesPictureBean {
  String PICTURE_ADDRESS;
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
  double oriPrice;
  double presentPrice;
  int amount;
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
    goodInfoBean.oriPrice = map['oriPrice'];
    goodInfoBean.presentPrice = map['presentPrice'];
    goodInfoBean.amount = map['amount'];
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
