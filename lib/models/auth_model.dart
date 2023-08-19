import 'package:flutter/material.dart';

class AuthModel {
  String accessToken;
  String tokenType;
  int expiresIn;
  UserData user;

  AuthModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    user = json['user'] != null ? new UserData.fromJson(json['user']) : null;
  }
}

class UserData {
  int id;
  String name;
  String mobile;
  String createdAt;
  String updatedAt;
  String userId;

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['user_id'];
  }
}
