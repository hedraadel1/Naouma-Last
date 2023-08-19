class GetUserExpModel {
  GetUserExpModelData data;
  String message;
  int status;

  GetUserExpModel({this.data, this.message, this.status});

  GetUserExpModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new GetUserExpModelData.fromJson(json['data'])
        : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}

class GetUserExpModelData {
  int id;
  int userId;
  int userCurrentExp;
  int userCurrentLevel;
  String createdAt;
  String updatedAt;
  Level level;

  GetUserExpModelData(
      {this.id,
      this.userId,
      this.userCurrentExp,
      this.userCurrentLevel,
      this.createdAt,
      this.updatedAt,
      this.level});

  GetUserExpModelData.fromJson(Map<String, dynamic> json) {
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

class Level {
  int id;
  int number;
  int value;
  String createdAt;
  String updatedAt;

  Level({this.id, this.number, this.value, this.createdAt, this.updatedAt});

  Level.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    value = json['value'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['number'] = this.number;
    data['value'] = this.value;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
