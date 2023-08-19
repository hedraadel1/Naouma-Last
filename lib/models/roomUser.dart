/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class InRoomUserModelModel {
  List<InRoomUserModelModelData> data;
  int message;
  int status;

  InRoomUserModelModel({this.data, this.message, this.status});

  InRoomUserModelModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <InRoomUserModelModelData>[];
      json['data'].forEach((v) {
        data.add(new InRoomUserModelModelData.fromJson(v));
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

class InRoomUserModelModelData {
  Null avatar;
  int userId;
  String name;
  String spacialId;
  Level level;
  bool isFriend;
  List<Package> package;
  String typeUser;
  bool isPurchaseId;
  String frame;
  String frameUrl;
  String avatarUrl;

  InRoomUserModelModelData(
      {this.avatar,
      this.userId,
      this.name,
      this.spacialId,
      this.level,
      this.isFriend,
      this.package,
      this.typeUser,
      this.isPurchaseId,
      this.frame,
      this.frameUrl,
      this.avatarUrl});

  InRoomUserModelModelData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    userId = json['user_id'];
    name = json['name'];
    spacialId = json['spacial_id'];
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
    isFriend = json['is_friend'];
    if (json['package'] != null) {
      package = <Package>[];
      json['package'].forEach((v) {
        package.add(new Package.fromJson(v));
      });
    }
    typeUser = json['type_user'];
    isPurchaseId = json['is_purchase_id'];
    frame = json['frame'];
    frameUrl = json['frame_url'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['spacial_id'] = this.spacialId;
    if (this.level != null) {
      data['level'] = this.level.toJson();
    }
    data['is_friend'] = this.isFriend;
    if (this.package != null) {
      data['package'] = this.package.map((v) => v.toJson()).toList();
    }
    data['type_user'] = this.typeUser;
    data['is_purchase_id'] = this.isPurchaseId;
    data['frame'] = this.frame;
    data['frame_url'] = this.frameUrl;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class Level {
  int id;
  int userId;
  int userCurrentExp;
  int userCurrentLevel;
  String createdAt;
  String updatedAt;
  Level level;

  Level(
      {this.id,
      this.userId,
      this.userCurrentExp,
      this.userCurrentLevel,
      this.createdAt,
      this.updatedAt,
      this.level});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userCurrentExp = json['user_current_exp'];
    userCurrentLevel = json['user_current_level'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_current_exp'] = this.userCurrentExp;
    data['user_current_level'] = this.userCurrentLevel;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.level = null) {
      data['level'] = this.level.toJson();
    }
    return data;
  }
}

class Package {
  int id;
  String name;
  String color;
  String badge;
  int price;
  String createdAt;
  String updatedAt;
  Null nameAr;
  String url;
  Pivot pivot;

  Package(
      {this.id,
      this.name,
      this.color,
      this.badge,
      this.price,
      this.createdAt,
      this.updatedAt,
      this.nameAr,
      this.url,
      this.pivot});

  Package.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    color = json['color'];
    badge = json['badge'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    nameAr = json['name_ar'];
    url = json['url'];
    pivot = json['pivot'] != null ? new Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['color'] = this.color;
    data['badge'] = this.badge;
    data['price'] = this.price;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name_ar'] = this.nameAr;
    data['url'] = this.url;
    if (this.pivot != null) {
      data['pivot'] = this.pivot.toJson();
    }
    return data;
  }
}

class Pivot {
  int userId;
  int packageId;
  String createdAt;
  String updatedAt;

  Pivot({this.userId, this.packageId, this.createdAt, this.updatedAt});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    packageId = json['package_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['package_id'] = this.packageId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
