import 'dart:async';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:project/auth_model.dart';

abstract class OnlineDatabaseRepository {
  // Sign in
  Future<Map<String, dynamic>> signInWithPhone({
    String phone,
  });
  Future<Map<String, dynamic>> signInWithFB(
      {String name, String email, String uId});

  // User Info
  Future<Map<String, dynamic>> getUserInfo({String token});
  Future<Map<String, dynamic>> updateUserInfo(
      {String token,
      File userImage,
      String gender,
      String birthDate,
      String city,
      String aboutUser});

  Future<Map<String, dynamic>> getCities();

  // ROOMS...
  Future<Map<String, dynamic>> popularRooms({int pageNum});
  Future<Map<String, dynamic>> followedRooms({String token, int pageNum});
  Future<Map<String, dynamic>> myCreatedRooms({String token, int pageNum});

  Future<Map<String, dynamic>> createRoom(
      {File imgFile, String roomName, String roomDesc});
  Future<Map<String, dynamic>> updateRoomData(
      {String roomId, File imgFile, String roomName, String roomDesc});

  // Moments...
  Future<Map<String, dynamic>> momentsSubjects();
  Future<Map<String, dynamic>> followSubject({String subjectId});
  Future<Map<String, dynamic>> shareAMoment(
      {String subjectName, File image, String location, String state});

  // Room Details
  Future<Map<String, dynamic>> roomDetails({String roomId});

  // Home Slider
  Future<Map<String, dynamic>> homeSlider();

  // Settings
  Future<AuthModel> logOut({String token});

  // Contact Us
  Future<Map<String, dynamic>> contactUs(
      String name, String email, String message);
}
