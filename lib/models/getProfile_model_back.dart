class GetProfileModel {
  bool success;
  List<ProfileData> data = [];
  int follow;
  int followMe;
  int status;

  GetProfileModel(
      {this.success, this.data, this.follow, this.followMe, this.status});

  GetProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProfileData>[];
      json['data'].forEach((v) {
        data.add(new ProfileData.fromJson(v));
      });
    }
    follow = json['follow'];
    followMe = json['follow_me'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['follow'] = this.follow;
    data['follow_me'] = this.followMe;
    data['status'] = this.status;
    return data;
  }
}

class ProfileData {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  Info info;
  Wallet wallet;
  Level level;

  ProfileData(
      {this.id,
      this.name,
      this.mobile,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.info,
      this.wallet,
      this.level});

  ProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
    wallet =
        json['wallet'] != null ? new Wallet.fromJson(json['wallet']) : null;
    level = json['level'] != null ? new Level.fromJson(json['level']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user_id'] = this.userId;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    if (this.wallet != null) {
      data['wallet'] = this.wallet.toJson();
    }
    if (this.level != null) {
      data['level'] = this.level.toJson();
    }
    return data;
  }
}

class Info {
  int id;
  int userId;
  Null avatar;
  Null company;
  Null phone;
  Null website;
  Null country;
  Null language;
  Null timezone;
  Null currency;
  Null communication;
  Null marketing;
  String createdAt;
  String updatedAt;
  String avatarUrl;

  Info(
      {this.id,
      this.userId,
      this.avatar,
      this.company,
      this.phone,
      this.website,
      this.country,
      this.language,
      this.timezone,
      this.currency,
      this.communication,
      this.marketing,
      this.createdAt,
      this.updatedAt,
      this.avatarUrl});

  Info.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    avatar = json['avatar'];
    company = json['company'];
    phone = json['phone'];
    website = json['website'];
    country = json['country'];
    language = json['language'];
    timezone = json['timezone'];
    currency = json['currency'];
    communication = json['communication'];
    marketing = json['marketing'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    avatarUrl = json['avatar_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['avatar'] = this.avatar;
    data['company'] = this.company;
    data['phone'] = this.phone;
    data['website'] = this.website;
    data['country'] = this.country;
    data['language'] = this.language;
    data['timezone'] = this.timezone;
    data['currency'] = this.currency;
    data['communication'] = this.communication;
    data['marketing'] = this.marketing;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }
}

class Wallet {
  int id;
  int walletUserId;
  int walletAmount;
  String createdAt;
  String updatedAt;

  Wallet(
      {this.id,
      this.walletUserId,
      this.walletAmount,
      this.createdAt,
      this.updatedAt});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    walletUserId = json['wallet_user_id'];
    walletAmount = json['wallet_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['wallet_user_id'] = this.walletUserId;
    data['wallet_amount'] = this.walletAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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
    if (this.level != null) {
      data['level'] = this.level.toJson();
    }
    return data;
  }
}

class LevelL {
  int id;
  int number;
  int value;
  String createdAt;
  String updatedAt;

  LevelL({this.id, this.number, this.value, this.createdAt, this.updatedAt});

  LevelL.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
