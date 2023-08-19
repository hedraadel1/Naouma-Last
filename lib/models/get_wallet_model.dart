class GetWalletModel {
  GetWalletData data;
  String message;
  int status;

  GetWalletModel({this.data, this.message, this.status});

  GetWalletModel.fromJson(Map<String, dynamic> json) {
    data =
    json['data'] != null ? new GetWalletData.fromJson(json['data']) : null;
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

class GetWalletData {
  int walletAmount;

  GetWalletData({this.walletAmount});

  GetWalletData.fromJson(Map<String, dynamic> json) {
    walletAmount = json['wallet_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_amount'] = this.walletAmount;
    return data;
  }
}
