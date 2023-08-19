class CreateRoomModel {
  Data data;
  Null message;
  int status;

  CreateRoomModel({this.data, this.message, this.status});

  CreateRoomModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }
}

class Data {
  String roomName;
  String roomDesc;
  String roomBackground;
  int roomOwner;
  String updatedAt;
  String createdAt;
  int id;
  int countUsersIntoRoom;
  String backgroundUrl;

  Data(
      {this.roomName,
      this.roomDesc,
      this.roomBackground,
      this.roomOwner,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.countUsersIntoRoom,
      this.backgroundUrl});

  Data.fromJson(Map<String, dynamic> json) {
    roomName = json['room_name'];
    roomDesc = json['room_desc'];
    roomBackground = json['room_background'];
    roomOwner = json['room_owner'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    countUsersIntoRoom = json['countUsersIntoRoom'];
    backgroundUrl = json['background_url'];
  }
}
