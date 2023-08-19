/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class FramesModel {
  List<FrameData> data;
  String message;
  int status;

  FramesModel({this.data, this.message, this.status});

  FramesModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <FrameData>[];
      json['data'].forEach((v) {
        data.add(new FrameData.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }
}

class FrameData {
  int id;
  String name;
  String type;
  String giftLink;
  int price;
  String createdAt;
  String updatedAt;
  String url;

  FrameData(
      {this.id,
      this.name,
      this.type,
      this.giftLink,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.url});

  FrameData.fromJson(Map<String, dynamic> json) {
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
