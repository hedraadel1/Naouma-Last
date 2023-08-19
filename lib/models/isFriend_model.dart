class IsFriendFirebaseModel {
  String senderId;
  String reciverId;
  String name;

  bool isfriend;

  IsFriendFirebaseModel(
      {this.senderId, this.reciverId, this.isfriend, this.name});
  IsFriendFirebaseModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    isfriend = json['isfriend'];
    name = json['name'];
  }
  Map<String, dynamic> toMap() {
    return {
      'userID': senderId,
      'isfriend': isfriend,
      'name': name,
    };
  }
}
