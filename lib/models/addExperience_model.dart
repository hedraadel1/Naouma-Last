class AddExpModel {
  bool success;
  int currentExp;
  int currentLevel;
  int status;

  AddExpModel({this.success, this.currentExp, this.currentLevel, this.status});

  AddExpModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    currentExp = json['current_exp'];
    currentLevel = json['current_level'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['current_exp'] = this.currentExp;
    data['current_level'] = this.currentLevel;
    data['status'] = this.status;
    return data;
  }
}
