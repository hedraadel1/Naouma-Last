class MicModel {
  Data data;
  String message;
  int status;

  MicModel({this.data, this.message, this.status});

  MicModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  From from;
  Mic mic;

  Data({this.from, this.mic});

  Data.fromJson(Map<String, dynamic> json) {
    from = json['from_'] != null ? new From.fromJson(json['from_']) : null;
    mic = json['mic'] != null ? new Mic.fromJson(json['mic']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.from != null) {
      data['from_'] = this.from.toJson();
    }
    if (this.mic != null) {
      data['mic'] = this.mic.toJson();
    }
    return data;
  }
}

class From {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;
  Null fcmToken;
  String rule;
  Mic mic;
  Null image;
  String frame;

  From({
    this.id,
    this.name,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.userId,
    this.fcmToken,
    this.rule,
    this.mic,
    this.image,
    this.frame,
  });

  From.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
    fcmToken = json['fcm_token'];
    rule = json['rule'];
    image = json['image'];
    frame = json['frame'];
    mic = json['mic'] != null ? new Mic.fromJson(json['mic']) : null;
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
    data['image'] = this.image;
    data['frame'] = this.frame;
    if (this.mic != null) {
      data['mic'] = this.mic.toJson();
    }
    return data;
  }
}

class Mic {
  int id;
  int roomId;
  int micNumber;
  bool mute;
  bool isLocked;
  int roomOwnerId;
  int micUserId;
  String createdAt;
  String updatedAt;

  Mic(
      {this.id,
      this.roomId,
      this.micNumber,
      this.mute,
      this.isLocked,
      this.roomOwnerId,
      this.micUserId,
      this.createdAt,
      this.updatedAt});

  Mic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    micNumber = json['mic_number'];
    mute = json['mute'];
    isLocked = json['is_locked'];
    roomOwnerId = json['room_owner_id'];
    micUserId = json['mic_user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['room_id'] = this.roomId;
    data['mic_number'] = this.micNumber;
    data['mute'] = this.mute;
    data['is_locked'] = this.isLocked;
    data['room_owner_id'] = this.roomOwnerId;
    data['mic_user_id'] = this.micUserId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
