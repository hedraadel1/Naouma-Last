class NotificationModel {
  NotificationModelData data;
  Null message;
  int status;

  NotificationModel({this.data, this.message, this.status});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new NotificationModelData.fromJson(json['data'])
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

class NotificationModelData {
  User user;

  NotificationModelData({this.user});

  NotificationModelData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int follow;
  String entry;
  String background;

  User({this.follow, this.entry, this.background});

  User.fromJson(Map<String, dynamic> json) {
    follow = json['follow'];
    entry = json['entry'];
    background = json['background'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['follow'] = this.follow;
    data['entry'] = this.entry;
    data['background'] = this.background;
    return data;
  }
}
