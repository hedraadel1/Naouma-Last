
class RoomUserModel{
  String userId;
  String userName;

  RoomUserModel({this.userId, this.userName});

  RoomUserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
  }
}