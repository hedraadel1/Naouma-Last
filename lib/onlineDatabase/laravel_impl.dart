/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:convert';

import '../auth_model.dart';
import 'online_database_repository.dart';

class LaravelImpl extends OnlineDatabaseRepository {
  String badStatusCode = "Wrong status code";
  final String baseUrl = "https://nauma.smartlys.online/public/api";
  final String loginWithPhonePath = "/login";
  final String loginWithFBPath = "/fc_login";
  final String signUpPath = "/register";
  final String logOutPath = "/auth/logout";
  final String categoriesPath = "/category/categories";
  final String settingsPath = "/setting/social_media_links";
  final String contactUsPath = "/setting/contact";
  final String createRoomPath = "/setting/contact";
  final String updateRoomPath = "/setting/contact";
  final String getUserDataPath = "/setting/contact";
  final String updateUserDataPath = "/setting/contact";
  final String myRoomsPath = "/setting/contact";
  final String followedRoomsPath = "/setting/contact";
  final String popularRoomsPath = "/setting/contact";
  final String newRoomsPath = "/setting/contact";

  @override
  Future<Map<String, dynamic>> signInWithFB(
      {String name, String email, String uId}) async {
    // TODO: implement signInWithFB
    try {
      final url = baseUrl + loginWithFBPath;
      final body = {
        "name": name,
        "email": email,
        "uId": uId,
      };
      await http.post(Uri.parse(url), body: body).then((value) {
        print("loginWithFB: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> signInWithPhone({String phone}) async {
    // TODO: implement signInWithPhone
    try {
      final url = baseUrl + loginWithPhonePath;
      final body = {
        "phone": phone,
      };
      await http.post(Uri.parse(url), body: body).then((value) {
        print("loginWithPhone: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
    throw UnimplementedError();
  }

  @override
  Future<AuthModel> logOut({String token}) async {
    // TODO: implement logOut
    try {
      http.Response response = await http.post(Uri.parse(
        baseUrl + logOutPath,
      ));
      print("logOut: ${response.toString()}");
      var jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> categories() async {
    // TODO: implement categories
    try {
      final url = baseUrl + loginWithPhonePath;
      await http.get(Uri.parse(url)).then((value) {
        print("categories: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> contactUs(
      String name, String email, String message) async {
    // TODO: implement contactUs
    Map body = {
      'name': name,
      'email': email,
      'message': message,
    };
    try {
      http.Response response =
          await http.post(Uri.parse(baseUrl + contactUsPath), body: body);
      print(response.toString());
      final jsonData = convert.jsonDecode(response.body);
      return jsonData;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> popularRooms({int pageNum}) async {
    // TODO: implement popularRooms
    try {
      final url = baseUrl + loginWithPhonePath;
      await http
          .get(
        Uri.parse(url),
      )
          .then((value) {
        print("loginWithPhone: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> followedRooms(
      {String token, int pageNum}) async {
    // TODO: implement followedRooms
    Map body = {
      'token': token,
    };
    try {
      await http
          .post(Uri.parse(baseUrl + contactUsPath), body: body)
          .then((value) {
        print(value.toString());
        final jsonData = convert.jsonDecode(value.body);
        return jsonData;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> homeSlider() async {
    // TODO: implement homeSlider
    try {
      final url = baseUrl + loginWithPhonePath;
      await http.get(Uri.parse(url)).then((value) {
        print("slider: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> myCreatedRooms(
      {String token, int pageNum}) async {
    // TODO: implement myCreatedRooms
    try {
      final url = baseUrl + loginWithPhonePath;
      final body = {
        "token": token,
      };
      await http.post(Uri.parse(url), body: body).then((value) {
        print("response: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> roomDetails({String roomId}) {
    // TODO: implement roomDetails
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> userInfo({String token}) async {
    // TODO: implement userInfo
    try {
      final url = baseUrl + loginWithPhonePath;
      await http
          .get(
        Uri.parse(url),
      )
          .then((value) {
        print("response: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> createRoom(
      {File imgFile, String roomName, String roomDesc}) async {
    // TODO: implement createRoom
    try {
      var postUri = Uri.parse(createRoomPath);
      var request = new http.MultipartRequest("POST", postUri);
      request.fields['api_token'] = 'token';
      request.fields['roomName'] = roomName;
      request.fields['roomDesc'] = roomDesc;
      if (imgFile != null)
        request.files.add(http.MultipartFile.fromBytes(
            'image', File(imgFile.path).readAsBytesSync(),
            filename: imgFile.path.split("/").last));
      var response = await request.send();
      response.stream.transform(utf8.decoder).listen((value) async {
        print(value.toString());
      });
    } catch (error) {
      print(error.toString());
    } finally {}
  }

  @override
  Future<Map<String, dynamic>> followSubject({String subjectId}) {
    // TODO: implement followSubject
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getCities() async {
    // TODO: implement getCities
    try {
      final url = baseUrl + loginWithPhonePath;
      await http
          .post(
        Uri.parse(url),
      )
          .then((value) {
        print("response: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> getUserInfo({String token}) {
    // TODO: implement getUserInfo
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> momentsSubjects() {
    // TODO: implement momentsSubjects
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> shareAMoment(
      {String subjectName, File image, String location, String state}) {
    // TODO: implement shareAMoment
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateRoomData(
      {String roomId, File imgFile, String roomName, String roomDesc}) async {
    // TODO: implement updateRoomData
    try {
      final url = baseUrl + loginWithPhonePath;
      final body = {
        "roomId": roomId,
        "image": imgFile,
        "roomName": roomName,
        "roomDesc": roomDesc,
      };
      await http.post(Uri.parse(url), body: body).then((value) {
        print("response: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
    throw UnimplementedError();
  }

  @override
  Future<Map<String, dynamic>> updateUserInfo(
      {String token,
      File userImage,
      String gender,
      String birthDate,
      String city,
      String aboutUser}) async {
    // TODO: implement updateUserInfo
    try {
      final url = baseUrl + loginWithPhonePath;
      final body = {
        "token": token,
        "image": userImage,
        "gender": gender,
        "birthDate": birthDate,
        "city": city,
        "aboutUser": aboutUser,
      };
      await http.post(Uri.parse(url), body: body).then((value) {
        print("response: ${value.toString()}");
        final responseBody = jsonDecode(value.body);
        return responseBody;
      });
    } catch (e) {
      print(e.toString());
    }
    throw UnimplementedError();
  }
}
