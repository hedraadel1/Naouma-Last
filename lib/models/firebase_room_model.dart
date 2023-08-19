/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

class RoomModel {
  String roomname;
  String roomDesc;
  String roomID;
  int userNow;

  RoomModel({
    this.roomname,
    this.roomDesc,
    this.roomID,
    this.userNow,
  });

  RoomModel.fromJson(Map<String, dynamic> json) {
    roomname = json['roomname'];
    roomDesc = json['roomDesc'];
    roomID = json['roomID'];
    userNow = json['userNow'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': roomname,
      'roomDesc': roomDesc,
      'roomID': roomID,
      'userNow': userNow
    };
  }
}
