// import 'package:project/models/mics_model.dart';

// class BlockListModel {
//   List<Data> data;
//   Null message;
//   int status;

//   BlockListModel({this.data, this.message, this.status});

//   BlockListModel.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data.add(new Data.fromJson(v));
//       });
//     }
//     message = json['message'];
//     status = json['status'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data.map((v) => v.toJson()).toList();
//     }
//     data['message'] = this.message;
//     data['status'] = this.status;
//     return data;
//   }
// }

// class Data {}

class BlockListModel {
  List<BlockListModelData> data;
  Null message;
  int status;

  BlockListModel({this.data, this.message, this.status});

  BlockListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <BlockListModelData>[];
      json['data'].forEach((v) {
        data.add(new BlockListModelData.fromJson(v));
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

class BlockListModelData {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  String fcmToken;
  String rule;
  Pivot pivot;

  BlockListModelData(
      {this.id,
      this.name,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fcmToken,
      this.rule,
      this.pivot});

  BlockListModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    fcmToken = json['fcm_token'];
    rule = json['rule'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    data['fcm_token'] = this.fcmToken;
    data['rule'] = this.rule;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int roomId;
  int userId;
  String createdAt;
  String updatedAt;

  Pivot({this.roomId, this.userId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    roomId = json['room_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.roomId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
