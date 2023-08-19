class IsFollowModel {
  bool success;
  int user;
  String roomName;
  int status;

  IsFollowModel({this.success, this.user, this.roomName, this.status});

  IsFollowModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    user = json['user'];
    roomName = json['room_name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['user'] = this.user;
    data['room_name'] = this.roomName;
    data['status'] = this.status;
    return data;
  }
}
