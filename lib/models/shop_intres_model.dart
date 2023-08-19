/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class IntresModel {
  List<IntresData> data;
  String message;
  int status;

  IntresModel({this.data, this.message, this.status});

  IntresModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <IntresData>[];
      json['data'].forEach((v) {
        data.add(new IntresData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class IntresData {
  int id;
  String name;
  String type;
  String giftLink;
  int price;
  String createdAt;
  String updatedAt;
  String url;

  IntresData({this.id,
    this.name,
    this.type,
    this.giftLink,
    this.price,
    this.createdAt,
    this.updatedAt,
    this.url});

  IntresData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    giftLink = json['gift_link'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    url = json['url'];
  }
}
