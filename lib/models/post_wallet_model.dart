class PostWalletModel {
  int walletAmount;
  String message;
  int status;

  PostWalletModel({this.walletAmount, this.message, this.status});

  PostWalletModel.fromJson(Map<String, dynamic> json) {
    walletAmount = json['wallet_amount'];
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wallet_amount'] = this.walletAmount;
    data['message'] = this.message;
    data['status'] = this.status;
    return data;
  }
}
