class HomePageEntity {
  String code;
  String message;
  HomeData data;

  HomePageEntity({this.code, this.message, this.data});

  HomePageEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new HomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class HomeData {
  List<Slides> slides;
  ShopInfo shopInfo;
  IntegralMallPic integralMallPic;
  ToShareCode toShareCode;
  List<Recommend> recommend;
  AdvertesPicture advertesPicture;
  List<Floor> floor1;
  List<Floor> floor2;
  List<Floor> floor3;
  Saoma saoma;
  NewUser newUser;
  Floor1Pic floor1Pic;
  Floor2Pic floor2Pic;
  FloorName floorName;
  List<Category> category;
  Floor3Pic floor3Pic;

  HomeData(
      {this.slides,
      this.shopInfo,
      this.integralMallPic,
      this.toShareCode,
      this.recommend,
      this.advertesPicture,
      this.floor1,
      this.floor2,
      this.floor3,
      this.saoma,
      this.newUser,
      this.floor1Pic,
      this.floor2Pic,
      this.floorName,
      this.category,
      this.floor3Pic});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['slides'] != null) {
      slides = new List<Slides>();
      json['slides'].forEach((v) {
        slides.add(new Slides.fromJson(v));
      });
    }
    shopInfo = json['shopInfo'] != null ? new ShopInfo.fromJson(json['shopInfo']) : null;
    integralMallPic = json['integralMallPic'] != null ? new IntegralMallPic.fromJson(json['integralMallPic']) : null;
    toShareCode = json['toShareCode'] != null ? new ToShareCode.fromJson(json['toShareCode']) : null;
    if (json['recommend'] != null) {
      recommend = new List<Recommend>();
      json['recommend'].forEach((v) {
        recommend.add(new Recommend.fromJson(v));
      });
    }
    advertesPicture = json['advertesPicture'] != null ? new AdvertesPicture.fromJson(json['advertesPicture']) : null;
    if (json['floor1'] != null) {
      floor1 = new List<Floor>();
      json['floor1'].forEach((v) {
        floor1.add(new Floor.fromJson(v));
      });
    }
    if (json['floor2'] != null) {
      floor2 = new List<Floor>();
      json['floor2'].forEach((v) {
        floor2.add(new Floor.fromJson(v));
      });
    }
    if (json['floor3'] != null) {
      floor3 = new List<Floor>();
      json['floor3'].forEach((v) {
        floor3.add(new Floor.fromJson(v));
      });
    }
    saoma = json['saoma'] != null ? new Saoma.fromJson(json['saoma']) : null;
    newUser = json['newUser'] != null ? new NewUser.fromJson(json['newUser']) : null;
    floor1Pic = json['floor1Pic'] != null ? new Floor1Pic.fromJson(json['floor1Pic']) : null;
    floor2Pic = json['floor2Pic'] != null ? new Floor2Pic.fromJson(json['floor2Pic']) : null;
    floorName = json['floorName'] != null ? new FloorName.fromJson(json['floorName']) : null;
    if (json['category'] != null) {
      category = new List<Category>();
      json['category'].forEach((v) {
        category.add(new Category.fromJson(v));
      });
    }
    floor3Pic = json['floor3Pic'] != null ? new Floor3Pic.fromJson(json['floor3Pic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.slides != null) {
      data['slides'] = this.slides.map((v) => v.toJson()).toList();
    }
    if (this.shopInfo != null) {
      data['shopInfo'] = this.shopInfo.toJson();
    }
    if (this.integralMallPic != null) {
      data['integralMallPic'] = this.integralMallPic.toJson();
    }
    if (this.toShareCode != null) {
      data['toShareCode'] = this.toShareCode.toJson();
    }
    if (this.recommend != null) {
      data['recommend'] = this.recommend.map((v) => v.toJson()).toList();
    }
    if (this.advertesPicture != null) {
      data['advertesPicture'] = this.advertesPicture.toJson();
    }
    if (this.floor1 != null) {
      data['floor1'] = this.floor1.map((v) => v.toJson()).toList();
    }
    if (this.floor2 != null) {
      data['floor2'] = this.floor2.map((v) => v.toJson()).toList();
    }
    if (this.floor3 != null) {
      data['floor3'] = this.floor3.map((v) => v.toJson()).toList();
    }
    if (this.saoma != null) {
      data['saoma'] = this.saoma.toJson();
    }
    if (this.newUser != null) {
      data['newUser'] = this.newUser.toJson();
    }
    if (this.floor1Pic != null) {
      data['floor1Pic'] = this.floor1Pic.toJson();
    }
    if (this.floor2Pic != null) {
      data['floor2Pic'] = this.floor2Pic.toJson();
    }
    if (this.floorName != null) {
      data['floorName'] = this.floorName.toJson();
    }
    if (this.category != null) {
      data['category'] = this.category.map((v) => v.toJson()).toList();
    }
    if (this.floor3Pic != null) {
      data['floor3Pic'] = this.floor3Pic.toJson();
    }
    return data;
  }
}

