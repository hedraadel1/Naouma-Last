class CreateUserModel {
  String name;
  String phone;
  String uid;

  CreateUserModel({
    this.name,
    this.phone,
    this.uid,
  });
  CreateUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    uid = json['uid'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'uid': uid,
    };
  }
}
