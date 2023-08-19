import 'package:project/models/mics_model.dart';

class ShopPurchaseModel {
  List<Data> data;
  String message;
  int status;

  ShopPurchaseModel({this.data, this.message, this.status});

  ShopPurchaseModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Null>[];
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
