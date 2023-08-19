class AcceptRequestsModel {
  Null data;
  String message;
  int status;

  AcceptRequestsModel({this.data, this.message, this.status});

  AcceptRequestsModel.fromJson(Map<String, dynamic> json) {
    data = json['data'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
