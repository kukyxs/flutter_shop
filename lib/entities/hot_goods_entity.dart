class HotGoodsEntity {
  String code;
  String message;
  List<HotGoodsData> data;

  HotGoodsEntity({this.code, this.message, this.data});

  HotGoodsEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = new List<HotGoodsData>();
      json['data'].forEach((v) {
        data.add(new HotGoodsData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HotGoodsData {
  String name;
  String image;
  double mallPrice;
  String goodsId;
  double price;

  HotGoodsData({this.name, this.image, this.mallPrice, this.goodsId, this.price});

  HotGoodsData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    mallPrice = json['mallPrice'] + 0.0;
    goodsId = json['goodsId'];
    price = json['price'] + 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['mallPrice'] = this.mallPrice;
    data['goodsId'] = this.goodsId;
    data['price'] = this.price;
    return data;
  }

  static List<HotGoodsData> fromMapList(dynamic mapList) {
    List<HotGoodsData> list = [];
    mapList.forEach((map) {
      list.add(HotGoodsData.fromJson(map));
    });
    return list;
  }
}
