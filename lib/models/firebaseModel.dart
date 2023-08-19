class FirebaseModel {
  String image;
  String shopid;
  String fromuserid;

  FirebaseModel({
    this.image,
    this.shopid,
    this.fromuserid,
  });
  FirebaseModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    shopid = json['shop_id'];
    fromuserid = json['from_user_id'];
  }
  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'shop_id': shopid,
      'from_user_id': fromuserid,
    };
  }
}