class Slides {
  String image;
  String goodsId;

  Slides({this.image, this.goodsId});

  Slides.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

class ShopInfo {
  String leaderImage;
  String leaderPhone;

  ShopInfo({this.leaderImage, this.leaderPhone});

  ShopInfo.fromJson(Map<String, dynamic> json) {
    leaderImage = json['leaderImage'];
    leaderPhone = json['leaderPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['leaderImage'] = this.leaderImage;
    data['leaderPhone'] = this.leaderPhone;
    return data;
  }
}

class IntegralMallPic {
  String pICTUREADDRESS;
  String tOPLACE;

  IntegralMallPic({this.pICTUREADDRESS, this.tOPLACE});

  IntegralMallPic.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class ToShareCode {
  String pICTUREADDRESS;
  String tOPLACE;

  ToShareCode({this.pICTUREADDRESS, this.tOPLACE});

  ToShareCode.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class Recommend {
  String image;
  double mallPrice;
  String goodsName;
  String goodsId;
  double price;

  Recommend({this.image, this.mallPrice, this.goodsName, this.goodsId, this.price});

  Recommend.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    mallPrice = json['mallPrice'] + 0.0;
    goodsName = json['goodsName'];
    goodsId = json['goodsId'];
    price = json['price'] + 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['mallPrice'] = this.mallPrice;
    data['goodsName'] = this.goodsName;
    data['goodsId'] = this.goodsId;
    data['price'] = this.price;
    return data;
  }
}

class AdvertesPicture {
  String pICTUREADDRESS;
  String tOPLACE;

  AdvertesPicture({this.pICTUREADDRESS, this.tOPLACE});

  AdvertesPicture.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class Floor {
  String image;
  String goodsId;

  Floor({this.image, this.goodsId});

  Floor.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['goodsId'] = this.goodsId;
    return data;
  }
}

class Saoma {
  String pICTUREADDRESS;
  String tOPLACE;

  Saoma({this.pICTUREADDRESS, this.tOPLACE});

  Saoma.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class NewUser {
  String pICTUREADDRESS;
  String tOPLACE;

  NewUser({this.pICTUREADDRESS, this.tOPLACE});

  NewUser.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class Floor1Pic {
  String pICTUREADDRESS;
  String tOPLACE;

  Floor1Pic({this.pICTUREADDRESS, this.tOPLACE});

  Floor1Pic.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class Floor2Pic {
  String pICTUREADDRESS;
  String tOPLACE;

  Floor2Pic({this.pICTUREADDRESS, this.tOPLACE});

  Floor2Pic.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}

class FloorName {
  String floor1;
  String floor2;
  String floor3;

  FloorName({this.floor1, this.floor2, this.floor3});

  FloorName.fromJson(Map<String, dynamic> json) {
    floor1 = json['floor1'];
    floor2 = json['floor2'];
    floor3 = json['floor3'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['floor1'] = this.floor1;
    data['floor2'] = this.floor2;
    data['floor3'] = this.floor3;
    return data;
  }
}

class Category {
  String mallCategoryId;
  String mallCategoryName;
  List<BxMallSubDto> bxMallSubDto;
  Null comments;
  String image;

  Category({this.mallCategoryId, this.mallCategoryName, this.bxMallSubDto, this.comments, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    mallCategoryId = json['mallCategoryId'];
    mallCategoryName = json['mallCategoryName'];
    if (json['bxMallSubDto'] != null) {
      bxMallSubDto = new List<BxMallSubDto>();
      json['bxMallSubDto'].forEach((v) {
        bxMallSubDto.add(new BxMallSubDto.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class BxMallSubDto {
  String mallSubId;
  String mallCategoryId;
  String mallSubName;
  String comments;

  BxMallSubDto({this.mallSubId, this.mallCategoryId, this.mallSubName, this.comments});

  BxMallSubDto.fromJson(Map<String, dynamic> json) {
    mallSubId = json['mallSubId'];
    mallCategoryId = json['mallCategoryId'];
    mallSubName = json['mallSubName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallSubId'] = this.mallSubId;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubName'] = this.mallSubName;
    data['comments'] = this.comments;
    return data;
  }
}

class Floor3Pic {
  String pICTUREADDRESS;
  String tOPLACE;

  Floor3Pic({this.pICTUREADDRESS, this.tOPLACE});

  Floor3Pic.fromJson(Map<String, dynamic> json) {
    pICTUREADDRESS = json['PICTURE_ADDRESS'];
    tOPLACE = json['TO_PLACE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PICTURE_ADDRESS'] = this.pICTUREADDRESS;
    data['TO_PLACE'] = this.tOPLACE;
    return data;
  }
}
