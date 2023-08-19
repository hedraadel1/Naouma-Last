import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project/utils/constants.dart';
import 'package:url_launcher/link.dart';

class DioHelper {
  static Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://nauma.onoo.pro/public/api/',
        receiveDataWhenStatusError: true));
  }
final String basse = "https://nauma.onoo.pro/public/api/";
  static Future<Response> getdata({
    @required String url,
    Map<String, dynamic> query,
    String token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postdata(
      {@required String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      String token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    return dio.post(url, queryParameters: query ?? null, data: data);
  }

  static Future<Response> deletedata(
      {@required String url,
      Map<String, dynamic> query,
      @required Map<String, dynamic> data,
      String token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    return dio.delete(url, queryParameters: query ?? null, data: data);
  }

  static Future<Response> editroom(
      {@required String url,
      Map<String, dynamic> query,
      @required data,
      String token}) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    };

    return dio.post(url, queryParameters: query ?? null, data: data);
  }

  // static Future<Response> editroom(
  //     {@required String url,
  //     Map<String, dynamic> query,
  //     @required roomname,
  //     @required roomdesc,
  //     @required mics,
  //     @required supervisor,
  //     @required imageFile,
  //     @required fileName,
  //     String token}) async {
  //   // Blob blob = new Blob(imageFile.readAsBytesSync());
  //   // var multipartFilee = await MultipartFile.fromFile(imageFile.path,
  //   //     filename: fileName, contentType: MediaType('image', fileName));
  //   // FormData formData = FormData.fromMap({
  //   //   "name": roomname,
  //   //   "room_desc": roomdesc,
  //   //   "countMics": mics,
  //   //   "supervisor_lockmic_access": supervisor,
  //   //   'room_background': multipartFilee
  //   // });

  //   print(roomname);
  //   print(roomdesc);
  //   print(mics);

  //   print(supervisor);

  //   print(imageFile);

  //   print(fileName);

  //   var formData = FormData.fromMap({
  //     "name": roomname,
  //     "room_desc": roomdesc,
  //     "countMics": mics,
  //     "supervisor_lockmic_access": supervisor,
  //     "room_background": image != null
  //         ? await MultipartFile.fromFile(
  //             imageFile.toString(),
  //             filename: imagename,
  //             contentType: new MediaType("image", "jpeg"),
  //           )
  //         : "",
  //   });

  //   print(formData);
  //   dio.options.headers = {
  //     'Authorization': 'Bearer $token',
  //     'Accept': 'application/json'
  //   };
  //   print(imageFile.path);
  //   return dio.post(url, queryParameters: query ?? null, data: formData);
  // }
}







// class IntesDioHelper {
//   static Dio dio;

//   static init() {
//     dio = Dio(BaseOptions(
      
//         baseUrl: 'https://newidea.link/nauma-v2/public/api/',
        
//         receiveDataWhenStatusError: true));
//   }

//   static Future<Response> getdata({
//     @required String url,
//     Map<String, dynamic> query,
//     String token,
//   }) async {
//     dio.options.headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json'
//     };
//     return await dio.get(url, queryParameters: query);
//   }

//   static Future<Response> postdata(
//       {@required String url,
//       Map<String, dynamic> query,
//       @required Map<String, dynamic> data,
//       String token}) async {
//     print(token);

//     dio.options.headers = {
//       'Authorization':
//           'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvbmV3aWRlYS5saW5rXC9uYXVtYS12MlwvcHVibGljXC9hcGlcL2F1dGhcL2xvZ2luIiwiaWF0IjoxNjQ2NDcxMzczLCJleHAiOjE3MDA0NzEzNzMsIm5iZiI6MTY0NjQ3MTM3MywianRpIjoiN2ZTWjJEWUVNV2hxUlRtUyIsInN1YiI6MTksInBydiI6IjIzYmQ1Yzg5NDlmNjAwYWRiMzllNzAxYzQwMDg3MmRiN2E1OTc2ZjcifQ.bZXKzxk8g-6yoie8bFTMxBMWbG5lp16oj0YpTJbvc3g',
//       'Accept': 'application/json'
//     };

//     return dio.post(url, queryParameters: query ?? null, data: data);
//   }
// }