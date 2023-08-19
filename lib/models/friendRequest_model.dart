class FriendRequestsModel {
  Null data;
  List<Message> message;
  int status;

  FriendRequestsModel({this.data, this.message, this.status});

  FriendRequestsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    if (json['message'] != null) {
      message = <Message>[];
      json['message'].forEach((v) {
        message.add(new Message.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    if (this.message != null) {
      data['message'] = this.message.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Message {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  String fcmToken;
  String rule;
  Pivot pivot;

  Message(
      {this.id,
      this.name,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fcmToken,
      this.rule,
      this.pivot});

  Message.fromJson(Map<String, dynamic> json) {
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
  int friendId;
  int userId;

  Pivot({this.friendId, this.userId});

  Pivot.fromJson(Map<String, dynamic> json) {
    friendId = json['friend_id'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['friend_id'] = this.friendId;
    data['user_id'] = this.userId;
    return data;
  }
}
