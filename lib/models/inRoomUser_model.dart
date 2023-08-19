class InroomUserrModel {
  String name;
  String phone;
  String roomid;

  InroomUserrModel({
    this.name,
    this.phone,
    this.roomid,
  });
  InroomUserrModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    roomid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uid': roomid,
    };
  }
}
