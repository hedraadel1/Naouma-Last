import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/models/user_mic_model.dart';
import 'package:project/onlineDatabase/laravel_impl.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/home/home_screen.dart';

import '../common_functions.dart';

class RoomsController extends GetxController {
  String roomName, roomDesc;
  Map profileData = {
    'name': 'Nick Edmands',
    'email': '@nick',
    'image': 'assets/images/profile.png',
  };
  final _firestoreInstance = FirebaseFirestore.instance;
  List<QueryDocumentSnapshot> roomsList = new List.from([]);

  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormState> get globalKey => _key;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getRoomsData();
  }

  void createRoom(
    File file,
  ) async {
    print("create room started..");

    // Map<String, dynamic> jsonData = await L;aravelImpl().createRoom(imgFile: file,
    //     roomName: roomName, roomDesc: roomDesc);
    // check if user created room before...
    for (var map in roomsList) {
      final docData = map.data() as Map<String, dynamic>;

      if (docData.containsKey("roomOwnerId")) {
        if (docData["roomOwnerId"] ==
            PreferencesServices.getString(ID_KEY)) {
          // your list of map contains key "id" which has value 3
          CommonFunctions.showToast("لقد قمت بانشاء غرفة مسبقا", Colors.red);
          print("roomOwnerId: ${docData["roomOwnerId"]}");
          return;
        }
      }
    }
    _firestoreInstance.collection('rooms').add({
      'roomName': roomName,
      "roomDesc": roomDesc,
      "roomOwnerId": PreferencesServices.getString(ID_KEY),
      "createdAt": DateTime.now()
    }).then((value) {
      //add success
      // _addMicsToFirebase(value.id);
      print("add Room success");
      print("id: ${value.id}");
      print(value.toString());
      CommonFunctions.showToast("تم انشاء غرفة بنجاح", Colors.greenAccent);
      Get.offAll(HomeScreen(),
          duration: Duration(milliseconds: 1000),
          transition: Transition.leftToRightWithFade);
    });
  }

  void updateRoom(
      String roomId, File file, String roomName, String roomDesc) async {
    Map<String, dynamic> jsonData = await LaravelImpl().updateRoomData(
        roomId: roomId, imgFile: file, roomName: roomName, roomDesc: roomDesc);
  }

  void myRooms(String token) async {
    Map<String, dynamic> jsonData =
        await LaravelImpl().myCreatedRooms(token: token);
  }

  void getRoomsData() async {
    QuerySnapshot querySnapshot =
        await _firestoreInstance.collection('rooms').get();
    // Get data from docs and convert map to List
    roomsList = querySnapshot.docs;
    print("roomsLength: ${roomsList.length}");
  }

  // void _addMicsToFirebase(String roomID) async {
  //   // await _firestoreInstance.collection('roomUsers')
  //   //     .doc(roomID).collection(roomID).doc().delete();
  //   List<UserMicModel> _micsList = [];

  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 0,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 1,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 2,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 3,
  //       micStatus: false));
  //   _micsList.add(UserMicModel(
  //       id: null,
  //       userId: null,
  //       userName: null,
  //       isLocked: false,
  //       roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       micNumber: 4,
  //       micStatus: false));
  //   CollectionReference _collectionRef = FirebaseFirestore.instance
  //       .collection('roomUsers')
  //       .doc(roomID)
  //       .collection(roomID);
  //   await _collectionRef
  //       .doc(_micsList[0].micNumber.toString())
  //       .set(_micsList[0].toJson());
  //   await _collectionRef
  //       .doc(_micsList[1].micNumber.toString())
  //       .set(_micsList[1].toJson());
  //   await _collectionRef
  //       .doc(_micsList[2].micNumber.toString())
  //       .set(_micsList[2].toJson());
  //   await _collectionRef
  //       .doc(_micsList[3].micNumber.toString())
  //       .set(_micsList[3].toJson());
  //   await _collectionRef
  //       .doc(_micsList[4].micNumber.toString())
  //       .set(_micsList[4].toJson());
  //   _micsList.forEach((element) async {
  //     await _collectionRef
  //         .doc("${_micsList.indexOf(element)}")
  //         .set(element.toJson());
  //   });
  // }
}
