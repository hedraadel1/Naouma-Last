class ShowFriendsModel {
  List<ShowFriendsModelData> data;
  String message;
  int status;

  ShowFriendsModel({this.data, this.message, this.status});

  ShowFriendsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ShowFriendsModelData>[];
      json['data'].forEach((v) {
        data.add(new ShowFriendsModelData.fromJson(v));
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

class ShowFriendsModelData {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  String fcmToken;
  String rule;
  Pivot pivot;

  ShowFriendsModelData(
      {this.id,
      this.name,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fcmToken,
      this.rule,
      this.pivot});

  ShowFriendsModelData.fromJson(Map<String, dynamic> json) {
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
  int userId;
  int friendId;

  Pivot({this.userId, this.friendId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    friendId = json['friend_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['friend_id'] = this.friendId;
    return data;
  }
}
