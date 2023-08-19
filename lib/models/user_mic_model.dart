class UserMicModel {
  String id;
  String userId;
  String userName;
  bool micStatus;
  bool isLocked;
  int micNumber;
  String roomOwnerId;

  UserMicModel(
      {this.id,
      this.userId,
      this.userName,
      this.micStatus,
      this.isLocked,
      this.micNumber,
      this.roomOwnerId});

  factory UserMicModel.fromJson(json) {
    return UserMicModel(
      id: json["id"],
      userId: json["userId"],
      userName: json["userName"],
      micStatus: json["micStatus"],
      isLocked: json["isLocked"],
      micNumber: json['micNumber'],
      roomOwnerId: json['roomOwnerId'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    json['id'] = this.id;
    json['userId'] = this.userId;
    json['userName'] = this.userName;
    json['micStatus'] = this.micStatus;
    json['isLocked'] = this.isLocked;
    json['micNumber'] = this.micNumber;
    json['roomOwnerId'] = this.roomOwnerId;
    return json;
  }
}
