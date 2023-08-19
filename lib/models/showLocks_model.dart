/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class ShowLocksModel {
  List<ShowLocksModelData> data;
  String message;
  int status;

  ShowLocksModel({this.data, this.message, this.status});

  ShowLocksModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowLocksModelData>[];
      json['data'].forEach((v) {
        data.add(new ShowLocksModelData.fromJson(v));
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

class ShowLocksModelData {
  int id;
  int price;
  String name;
  String nameAr;
  String logo;
  int expireDays;
  String createdAt;
  String updatedAt;

  ShowLocksModelData(
      {this.id,
      this.price,
      this.name,
      this.nameAr,
      this.logo,
      this.expireDays,
      this.createdAt,
      this.updatedAt});

  ShowLocksModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    name = json['name'];
    nameAr = json['name_ar'];
    logo = json['logo'];
    expireDays = json['expire_days'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    data['logo'] = this.logo;
    data['expire_days'] = this.expireDays;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
