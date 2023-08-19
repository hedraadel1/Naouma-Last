class AddSupervsorModel {
  // List<Null>? data;
  String message;
  int status;

  AddSupervsorModel({this.message, this.status});

  AddSupervsorModel.fromJson(Map<String, dynamic> json) {
    // if (json['data'] != null) {
    //   data = <Null>[];
    //   json['data'].forEach((v) {
    //     data!.add(new Null.fromJson(v));
    //   });
    // }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.data != null) {
    //   data['data'] = this.data!.map((v) => v.toJson()).toList();
    // }
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
