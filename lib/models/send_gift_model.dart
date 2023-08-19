class SendgiftModel {
  SendgiftModelData data;
  Null message;
  int status;

  SendgiftModel({this.data, this.message, this.status});

  SendgiftModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new SendgiftModelData.fromJson(json['data'])
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

class SendgiftModelData {
  User user;

  SendgiftModelData({this.user});

  SendgiftModelData.fromJson(Map<String, dynamic> json) {
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
  String entry;

  User({this.entry});

  User.fromJson(Map<String, dynamic> json) {
    entry = json['entry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entry'] = this.entry;
    return data;
  }
}
