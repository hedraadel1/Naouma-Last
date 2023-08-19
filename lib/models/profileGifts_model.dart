class ProfileGiftsModel {
  List<ProfileGiftsModelData> data;
  Null message;
  int status;

  ProfileGiftsModel({this.data, this.message, this.status});

  ProfileGiftsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProfileGiftsModelData>[];
      json['data'].forEach((v) {
        data.add(new ProfileGiftsModelData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class ProfileGiftsModelData {
  int count;
  int id;
  String name;
  String type;
  String giftLink;
  int price;
  String createdAt;
  String updatedAt;
  String url;
  Pivot pivot;

  ProfileGiftsModelData(
      {this.count,
      this.id,
      this.name,
      this.type,
      this.giftLink,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.url,
      this.pivot});

  ProfileGiftsModelData.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    id = json['id'];
    name = json['name'];
    type = json['type'];
    giftLink = json['gift_link'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['gift_link'] = this.giftLink;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int fromUserId;
  int shopId;

  Pivot({this.fromUserId, this.shopId});

  Pivot.fromJson(Map<String, dynamic> json) {
    fromUserId = json['from_user_id'];
    shopId = json['shop_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_user_id'] = this.fromUserId;
    data['shop_id'] = this.shopId;
    return data;
  }
}
