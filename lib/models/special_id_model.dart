/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class SpecialIDModel {
  List<Data> data;
  String message;
  int status;

  SpecialIDModel({this.data, this.message, this.status});

  SpecialIDModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int id;
  int value;
  int status;
  String badge;
  int price;
  int userId;
  String createdAt;
  String updatedAt;
  String url;

  Data(
      {this.id,
      this.value,
      this.status,
      this.badge,
      this.price,
      this.userId,
      this.createdAt,
      this.updatedAt,
      this.url});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    status = json['status'];
    badge = json['badge'];
    price = json['price'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['status'] = this.status;
    data['badge'] = this.badge;
    data['price'] = this.price;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['url'] = this.url;
    return data;
  }
}
