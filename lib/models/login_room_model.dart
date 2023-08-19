class LoginRoomModel {
  LoginRoomModelData data;
  Null message;
  int status;

  LoginRoomModel({this.data, this.message, this.status});

  LoginRoomModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new LoginRoomModelData.fromJson(json['data'])
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

class LoginRoomModelData {
  int id;
  String roomName;
  String roomDesc;
  String roomBackground;
  int roomOwner;
  Null country;
  String createdAt;
  String updatedAt;
  Null password;
  int countMics;
  int countSupervisor;
  Null lockId;
  Null roomId;
  int countUsers;
  String backgroundUrl;

  LoginRoomModelData(
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
      this.countUsers,
      this.backgroundUrl});

  LoginRoomModelData.fromJson(Map<String, dynamic> json) {
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
    countUsers = json['count_users'];
    backgroundUrl = json['background_url'];
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
    data['count_users'] = this.countUsers;
    data['background_url'] = this.backgroundUrl;
    return data;
  }
}
