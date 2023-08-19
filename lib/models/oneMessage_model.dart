class OneMasseageModel {
  String senderId;
  String reciverId;
  String datatime;
  String text;

  OneMasseageModel({this.senderId, this.reciverId, this.datatime, this.text});
  OneMasseageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    reciverId = json['reciverId'];
    datatime = json['datatime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'reciverId': reciverId,
      'datatime': datatime,
      'text': text,
    };
  }
}
