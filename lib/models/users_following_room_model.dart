/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class UserFollowingRoomModel {
  List<UserFollowingRoomModelData> data;
  String message;
  int status;

  UserFollowingRoomModel({this.data, this.message, this.status});

  UserFollowingRoomModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserFollowingRoomModelData>[];
      json['data'].forEach((v) {
        data.add(new UserFollowingRoomModelData.fromJson(v));
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

class UserFollowingRoomModelData {
  int id;
  String roomName;
  String roomDesc;
  String roomBackground;
  int roomOwner;
  Null country;
  String createdAt;
  String updatedAt;
  String password;
  int countMics;
  int countSupervisor;
  Null lockId;
  String roomId;
  Null firebaseId;
  int countUsers;
  String backgroundUrl;
  List<Followers> followers;

  UserFollowingRoomModelData(
      {this.id,
      this.roomName,
      this.roomDesc,
      this.roomBackground,
      this.roomOwner,
      this.country,
      this.createdAt,
      this.updatedAt,
      this.password,
      this.countMics,
      this.countSupervisor,
      this.lockId,
      this.roomId,
      this.firebaseId,
      this.countUsers,
      this.backgroundUrl,
      this.followers});

  UserFollowingRoomModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomName = json['room_name'];
    roomDesc = json['room_desc'];
    roomBackground = json['room_background'];
    roomOwner = json['room_owner'];
    country = json['country'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    password = json['password'];
    countMics = json['countMics'];
    countSupervisor = json['countSupervisor'];
    lockId = json['lock_id'];
    roomId = json['room_id'];
    firebaseId = json['firebase_id'];
    countUsers = json['count_users'];
    backgroundUrl = json['background_url'];
    if (json['followers'] != null) {
      followers = <Followers>[];
      json['followers'].forEach((v) {
        followers.add(new Followers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_name'] = this.roomName;
    data['room_desc'] = this.roomDesc;
    data['room_background'] = this.roomBackground;
    data['room_owner'] = this.roomOwner;
    data['country'] = this.country;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['password'] = this.password;
    data['countMics'] = this.countMics;
    data['countSupervisor'] = this.countSupervisor;
    data['lock_id'] = this.lockId;
    data['room_id'] = this.roomId;
    data['firebase_id'] = this.firebaseId;
    data['count_users'] = this.countUsers;
    data['background_url'] = this.backgroundUrl;
    if (this.followers != null) {
      data['followers'] = this.followers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Followers {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  String fcmToken;
  String rule;
  Pivot pivot;

  Followers(
      {this.id,
      this.name,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.fcmToken,
      this.rule,
      this.pivot});

  Followers.fromJson(Map<String, dynamic> json) {
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
