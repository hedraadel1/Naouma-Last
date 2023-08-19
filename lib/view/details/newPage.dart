/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:project/utils/HedraTrace.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/audiocall.dart';
import 'package:project/common_functions.dart';
import 'package:project/endpoint.dart';
import 'package:project/models/IsFollow_model.dart';
import 'package:project/models/firebase_room_model.dart';
import 'package:project/models/get_user_exp_model.dart';
import 'package:project/models/notification_model.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/room_index.dart';
import 'package:project/models/room_user_model.dart';
import 'package:project/models/send_gift_model.dart';
import 'package:project/models/user_mic_model.dart';
import 'package:project/oneTo_one_screen.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/images.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/details/components/roomImageTap.dart';
import 'package:project/view/details/users_Inroom.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/home_tab_pages/myroom/room_setting.dart';
import 'package:project/view/home/states.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../gift_screen.dart';
import '../../models/firebaseModel.dart';
import '../../models/mics_model.dart';
import '../../shop_background_gift.dart';
import '../../utils/size_config.dart';
import 'components/mic_click_dialog.dart';

class DetailsScreen extends StatefulWidget {
  //// Data Has Been Send From my_rooms_view.dart
  //// By Hedra Adel

  final String username;
  final String userID;
  final String roomId;
  final String roomImage;
  var e = StateError("This is a state error.");

  final String roomName;
  final String roomDesc;
  final String roomOwnerId;
  final String passwordRoom;
  final String apiroomID;
  final ClientRole role;

  DetailsScreen({Key key,
    this.username,
    this.userID,
    this.role,
    this.roomId,
    this.roomName,
    this.roomDesc,
    this.roomOwnerId,
    this.apiroomID,
    this.passwordRoom,
    this.roomImage})
      : super(key: key);
  int _remoteUid;

  // RtcEngine _engine;
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  //// Model have : userid,spacialid,Relation with Level , isfriend,relation with Package , typeuser(Don’t know),
  //// isPurchaseid(Don’t know),frame,frameurl,avatar,avatarurl
  //// By Hedra Adel

  InRoomUserModelModel inRoomUserModelModel;
  RtcEngine _engine;
  static final _users = <int>[];

  bool _isSpeaking = false;

  // AgoraRtmClient _client;
  // AgoraRtmChannel _channel;
  // AgoraRtmChannel _subchannel;
  bool get isSpeaking => _isSpeaking;

  String myChannel = '';
  bool _isChannelCreated = true;
  final _channelFieldController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  final ScrollController listScrollController = ScrollController();
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  List<QueryDocumentSnapshot> roomUsersList = new List.from([]);
  final Map<String, List<String>> _seniorMember = {};
  final Map<String, int> _channelList = {};
  List<UserMicModel> _micUsersList = [];
  final _infoStrings = <String>[];
  String groupChatId = "";
  String roomID = "";
  int _roomUsersCount = 0;
  bool _isLoadingMics = true;
  bool _isLogin = false;
  bool _isInChannel = false;
  String isHaveFrame = '1';
  bool mute = true;
  int micnum;
  int micIndex = 3;
  bool onmic = false;
  int check;
  int message;
  String background;
  RoomModel roomModel;
  String totalnum;
  int limit = 20;
  final _firestoreInstance = FirebaseFirestore.instance;

  bool _isRoomOnFirebase = false;
  var expmodel;
  DocumentSnapshot snapshot; //Define snapshot
  HedraTrace hedra = HedraTrace(StackTrace.current);

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    //// Get the Muted users in the Users in room From firestore
    getmuted();

    //// Get rooms Collection , Usernow filed in roomid doc to return string value for totalnum variable
    getreal();

    ////
    readLocal();

    //// Check the room is found or no in the firestore and update _isRoomOnFirebase bool variable
    initialize();

    // _addMicsToFirebase();
    // getRoomUsers();
    print("initState has been completed and the  " +
        "roomId: $roomID" +
        "--- Hedra Adel ---");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // _users.clear();
    // destroy sdk

    // _engine.leaveChannel();
    print("The Room has Been Closed" + "--- Hedra Adel ---");
    // _engine.destroy();
    super.dispose();
  }

  Future<void> initialize() async {
    //// Check the room is found or no in the firestore and update _isRoomOnFirebase bool variable
    //// By Hedra Adel
    try {
      await checkRoomFoundOrNot();
    } catch (e) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(" - Error - There is Error in ${hedra.fileName} -- " +
          "In Line : ${hedra.lineNumber} -- " +
          "The caller function : ${hedra.callerFunctionName} -- " +
          "The Details is : :::: " +
          e.toString() +
          " :::: " +
          "-- Hedra Adel - Error -");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }

    // initialize agora
    // await _initAgoraRtcEngine();
    // _addAgoraEventHandlers();
    // await _engine.joinChannel(
    //     "00645f4567598af4f32afca701cccd0cf2dIADRIb4LxYD/WX4B1uQnZIJqrURDf6xrB/V2mFU7a+SDTwnn9jMAAAAAEAD+bihbcUpCYQEAAQCfyEJh",
    //     // "naoumaRoom",
    //     "${widget.roomName}",
    //     null,
    //     0);
  }

  File imageFile;

  //// Chose Image
  Future<File> pickImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imageFile = File(image.path);
      uploadImage();
      imagename = imageFile.path
          .split("/")
          .last;
      print(imageFile.path);
      return imageFile;
    }
  }

  //// Pick Image with Camera
  Future<File> imagePicker(BuildContext context, ThemeData themeData) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: CupertinoActionSheet(
              title: Text(
                'التقاط الصورة عبر',
                // style: themeData.textTheme.subtitle,
              ),
              cancelButton: CupertinoButton(
                child: Text("اغلاق",
                    style: themeData.textTheme.bodyText1.copyWith(
                      color: kPrimaryColor,
                    )),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.photo_camera_solid,
                          color: themeData.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "الكاميرا",
                          //  style: themeData.textTheme.body1,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      File imageFile = await pickImage(ImageSource.camera);
                      return imageFile;
                    }),
                CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.insert_photo,
                          color: themeData.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "الاستوديو",
                          // style: themeData.textTheme.body1,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      File imageFile = await pickImage(ImageSource.gallery);
                      return imageFile;
                    }),
              ],
            ),
          );
        });
  }

  //// Upload Image to firestore into chats collection inside chatroom collection
  Future uploadImage() async {
    String fileName = Uuid().v1();
    int status = 1;

    await _firestoreInstance
        .collection('chatroom')
        .doc(widget.roomId)
        .collection('chats')
        .doc(fileName)
        .set({
      "sendby": specialId,
      "message": "",
      "type": "img",
      "time": FieldValue.serverTimestamp(),
    });

    var ref =
    FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

    //// Delete the image if Error has been catched
    var uploadTask = await ref.putFile(imageFile).catchError((error) async {
      await _firestoreInstance
          .collection('chatroom')
          .doc(widget.roomId)
          .collection('chats')
          .doc(fileName)
          .delete();

      status = 0;
    });

    if (status == 1) {
      String imageUrl = await uploadTask.ref.getDownloadURL();

      await _firestoreInstance
          .collection('chatroom')
          .doc(widget.roomId)
          .collection('chats')
          .doc(fileName)
          .update({"message": imageUrl});
      onSendMessage(imageUrl, 1, 1);
      print(imageUrl);
    }
  }

  //// Send New massage (content) from the user To the room chat , select the massage Type if text or image, etc ..
  //// By Hedra Adel
  void onSendMessage(String content,
      int type,
      int currentlevel,) {
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      _messageController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(widget.roomId)
          .collection(widget.roomId)
          .doc(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'username': username,
            'idFrom': specialId,
            'idTo': widget.roomId,
            'timestamp': DateTime
                .now()
                .millisecondsSinceEpoch
                .toString(),
            'content': content,
            'type': type,
            'userLevel': currentlevel,
            'ApiUserID': apiid,
            'userType': userstateInroom,
            'specialId': specialId,
            'packageName': nameOFPackage,
            'packageColor': packageColor,
            'packageBadge': packagebadge,
            'hasSpecialID': hasSpecialID
          },
        );
      });
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      print("The Message has Been Sent" + "--- Hedra Adel ---");
    } else {
      CommonFunctions.showToast('Nothing to send', Colors.red);
      print("The Message hasn't Been Sent" + "--- Hedra Adel ---");
    }
  }

  //// Get rooms Collection , Usernow filed in roomid doc to return string value for totalnum variable
  //// By Hedra Adel
  readLocal() async {
    try {
      if (apiid.hashCode <= widget.roomId.hashCode) {
        setState(() {
          groupChatId = '${widget.roomId}';
          roomID = widget.roomId;
        });
      } else {
        setState(() {
          groupChatId = '${widget.roomId}';
          roomID = widget.roomId;
        });
      }
    } catch (e) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(" - Error - There is Error in ${hedra.fileName} -- " +
          "In Line : ${hedra.lineNumber} -- " +
          "The caller function : ${hedra.callerFunctionName} -- " +
          "The Details is : :::: " +
          e.toString() +
          " :::: " +
          "-- Hedra Adel - Error -");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  //// Check the room is found or no in the firestore and update _isRoomOnFirebase bool variable and create room doc if it not exists
  //// By Hedra Adel
  checkRoomFoundOrNot() async {
    DocumentSnapshot ds =
    await _firestoreInstance.collection("roomUsers").doc(roomID).get();
    this.setState(() {
      _isRoomOnFirebase = ds.exists;
      print("checkRoomFoundOrNot Has been Completed and " +
          "_isRoomOnFirebase is : $_isRoomOnFirebase" +
          "--- Hedra Adel ---");
    });
    // if room not exist add it to firebase
    _isRoomOnFirebase ? null : _addMicsToFirebase(roomID);
  }

  Widget _personInRoom(int index, UserMicModel micModel) {
    print("_personInRoom index" + "$index" + "--- Hedra Adel ---");
    print(
        "_personInRoom index" + "${micModel.userName}" + "--- Hedra Adel ---");

    return Expanded(
      child: Container(
        child: Column(
          children: [
            micModel.micStatus == true
                ? Stack(
              children: [
                hasFrame == null
                    ? Container(
                  // width: 70,
                  // child: Image.network(
                  //   hasFrame,
                  // )
                )
                    : Container(
                    width: 70,
                    child: Image.network(
                      hasFrame,
                    )), // Back image
                Padding(
                  padding: const EdgeInsets.all(9.0),
                  child: Container(
                    width: 50,
                    child: Image.asset(
                      "assets/images/Profile Image.png",
                      // fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            )
                : Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle,
                  border: Border.all(width: 2, color: kPrimaryColor)),
              child: Icon(
                micModel.isLocked != null
                    ? micModel.isLocked
                    ? Icons.lock
                    : Icons.mic
                    : Icons.mic,
                color: Colors.white,
                size: 32,
              ),
            ),
            2.height,
            Text(
              micModel.isLocked != null && micModel.isLocked
                  ? "مقفل"
                  : micModel.micStatus
                  ? micModel.userName.length > 7
                  ? ".${micModel.userName}"
                  : micModel.userName
                  : "${index + 1}",
              overflow: TextOverflow.ellipsis,
              style: secondaryTextStyle(size: 12, color: black),
            ),
          ],
        ),
      ).onTap(() {
        if (ismuted == false) {
          CommonFunctions.showToast('لا تملك الصلاحية', Colors.red);
        } else if (!micModel.micStatus &&
            !micModel.isLocked &&
            micModel.userId == null &&
            micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
          // Iam room owner and mic is empty
          print("Iam owner and mic is empty.");

          // Check if user already holds mic before
          var existingItem = _micUsersList.firstWhere(
                  (itemToCheck) =>
              itemToCheck.userId == PreferencesServices.getString(ID_KEY),
              orElse: () => null);

          // user already holds mic before
          // will leave the old mic , and use new one

          if (existingItem != null) {
            print(existingItem.micNumber);
            print(existingItem.userName);
            print("take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(
                    takeMicFunction: () {
                      print("clicked take");
                      print("clicked index: $index");
                      // leave old mic
                      existingItem.id = null;
                      existingItem.userName = null;
                      existingItem.userId = null;
                      existingItem.micNumber = existingItem.micNumber;
                      existingItem.micStatus = false;
                      _updateMicsToFirebase(
                          existingItem.micNumber, existingItem);
                      print("existname: ${existingItem.userName}");
                      print("existuserId: ${existingItem.userId}");
                      print("existmicNumber: ${existingItem.micNumber}");
                      print("existid: ${existingItem.micNumber}");
                      print("existmicStatus: ${existingItem.micStatus}");

                      // go to new mic
                      micModel.id = index.toString();
                      micModel.userName =
                          PreferencesServices.getString(Name_KEY);
                      micModel.userId = PreferencesServices.getString(ID_KEY);
                      micModel.micNumber = index;
                      micModel.micStatus = true;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");

                      /// Removes all previous screens from the back stack and redirect to new screen with provided screen tag
                      finish(context);

                      _updateMicsToFirebase(index, micModel);
                    },
                    leaveMicFunction: () {},
                    lockMicFunction: () {
                      // lock mic
                      micModel.id = null;
                      micModel.userName = null;
                      micModel.userId = null;
                      micModel.micNumber = index;
                      micModel.micStatus = false;
                      micModel.isLocked = true;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    unLockMicFunction: () {},
                    showTakeMic: true,
                    showLeaveMic: false,
                    showLockMic: true,
                    micIsLocked: false,
                  );
                });
          } else {
            print("not take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(
                    takeMicFunction: () {
                      // go to new mic
                      micModel.id = index.toString();
                      micModel.userName =
                          PreferencesServices.getString(Name_KEY);
                      micModel.userId = PreferencesServices.getString(ID_KEY);
                      micModel.micNumber = index;
                      micModel.micStatus = true;
                      micModel.isLocked = false;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    leaveMicFunction: () {},
                    lockMicFunction: () {
                      // lock mic
                      micModel.id = null;
                      micModel.userName = null;
                      micModel.userId = null;
                      micModel.micNumber = index;
                      micModel.micStatus = false;
                      micModel.isLocked = true;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    unLockMicFunction: () {},
                    showTakeMic: true,
                    showLeaveMic: false,
                    showLockMic: true,
                    micIsLocked: false,
                  );
                });
          }
        } else if (!micModel.micStatus &&
            micModel.isLocked &&
            micModel.userId == null &&
            micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
          // Iam room owner and mic is locked
          print("Iam room owner and mic is locked...");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MicClickDialog(
                  takeMicFunction: () {},
                  leaveMicFunction: () {},
                  unLockMicFunction: () {
                    print("unLock Mic index: $index");
                    micModel.id = null;
                    micModel.userName = null;
                    micModel.userId = null;
                    micModel.micNumber = index;
                    micModel.micStatus = false;
                    micModel.isLocked = false;
                    print("name: ${micModel.userName}");
                    print("userId: ${micModel.userId}");
                    print("micNumber: ${micModel.micNumber}");
                    print("id: ${micModel.micNumber}");
                    print("micStatus: ${micModel.micStatus}");
                    _updateMicsToFirebase(index, micModel);
                    finish(context);
                  },
                  showTakeMic: false,
                  showLeaveMic: false,
                  showLockMic: false,
                  micIsLocked: true,
                );
              });
        } else if (micModel.micStatus &&
            !micModel.isLocked &&
            micModel.userId == PreferencesServices.getString(ID_KEY) &&
            micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
          // Iam room owner and mic is locked
          print("Iam room owner and mic is taken by me...");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MicClickDialog(
                  takeMicFunction: () {},
                  leaveMicFunction: () {
                    print("unLock Mic index: $index");
                    micModel.id = null;
                    micModel.userName = null;
                    micModel.userId = null;
                    micModel.micNumber = index;
                    micModel.micStatus = false;
                    micModel.isLocked = false;
                    print("name: ${micModel.userName}");
                    print("userId: ${micModel.userId}");
                    print("micNumber: ${micModel.micNumber}");
                    print("id: ${micModel.micNumber}");
                    print("micStatus: ${micModel.micStatus}");
                    _updateMicsToFirebase(index, micModel);
                    finish(context);
                  },
                  unLockMicFunction: () {},
                  showTakeMic: false,
                  showLeaveMic: true,
                  showLockMic: false,
                  micIsLocked: false,
                );
              });
        } else if (!micModel.micStatus &&
            !micModel.isLocked &&
            micModel.userId == null &&
            micModel.roomOwnerId != PreferencesServices.getString(ID_KEY)) {
          // Iam not room owner and mic is locked
          print("Iam not room owner and mic is taken by me...");
          var existingItem = _micUsersList.firstWhere(
                  (itemToCheck) =>
              itemToCheck.userId == PreferencesServices.getString(ID_KEY),
              orElse: () => null);
          if (existingItem != null) {
            // user already holds mic before
            print(existingItem.micNumber);
            print(existingItem.userName);
            print("take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(
                    takeMicFunction: () {
                      print("clicked take");
                      print("clicked index: $index");
                      // leave old mic
                      existingItem.id = null;
                      existingItem.userName = null;
                      existingItem.userId = null;
                      existingItem.micNumber = existingItem.micNumber;
                      existingItem.micStatus = false;
                      _updateMicsToFirebase(
                          existingItem.micNumber, existingItem);
                      print("existname: ${existingItem.userName}");
                      print("existuserId: ${existingItem.userId}");
                      print("existmicNumber: ${existingItem.micNumber}");
                      print("existid: ${existingItem.micNumber}");
                      print("existmicStatus: ${existingItem.micStatus}");

                      // go to new mic
                      micModel.id = index.toString();
                      micModel.userName =
                          PreferencesServices.getString(Name_KEY);
                      micModel.userId = PreferencesServices.getString(ID_KEY);
                      micModel.micNumber = index;
                      micModel.micStatus = true;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      // update firebase
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    leaveMicFunction: () {
                      print("leave index: $index");
                      micModel.id = null;
                      micModel.userName = null;
                      micModel.userId = null;
                      micModel.micNumber = index;
                      micModel.micStatus = false;
                      micModel.isLocked = false;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      // update firebase
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    lockMicFunction: () {},
                    unLockMicFunction: () {},
                    showTakeMic: true,
                    showLeaveMic: true,
                    showLockMic: false,
                    micIsLocked: false,
                  );
                });
          } else {
            print("not take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(
                    takeMicFunction: () {
                      // go to new mic
                      micModel.id = index.toString();
                      micModel.userName = username;
                      micModel.userId = specialId;
                      micModel.micNumber = index;
                      micModel.micStatus = true;
                      micModel.isLocked = false;
                      print("name: ${micModel.userName}");
                      print("userId: ${micModel.userId}");
                      print("micNumber: ${micModel.micNumber}");
                      print("id: ${micModel.micNumber}");
                      print("micStatus: ${micModel.micStatus}");
                      _updateMicsToFirebase(index, micModel);
                      finish(context);
                    },
                    leaveMicFunction: () {
                      finish(context);
                    },
                    lockMicFunction: () {},
                    unLockMicFunction: () {},
                    showTakeMic: true,
                    showLeaveMic: true,
                    showLockMic: false,
                    micIsLocked: false,
                  );
                });
          }
        } else if (micModel.micStatus == true &&
            !micModel.isLocked &&
            micModel.userId != null &&
            micModel.userId == specialId) {
          // mic taken by me...
          print("mic taken by me...");
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return MicClickDialog(
                  takeMicFunction: () {},
                  leaveMicFunction: () {
                    print("leave index: $index");
                    micModel.id = null;
                    micModel.userName = null;
                    micModel.userId = null;
                    micModel.micNumber = index;
                    micModel.micStatus = false;
                    print("name: ${micModel.userName}");
                    print("userId: ${micModel.userId}");
                    print("micNumber: ${micModel.micNumber}");
                    print("id: ${micModel.micNumber}");
                    print("micStatus: ${micModel.micStatus}");
                    finish(context);
                    _updateMicsToFirebase(index, micModel);
                  },
                  lockMicFunction: () {},
                  unLockMicFunction: () {},
                  showLockMic: false,
                  micIsLocked: false,
                  showTakeMic: false,
                  showLeaveMic: true,
                );
              });
        } else if (micModel.micStatus &&
            !micModel.isLocked &&
            micModel.userId != null &&
            micModel.userId != specialId) {
          // taken by other one
          CommonFunctions.showToast("Mic already taken", Colors.red);
        } else if (!micModel.micStatus &&
            micModel.isLocked &&
            micModel.userId != null &&
            micModel.userId != PreferencesServices.getString(ID_KEY)) {
          // Mic is locked
          CommonFunctions.showToast("Mic is locked", Colors.red);
        } else {
          print("_micUsersList: ${_micUsersList.length}");
          //find existing item per link criteria
          var existingItem = _micUsersList.firstWhere(
                  (itemToCheck) =>
              itemToCheck.userId == PreferencesServices.getString(ID_KEY),
              orElse: () => null);
          if (existingItem != null) {
            // user already holds mic before
            print(existingItem.micNumber);
            print(existingItem.userName);
            print("take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(takeMicFunction: () {
                    print("clicked take");
                    print("clicked index: $index");
                    // leave old mic
                    existingItem.id = null;
                    existingItem.userName = null;
                    existingItem.userId = null;
                    existingItem.micNumber = existingItem.micNumber;
                    existingItem.micStatus = false;
                    _updateMicsToFirebase(existingItem.micNumber, existingItem);
                    print("existname: ${existingItem.userName}");
                    print("existuserId: ${existingItem.userId}");
                    print("existmicNumber: ${existingItem.micNumber}");
                    print("existid: ${existingItem.micNumber}");
                    print("existmicStatus: ${existingItem.micStatus}");

                    // go to new mic
                    micModel.id = index.toString();
                    micModel.userName = PreferencesServices.getString(Name_KEY);
                    micModel.userId = PreferencesServices.getString(ID_KEY);
                    micModel.micNumber = index;
                    micModel.micStatus = true;
                    print("name: ${micModel.userName}");
                    print("userId: ${micModel.userId}");
                    print("micNumber: ${micModel.micNumber}");
                    print("id: ${micModel.micNumber}");
                    print("micStatus: ${micModel.micStatus}");
                    finish(context);
                    _updateMicsToFirebase(index, micModel);
                  }, leaveMicFunction: () {
                    print("leave index: $index");
                    finish(context);
                  });
                });
          } else {
            print("not take other mic");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return MicClickDialog(takeMicFunction: () {
                    print("clicked take");
                    print("clicked index: $index");
                    micModel.id = "$index";
                    micModel.userName = PreferencesServices.getString(Name_KEY);
                    micModel.userId = PreferencesServices.getString(ID_KEY);
                    micModel.micNumber = index;
                    micModel.micStatus = true;
                    print("name: ${micModel.userName}");
                    print("userId: ${micModel.userId}");
                    print("micNumber: ${micModel.micNumber}");
                    print("id: ${micModel.micNumber}");
                    print("micStatus: ${micModel.micStatus}");
                    finish(context);
                    _updateMicsToFirebase(index, micModel);
                  }, leaveMicFunction: () {
                    print("leave index: $index");
                    finish(context);
                  });
                });
          }
        }
      }),
    );
  }

  //// Get rooms Collection , Usernow filed in roomid doc to return string value for totalnum variable
  //// By Hedra Adel
  void getreal() async {
    try {
      await for (var snapshot in _firestoreInstance
          .collection('rooms')
          .doc(widget.roomId)
          .snapshots()) {
        var messeage = snapshot.get('userNow');

        print("getreal() Has been Complete and message content is " +
            messeage.toString() +
            "--- Hedra Adel ---");

        totalnum = messeage.toString();
      }
    } catch (e) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(" - Error - There is Error in ${hedra.fileName} -- " +
          "In Line : ${hedra.lineNumber} -- " +
          "The caller function : ${hedra.callerFunctionName} -- " +
          "The Details is : :::: " +
          e.toString() +
          " :::: " +
          "-- Hedra Adel - Error -");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  //// Get the Muted users in the Users in room From firestore
  //// By Hedra Adel
  void getmuted() async {
    try {
      await for (var snapshot in _firestoreInstance
          .collection('UsersInRoom')
          .doc(widget.roomId)
          .collection(widget.roomId)
          .doc('HdbIYSyq88vJlh9yjEXT')
          .snapshots()) {
        ismuted = snapshot.get('state');
        print('getmuted Method has been Called --- Hedra adel ---');

        print(ismuted.toString() + ' issmuted state Value --- Hedra adel ---');
      }
    } catch (e) {
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
      print(" - Error - There is Error in ${hedra.fileName} -- " +
          "In Line : ${hedra.lineNumber} -- " +
          "The caller function : ${hedra.callerFunctionName} -- " +
          "The Details is : :::: " +
          e.toString() +
          " :::: " +
          "-- Hedra Adel - Error -");
      print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    }
  }

  ////	Create _micslist array’s
  ////	Create roomUsers Collection in firestore with roomID Doc
  ////	Create second Collection inside roomID Doc and insert the 10 mics inside it
  //// By Hedra Adel
  void _addMicsToFirebase(String roomID) async {
    List<UserMicModel> _micsList = [];

    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 0,
        micStatus: false,
        isLocked: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 1,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 2,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 3,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 4,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 5,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 6,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 7,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 8,
        isLocked: false,
        micStatus: false));
    _micsList.add(UserMicModel(
        id: null,
        userId: null,
        userName: null,
        micNumber: 9,
        isLocked: false,
        micStatus: false));
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('roomUsers')
        .doc(roomID)
        .collection(roomID);
    await _collectionRef
        .doc(_micsList[0].micNumber.toString())
        .set(_micsList[0].toJson());
    await _collectionRef
        .doc(_micsList[1].micNumber.toString())
        .set(_micsList[1].toJson());
    await _collectionRef
        .doc(_micsList[2].micNumber.toString())
        .set(_micsList[2].toJson());
    await _collectionRef
        .doc(_micsList[3].micNumber.toString())
        .set(_micsList[3].toJson());
    await _collectionRef
        .doc(_micsList[4].micNumber.toString())
        .set(_micsList[4].toJson());
    _micsList.forEach((element) async {
      await _collectionRef
          .doc("${_micsList.indexOf(element)}")
          .set(element.toJson());
    });
    print(
        'RoomUsers() Collection has been Created with 10 mics --- Hedra adel ---');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery
        .of(context)
        .size;
    TextEditingController _controller = TextEditingController();

    return BlocProvider(
      create: (context) =>
      HomeCubit()
        ..getnotification(id: widget.roomId, password: widget.passwordRoom)
        ..getroomuser(id: widget.roomId)
        ..getuserExp(id: apiid)
        ..usersfollowingroom(id: widget.roomId),
      child: BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is SetPasswordRoomSuccessStates) {
          CommonFunctions.showToast('تم تعين كلمة مرور للغرفة', Colors.green);
        }
        if (state is InroomSuccessStates) {
          var model = HomeCubit
              .get(context)
              .roomUserModel
              .message;
        }

        if (state is NotificationSuccessStates) {
          var model = HomeCubit
              .get(context)
              .notificationModel;
          var model1 = HomeCubit
              .get(context)
              .roomUserModel;
          message = model1.message;
          check = model.data.user.follow;
          background = model.data.user.background;

          FirebaseMessaging.onMessage.listen((event) {
            print(
                "FirebaseMessaging.onMessage NotificationSuccessStates event listen Has been fired data is " +
                    event.data.toString() +
                    "--- Hedra Adel ---");

            FirebaseModel firebaseModel;
            firebaseModel = FirebaseModel.fromJson(event.data);
            // isHaveFrame = null;
            // if (model.data.user.entry == 'ther is no entry') {
            // } else {
            // if (notfication == true) {
            //   print('>>>>>>>>>>>>>>>>>>>>>>>>');
            new Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 5), () {
                      Navigator.of(context).pop(true);
                    });
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: new Container(
                          alignment: FractionalOffset.center,
                          // height: 80.0,
                          // padding: const EdgeInsets.all(20.0),
                          child: new Image.network(
                            firebaseModel.image,
                            fit: BoxFit.cover,
                          )),
                    );
                  });
            });
          });
        }

        if (state is SendGiftSuccessStates) {
          var model = HomeCubit
              .get(context)
              .notificationModel;

          FirebaseMessaging.onMessage.listen((event) {
            print(
                "FirebaseMessaging.onMessage SendGiftSuccessStates event listen Has been fired data is " +
                    event.data.toString() +
                    "--- Hedra Adel ---");
            SendgiftModel sendgiftModel;
            sendgiftModel = SendgiftModel.fromJson(event.data);
            // isHaveFrame = null;

            new Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    Future.delayed(Duration(seconds: 5), () {
                      Navigator.of(context).pop(true);
                    });
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: new Container(
                          alignment: FractionalOffset.center,
                          // height: 80.0,
                          // padding: const EdgeInsets.all(20.0),
                          child: new Image.network(
                            showgift,
                            fit: BoxFit.cover,
                          )),
                    );
                  });
            });
          });
        }

        if (state is FollowSuccessStates) {
          if (HomeCubit
              .get(context)
              .isFollowModel
              .success == true) {
            CommonFunctions.showToast('تم الانضام للغرفة', Colors.green);
          }
        }
      }, builder: (context, state) {
        return ConditionalBuilder(
          condition: HomeCubit
              .get(context)
              .roomUserModel != null &&
              HomeCubit
                  .get(context)
                  .getUserExpModel != null,
          builder: (context) =>
              getdata(
                  HomeCubit
                      .get(context)
                      .getUserExpModel,
                  HomeCubit
                      .get(context)
                      .roomUserModel
                      .message,
                  HomeCubit
                      .get(context)
                      .roomUserModel,
                  _controller),
          fallback: (context) =>
              Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
        );
      }),
    );
  }

  Widget getdata(GetUserExpModel model,
      int model1,
      InRoomUserModelModel model2,
      TextEditingController _controller,) {
    final size = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
          top: false,
          child: WillPopScope(
            onWillPop: _closeRoom,
            child: Scaffold(
              body: // GetBuilder<DetailsController>(
              //     init: Get.find(),
              // builder:(controller)=>
              Container(
                child: Stack(
                  children: [
                    background != null
                        ? Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(background),
                            fit: BoxFit.cover),
                      ),
                    )
                        : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                'https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 40.0, horizontal: 8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: size.width / 2 - 16,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 6.0),
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      bottomLeft: Radius.circular(16.0)),
                                ),
                                child: Row(
                                  children: [
                                    InkWell(
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        child: Image.network(
                                          'https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            constraints: BoxConstraints(),
                                            builder: (builder) {
                                              return Container(
                                                color: Colors.transparent,
                                                child: RoomImageTap(
                                                    roomDesc: widget.roomDesc,
                                                    totalNum: totalnum,
                                                    roomimage: widget.roomImage,
                                                    roomname: widget.roomName,
                                                    roomID: widget.roomId
                                                        .toString(),
                                                    currentlevel: model
                                                        .data.userCurrentLevel),
                                              );
                                            });
                                      },
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.roomName,
                                            maxLines: 1,
                                            style: theme.textTheme.bodyText1
                                                .copyWith(
                                                color: Colors.white,
                                                fontSize: 17),
                                          ),
                                          Text(
                                            "ID :${widget.roomId}",
                                            maxLines: 1,
                                            style: theme.textTheme.bodyText2
                                                .copyWith(
                                                color: Colors.white,
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                    ),
                                    check == 0
                                    // model.data.user.follow == 0
                                    // model.data.user.follow == 0
                                        ? IconButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .followroom(id: roomID);
                                        setState(() {
                                          check = 1;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                        color: Colors.white,
                                      ),
                                    )
                                        : IconButton(
                                        onPressed: () {
                                          HomeCubit.get(context)
                                              .followroom(id: roomID);
                                          // check = true;
                                        },
                                        icon: Icon(Icons.favorite,
                                            color: Colors.blue))
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.ios_share,
                                          color: Colors.white),
                                      onPressed: () {
                                        // getreal();
                                        print("share btn clicked");
                                      }),
                                  Theme(
                                      data: Theme.of(context).copyWith(
                                        dividerTheme: DividerThemeData(
                                          color: Colors.white,
                                        ),
                                        cardColor:
                                        Colors.black.withOpacity(0.7),
                                      ),
                                      child: PopupMenuButton<int>(
                                        icon: Icon(
                                          Icons.more_vert,
                                          color: Colors.white,
                                        ),
                                        onSelected: (item) =>
                                            onSelected(
                                                context, item, _controller),
                                        itemBuilder: (context) =>
                                        [
                                          PopupMenuItem<int>(
                                              value: 0,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.subject,
                                                    color: Colors.white,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "الموضوعات",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                          PopupMenuDivider(),
                                          PopupMenuItem<int>(
                                              value: 1,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.developer_board,
                                                    color: Colors.white,
                                                  ),
                                                  Spacer(),
                                                  Text("تطوير",
                                                      style: TextStyle(
                                                          color: Colors.white))
                                                ],
                                              )),
                                          PopupMenuDivider(),
                                          PopupMenuItem<int>(
                                              value: 2,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.lock,
                                                    color: Colors.white,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "قفل",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                          PopupMenuDivider(),
                                          PopupMenuItem<int>(
                                              value: 3,
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.share,
                                                    color: Colors.white,
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    "مشاركة",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                ],
                                              )),
                                          // PopupMenuDivider(),
                                          // PopupMenuItem<int>(
                                          //   value: 4,
                                          //   child: Row(
                                          //     children: [
                                          //       Icon(
                                          //         Icons.settings,
                                          //         color: Colors.white,
                                          //       ),
                                          //       Spacer(),
                                          //       Text(
                                          //         "الاعدادات",
                                          //         style: TextStyle(
                                          //             color: Colors.white),
                                          //       )
                                          //     ],
                                          //   ),
                                          // )
                                        ],
                                      )),
                                  GestureDetector(
                                      child: Icon(Icons.close,
                                          color: Colors.white),
                                      onTap: () {
                                        HomeCubit.get(context)
                                            .logoutUserRoom(id: widget.roomId);
                                        _closeRoom();
                                      })
                                ],
                              )
                            ],
                          ),
                          16.height,
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 150,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2.0, horizontal: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.black26,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        bottomLeft: Radius.circular(16.0)),
                                  ),
                                  child: InkWell(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Icon(Icons.monetization_on_rounded,
                                              color: Colors.orange),
                                          SizedBox(
                                            width: 6.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.roomDesc,
                                              maxLines: 1,
                                              style: theme.textTheme.bodyText1
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 17),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_back_ios_rounded,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (builder) {
                                            return Container(
                                              height: MediaQuery
                                                  .of(context)
                                                  .size
                                                  .height *
                                                  0.80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(30.0),
                                                  topRight:
                                                  Radius.circular(30.0),
                                                ),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          14.0),
                                                      child: Text(
                                                        "قائمة الكرماء",
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width: double.infinity,
                                                    height: 568,
                                                    child: DefaultTabController(
                                                      length: 2,
                                                      child: Scaffold(
                                                        appBar: PreferredSize(
                                                            preferredSize:
                                                            Size.fromHeight(
                                                                30.0),
                                                            child: AppBar(
                                                              backgroundColor:
                                                              Colors.white,
                                                              bottom: TabBar(
                                                                indicator:
                                                                BoxDecoration(
                                                                  color:
                                                                  KstorebuttonColor,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                    Radius
                                                                        .circular(
                                                                        5),
                                                                  ),
                                                                ),
                                                                tabs: [
                                                                  Text(
                                                                    "اخر 24 ساعة",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  Text(
                                                                    "اخر 7 أيام",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                  // Text(
                                                                  //   "بريميم",
                                                                  //   style: TextStyle(
                                                                  //       color:
                                                                  //           Colors.white),
                                                                  // ),
                                                                  // Text(
                                                                  //   "vip",
                                                                  //   style: TextStyle(
                                                                  //       color:
                                                                  //           Colors.white),
                                                                  // ),
                                                                ],
                                                              ),
                                                            )),
                                                        body: TabBarView(
                                                          children: [
                                                            // GiftScreen(),
                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 80,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child:
                                                                  Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child: Icon(
                                                                      Icons
                                                                          .hourglass_empty_rounded,
                                                                      size: 80,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Text(
                                                                    "لم يرسل أحد الهدايا في ال 24 ساعة الماضية",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 240,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Container(
                                                                          height: 80,
                                                                          decoration: BoxDecoration(
                                                                              border: Border
                                                                                  .all(
                                                                                  color: Colors
                                                                                      .grey)),
                                                                          child: Row(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 30.0,
                                                                                backgroundImage: NetworkImage(
                                                                                    "https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80"),
                                                                                backgroundColor: Colors
                                                                                    .transparent,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets
                                                                                    .all(
                                                                                    8.0),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .center,
                                                                                  children: [
                                                                                    Text(
                                                                                        "username"),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                            Icons
                                                                                                .monetization_on_rounded,
                                                                                            color: Colors
                                                                                                .orange),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                            "0"),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),

                                                            Column(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                              children: [
                                                                SizedBox(
                                                                  height: 80,
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child:
                                                                  Container(
                                                                    color: Colors
                                                                        .white,
                                                                    child: Icon(
                                                                      Icons
                                                                          .hourglass_empty_rounded,
                                                                      size: 80,
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      8.0),
                                                                  child: Text(
                                                                    "لم يرسل أحد الهدايا في السبعة أيام الماضية",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .grey),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 240,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child: Container(
                                                                          height: 80,
                                                                          decoration: BoxDecoration(
                                                                              border: Border
                                                                                  .all(
                                                                                  color: Colors
                                                                                      .grey)),
                                                                          child: Row(
                                                                            children: [
                                                                              CircleAvatar(
                                                                                radius: 30.0,
                                                                                backgroundImage: NetworkImage(
                                                                                    "https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80"),
                                                                                backgroundColor: Colors
                                                                                    .transparent,
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets
                                                                                    .all(
                                                                                    8.0),
                                                                                child: Column(
                                                                                  mainAxisAlignment: MainAxisAlignment
                                                                                      .center,
                                                                                  children: [
                                                                                    Text(
                                                                                        "username"),
                                                                                    Row(
                                                                                      children: [
                                                                                        Icon(
                                                                                            Icons
                                                                                                .monetization_on_rounded,
                                                                                            color: Colors
                                                                                                .orange),
                                                                                        SizedBox(
                                                                                          width: 10,
                                                                                        ),
                                                                                        Text(
                                                                                            "0"),
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 170,
                                      height: 70,
                                      // height: 160,
                                      // color: Colors.red,
                                      child: Directionality(
                                        textDirection: TextDirection.ltr,
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                // flex: 1,
                                                child: ListView.separated(
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  shrinkWrap: true,
                                                  itemBuilder: (BuildContext
                                                  context,
                                                      int index) =>
                                                      builditem(
                                                          HomeCubit
                                                              .get(context)
                                                              .roomUserModel
                                                              .data[index],
                                                          context),
                                                  itemCount: model1,
                                                  separatorBuilder:
                                                      (BuildContext context,
                                                      int index) =>
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                ),
                                              )
                                            ]

                                          // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
                                          // return Container(
                                          //     width: 20,
                                          //     child: Image.asset(
                                          //       "assets/images/Profile Image.png",
                                          //       fit: BoxFit.cover,
                                          //     ));

                                          // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
                                        ),
                                      ),
                                    ),
                                    5.width,
                                    InkWell(
                                      child: Container(
                                        child: Row(
                                          children: [
                                            message == null
                                                ? Text(
                                              '0',
                                              style: theme
                                                  .textTheme.bodyText1
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )
                                                : Text(
                                              totalnum.toString(),
                                              style: theme
                                                  .textTheme.bodyText1
                                                  .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            Icon(Icons.person_outline,
                                                color: Colors.white),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            constraints: BoxConstraints(),
                                            builder: (builder) {
                                              return UsersInroom(
                                                  roomID:
                                                  widget.roomId.toString());
                                            });
                                      },
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          16.height,
                          Container(
                            padding: const EdgeInsets.all(6.0),
                            child: Stack(
                              // fit: StackFit.expand,
                              // overflow: Overflow.visible,
                              children: [
                                Container(
                                  width: double.infinity,
                                  margin:
                                  const EdgeInsets.only(top: 10, right: 10),
                                  child: _roomMicsLayout(),
                                ),
                              ],
                            ),
                          ),
                          16.height,
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            decoration: BoxDecoration(
                              color: Colors.black54,
                            ),
                            child: Marquee(
                              child: Text(
                                'Some sample text that takes some space, Some sample text that takes some space. ',
                                style: theme.textTheme.bodyText1
                                    .copyWith(color: Colors.white),
                              ),
                              direction: Axis.horizontal,
                              textDirection: TextDirection.rtl,
                              pauseDuration: Duration(seconds: 2),
                              backDuration: Duration(seconds: 2),
                              animationDuration: Duration(seconds: 6),
                              directionMarguee: DirectionMarguee.oneDirection,
                            ),
                          ),
                          buildListMessage(size),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2.0),
                              decoration: BoxDecoration(
                                color: Colors.black26,
                                borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                controller: _messageController,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration.collapsed(
                                  hintText: "رسالتك...",
                                  hintStyle: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          8.width,
                          Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.orange,
                            ),
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ).onTap(() {
                            if (ismuted == false) {
                              CommonFunctions.showToast(
                                  'لا تملك الصلاحية', Colors.red);
                            } else {
                              onSendMessage(
                                _messageController.text, 0,
                                model.data.userCurrentLevel,
                                // model.data.userId
                              );
                            }
                          }),
                          8.width,
                          Theme(
                              data: Theme.of(context).copyWith(
                                dividerTheme: DividerThemeData(
                                  color: Colors.white,
                                ),
                                cardColor: Colors.black.withOpacity(0.7),
                              ),
                              child: PopupMenuButton<int>(
                                icon: Container(
                                  padding: const EdgeInsets.all(4.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kPrimaryLightColor,
                                  ),
                                  child: Icon(
                                    Icons.image_rounded,
                                    color: Colors.white,
                                  ),
                                ),
                                onSelected: (item) =>
                                    onSelected(context, item, _controller),
                                itemBuilder: (context) =>
                                [
                                  PopupMenuItem<int>(
                                      value: 3,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),

                                          // shape: BoxShape.circle,
                                        ),
                                        width: 180,
                                        height: 70,
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.music_note,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  "أغاني الغرفه",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.album,
                                                  color: Colors.white,
                                                ),
                                                InkWell(
                                                  child: Container(
                                                    child: Text(
                                                      "البوم الصور",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    imagePicker(context, theme);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      )),
                                ],
                              )),
                          Container(
                            height: 35,
                            // padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: IconButton(
                                iconSize: 22,
                                color: Colors.white,
                                icon: Icon(Icons.card_giftcard_rounded),
                                onPressed: () =>
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (BuildContext context) {
                                          return GiftScreen(
                                              roomID: widget.roomId);
                                        })),
                          ),
                          8.width,
                          InkWell(
                            child: Container(
                              padding: const EdgeInsets.all(6.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black45,
                              ),
                              child: Icon(
                                Icons.favorite_outline_outlined,
                                color: Colors.blueAccent,
                              ),
                            ),
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 350,
                                      child: Scaffold(
                                          backgroundColor:
                                          Colors.black.withOpacity(0.7),
                                          body: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.all(
                                                          8.0),
                                                      child: Container(
                                                        height: 50,
                                                        child: Center(
                                                          child: Text(
                                                            "مركز  الترفيه",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    height: 120,
                                                    width: 80,
                                                    child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons.games,
                                                              size: 40,
                                                              color:
                                                              Colors.redAccent,
                                                            ),
                                                            // SizedBox(
                                                            //   height: 20,
                                                            // ),
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  "حجرة ورقة",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 16),
                                                                ),
                                                                Text(
                                                                  "مقص",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize: 16),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    height: 120,
                                                    width: 80,
                                                    child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .monetization_on_rounded,
                                                              size: 40,
                                                              color: Colors
                                                                  .orange,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "حقيبة الحظ",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 120,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons.circle,
                                                              size: 40,
                                                              color: Colors
                                                                  .blue,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "عجلة الحظ",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 120,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .people_alt_sharp,
                                                              size: 40,
                                                              color: kPrimaryColor,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "استطلاع الرأي",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Container(
                                                    height: 120,
                                                    width: 80,
                                                    decoration: BoxDecoration(
                                                        color: Colors.grey,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(10)),
                                                    child: Center(
                                                        child: Column(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .confirmation_number_rounded,
                                                              size: 40,
                                                              color: kPrimaryColor,
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Text(
                                                              "رقم الحظ",
                                                              style: TextStyle(
                                                                  color:
                                                                  Colors.white,
                                                                  fontSize: 16),
                                                            ),
                                                          ],
                                                        )),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )),
                                    );
                                  });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void onSelected1(BuildContext context, int item, int userID, String roomid) {
    switch (item) {
      case 0:
        HomeCubit.get(context).postSupervsorroom(id: userID);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

      case 1:
        HomeCubit.get(context).deleteSupervsorroom(id: userID);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

      case 2:
        HomeCubit.get(context).postUnfollowser(idUser: userID, idRoom: roomid);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

    // case 4:
    //   // Navigator.of(context).push(MaterialPageRoute(
    //   //     builder: (context) => RoomSettings(
    //   //           roomName: widget.roomName,
    //   //           type: widget.roomDesc,
    //   //           roomID: widget.roomId,
    //   //         )));
    //   break;
    // case 1:
    //    Navigator.of(context).push(
    //        MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
    //   break;
    }
  }

  void onSelected2(//   BuildContext context,
      int item,
      String userID,
      String roomid) {
    switch (item) {
      case 0:
        HomeCubit.get(context).postSupervsorroom(id: userID);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

      case 1:
        HomeCubit.get(context).deleteSupervsorroom(id: userID);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

      case 2:
        HomeCubit.get(context).postUnfollowser(idUser: userID, idRoom: roomid);
        // Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

    // case 4:
    //   // Navigator.of(context).push(MaterialPageRoute(
    //   //     builder: (context) => RoomSettings(
    //   //           roomName: widget.roomName,
    //   //           type: widget.roomDesc,
    //   //           roomID: widget.roomId,
    //   //         )));
    //   break;
    // case 1:
    //    Navigator.of(context).push(
    //        MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
    //   break;
    }
  }

  void onSelected(BuildContext context, int item,
      TextEditingController _controller) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
        break;

      case 2:
        if (userstateInroom == 'owner') {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) =>
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    title: Center(
                      child: const Text('برجاء تعين كلمة المرور للغرفة'),
                    ),
                    // content: const Text('AlertDialog description'),
                    actions: <Widget>[
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 250,
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: CommonFunctions().nbAppTextFieldWidget(
                                    _controller,
                                    'Password',
                                    "ادخل كلمة المرور",
                                    'برجاء ادخال كلمه المرور',
                                    TextFieldType.PASSWORD,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  color: kPrimaryLightColor,

                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  ),
                                  // border: Border.all(
                                  //   width: 1,
                                  //   color: kPrimaryColor,
                                  //   style: BorderStyle.solid,
                                  // ),
                                  // shape: BoxShape.circle,
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context).setRoomPassword(
                                        roompassword: _controller.text);

                                    // ShopCubit.get(context)
                                    //     .lockPurchase(id: model.id);
                                    Navigator.pop(context, 'yes');

                                    CommonFunctions.showToast(
                                        'تم تعين كلمة مرور للغرفة ',
                                        Colors.green);
                                  },
                                  child: const Text(
                                    'تعين',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // TextButton(
                              //   onPressed: () => Navigator.pop(context, 'no'),
                              //   child: const Text('لا'),
                              // ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
          );
        } else {
          CommonFunctions.showToast('خاص بمالك الغرفة', Colors.red);
        }

        break;

    // case 4:
    //   Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => RoomSettings(
    //             roomName: widget.roomName,
    //             type: widget.roomDesc,
    //             roomID: widget.roomId,
    //             roomImage: widget.roomImage,
    //           )));
    //   break;
    // case 1:
    //    Navigator.of(context).push(
    //        MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
    //   break;
    }
  }

  // Future getRoomUsers() async {
  //   _isLoadingMics = true;
  //   var collection = FirebaseFirestore.instance.collection('roomUsers');
  //   var docSnapshot = await collection
  //       .doc(roomModel.id.toString())
  //       .collection(roomModel.id.toString())
  //       .get();
  //   // Map<String, dynamic> data = docSnapshot.docs;
  //   // QuerySnapshot querySnapshot = await _firestoreInstance.collection('roomUsers').doc(roomID).get().;
  //   // // // Get data from docs and convert map to List
  //   if (collection != null && docSnapshot != null) {
  //     // docSnapshot.docs.length > 0 ? _addMicsToFirebase() : null;
  //     roomUsersList = docSnapshot.docs;
  //     // voidsetState(() {
  //     //   _isLoadingMics = false;
  //     // });
  //   }
  //   // // roomUsersList = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   // setState(() {
  //   //   _usersCount = roomUsersList.length;
  //   // });
  //   // print(roomUsersList.toString());
  //   // print("userslst: ${roomUsersList.length}");
  //   // roomUsersList.forEach((querySnapshot) {
  //   //   Map<String, dynamic> jsonData = querySnapshot.data();
  //   //   UserMicModel userMicModel = UserMicModel.fromJson(jsonData);
  //   //   print(userMicModel.userId);
  //   //   print("users: ${userMicModel.userName}");
  //   //   print("users: ${querySnapshot.data()['userName']}");
  //   // });
  //   // _firestore.collection('favorites').where('user_id', isEqualTo: uid).getDocuments()
  //   //     .then((querySnap) {
  //   //   querySnap.documents.forEach((document) {
  //   //     print(document.data);
  //   //
  //   //     Map<String, dynamic> json = document.data; //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
  //   //     Album album = new Album.fromJson(json['favorite_albums'][0]); //Throws the type exception
  //   //   });
  //   // })
  //   //     .catchError((error) {
  //   //   print(error);
  //   // });
  // }

  Widget buildItem(int index,
      DocumentSnapshot document,
      Size size,) {
    if (document != null) {
      // Right (my message)
      return document.get('type') == 0
      // Text
          ? Container(
        width: size.width * 0.7,
        padding: const EdgeInsets.all(6.0),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      width: 36,
                      height: 36,
                      child: ClipRRect(
                        borderRadius:
                        BorderRadius.all(Radius.circular(16.0)),
                        child: Image.asset(
                          kDefaultProfileImage,
                          width: 36,
                          height: 36,
                        ),
                      ),
                    ),
                  ),
                  10.width,
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              document.get('userType') == 'owner'
                                  ? Icon(
                                Icons.person,
                                color: Colors.red,
                              )
                                  : Container(),
                              document.get('userType') == 'user'
                                  ? Icon(
                                Icons.person,
                                color: Colors.blue,
                              )
                                  : Container(),
                              document.get('userType') == 'supervisor'
                                  ? Icon(
                                Icons.person,
                                color: kPrimaryLightColor,
                              )
                                  : Container(),

                              document.get('packageColor') == null
                                  ? Container(
                                child: Text(
                                  document.get('username'),
                                  style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                color: Colors.transparent,
                                // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                                // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                              )
                                  : Container(
                                child: Text(
                                  document.get('username'),
                                  style: TextStyle(
                                      color: HexColor(document
                                          .get('packageColor')),
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                color: Colors.transparent,
                                // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                                // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              document.get('hasSpecialID') == true
                                  ? Container(
                                height: 18,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.amber,
                                    )),
                                child: Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                ),
                              )
                                  : Container(),
                              document.get('packageBadge') != null
                                  ? Container(
                                height: 25,
                                width: 25,
                                child: Center(
                                    child: Image.network(document
                                        .get('packageBadge'))),
                              )
                                  : Container(),
                              Container(
                                height: 18,
                                width: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.amber,
                                    )),
                                child: Center(
                                  child: Icon(
                                    Icons.home,
                                    color: Colors.amber,
                                    size: 12,
                                  ),
                                ),
                              ),
                              // document.get('userType') == 'user'
                              //     ? Icon(
                              //         Icons.person,
                              //         color: Colors.blue,
                              //       )
                              //     : Container(),
                              // document.get('userType') == 'supervisor'
                              //     ? Icon(
                              //         Icons.person,
                              //         color: kPrimaryLightColor,
                              //       )
                              //     : Container(),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(children: [
                            Expanded(
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.black26,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(16.0)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 15.0, right: 5.0),
                                  child: Text(
                                    document.get('content'),
                                    style: secondaryTextStyle(
                                        color: Colors.white),
                                    maxLines: 2,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                                // color: Colors.black.withOpacity(0.3),
                                // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                                // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                              ),
                            ),
                          ]),
                        ]),
                  ),
                ],
              ),
            ],
          ),
          onTap: () {
            // showModalBottomSheet(
            //     context: context,
            //     isScrollControlled: true,
            //     builder: (context) {
            //       return FractionallySizedBox(
            //         heightFactor: 0.30,
            //         child: Container(
            //           decoration: new BoxDecoration(
            //               color: Colors.white,
            //               borderRadius: new BorderRadius.only(
            //                   topLeft: const Radius.circular(10.0),
            //                   topRight: const Radius.circular(10.0))),
            //           child: Column(
            //             children: [
            //               Container(
            //                 child: FloatingActionButton(
            //                     child: CircleAvatar(
            //                       radius: 50,
            //                       backgroundImage: AssetImage(
            //                         "assets/images/Profile Image.png",
            //                       ),
            //                     ),
            //                     onPressed: () {}),
            //               ),
            //               SizedBox(
            //                 height: 15,
            //               ),
            //               Text(
            //                 document.get('username'),
            //               ),
            //               SizedBox(
            //                 height: 5,
            //               ),
            //               Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 children: [
            //                   Container(
            //                       width: 50,
            //                       decoration: BoxDecoration(
            //                         color: kPrimaryColor,
            //                         borderRadius: BorderRadius.only(
            //                           topRight: Radius.circular(10),
            //                           bottomRight: Radius.circular(10),
            //                           bottomLeft: Radius.circular(10),
            //                           topLeft: Radius.circular(10),
            //                         ),
            //                         border: Border.all(
            //                           width: 1,
            //                           color: kPrimaryColor,
            //                           style: BorderStyle.solid,
            //                         ),
            //                         // shape: BoxShape.circle,
            //                       ),
            //                       child: Center(
            //                           child: Text(
            //                         "عضو",
            //                         style: TextStyle(
            //                             color: Colors.white,
            //                             fontSize: 12),
            //                       ))),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     document.get('idFrom'),
            //                     style: TextStyle(color: Colors.grey),
            //                   ),
            //                   SizedBox(
            //                     width: 10,
            //                   ),
            //                   Text(
            //                     'LV ${document.get('userLevel').toString()}',
            //                     style: TextStyle(
            //                         color: kPrimaryColor,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                 ],
            //               ),
            //               Spacer(),
            //               Padding(
            //                 padding: const EdgeInsets.all(20.0),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     Column(
            //                       children: [
            //                         MaterialButton(
            //                           onPressed: () {
            //                             Navigator.pop(context);

            //                             showModalBottomSheet(
            //                                 backgroundColor:
            //                                     Colors.transparent,
            //                                 context: context,
            //                                 builder:
            //                                     (BuildContext context) {
            //                                   return GiftScreen(
            //                                     roomID: widget.roomId,
            //                                     userID: document
            //                                         .get('ApiUserID')
            //                                         .toString(),
            //                                     username: document
            //                                         .get('username')
            //                                         .toString(),
            //                                     check: true,
            //                                     // userID: model.userId
            //                                     // .toString(),
            //                                   );
            //                                 });
            //                             // if (type != null) {
            //                             //   HomeCubit.get(context).sendgift(
            //                             //       id: roomID,
            //                             //       type: type,
            //                             //       giftid: giftId,
            //                             //       received: model.userId,
            //                             //       count: controller);
            //                             //   CommonFunctions.showToast(
            //                             //       "${model.name}تم إرسال هديه الي",
            //                             //       Colors.green);
            //                             // } else {
            //                             //   CommonFunctions.showToast(
            //                             //       "برجاء اختيار الهدية",
            //                             //       Colors.red);
            //                             // }
            //                           },
            //                           color: Colors.blueAccent,
            //                           textColor: Colors.white,
            //                           child: Icon(
            //                             Icons.card_giftcard,
            //                             size: 14,
            //                           ),
            //                           padding: EdgeInsets.all(16),
            //                           shape: CircleBorder(),
            //                         ),
            //                         Text(
            //                           'إرسال هديه',
            //                           style:
            //                               TextStyle(color: Colors.grey),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       width: 40,
            //                     ),
            //                     Column(
            //                       children: [
            //                         MaterialButton(
            //                           onPressed: () {},
            //                           color: Colors.pink,
            //                           textColor: Colors.white,
            //                           child: Icon(
            //                             Icons.star,
            //                             size: 14,
            //                           ),
            //                           padding: EdgeInsets.all(16),
            //                           shape: CircleBorder(),
            //                         ),
            //                         Text(
            //                           'البطاقات السحرية',
            //                           style:
            //                               TextStyle(color: Colors.grey),
            //                         )
            //                       ],
            //                     ),
            //                     SizedBox(
            //                       width: 40,
            //                     ),
            //                     Column(
            //                       children: [
            //                         MaterialButton(
            //                           onPressed: () {
            //                             // HomeCubit.get(context).addfriend(
            //                             //   id: model.userId,
            //                             // );
            //                           },
            //                           color: Colors.yellow,
            //                           textColor: Colors.white,
            //                           child: Icon(
            //                             Icons.person_add,
            //                             size: 14,
            //                           ),
            //                           padding: EdgeInsets.all(16),
            //                           shape: CircleBorder(),
            //                         ),
            //                         Text(
            //                           'إضافه صديق',
            //                           style:
            //                               TextStyle(color: Colors.grey),
            //                         )
            //                       ],
            //                     ),
            //                   ],
            //                 ),
            //               )
            //             ],
            //           ),
            //         ),
            //       );
            //     });

            //////////////////////////////////////////////////////////////////////

            showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent, // <-- SEE HERE

                // shape: RoundedRectangleBorder(
                //     // <-- SEE HERE
                //     borderRadius: BorderRadius.circular(60)),
                isScrollControlled: true,
                builder: (context) {
                  // Flexible(
                  //   child: widget.roomId.isNotEmpty
                  //       ? StreamBuilder<QuerySnapshot>(
                  //           stream: FirebaseFirestore.instance
                  //               .collection('users')
                  //               .doc(userid)
                  //               .collection('friends')
                  //               .snapshots(),
                  //           builder: (BuildContext context,
                  //               AsyncSnapshot<QuerySnapshot> snapshot) {
                  //             if (snapshot.hasData) {
                  //               // listMessage.addAll(snapshot.data.docs);
                  //               print(
                  //                   "fiiiiiiiire: ${snapshot.data.docs[0].toString()}");

                  //               return Container();
                  //               // return ListView.builder(
                  //               //   padding: EdgeInsets.all(10.0),
                  //               //   itemBuilder: (context, index) =>
                  //               //       buildItem(
                  //               //     index,
                  //               //     snapshot.data?.docs[index],
                  //               //     size,
                  //               //   ),
                  //               //   itemCount: snapshot.data?.docs.length,
                  //               //   reverse: true,
                  //               //   controller: listScrollController,
                  //               // );
                  //             } else {
                  //               print(
                  //                   "fiiirrrrrire: ${snapshot.data.docs.toString()}");

                  //               return Center(
                  //                 child: CircularProgressIndicator(
                  //                   valueColor:
                  //                       AlwaysStoppedAnimation<Color>(
                  //                           kPrimaryColor),
                  //                 ),
                  //               );
                  //             }
                  //           },
                  //         )
                  //       : Center(
                  //           child: CircularProgressIndicator(
                  //             valueColor: AlwaysStoppedAnimation<Color>(
                  //                 kPrimaryColor),
                  //           ),
                  //         ),
                  // );

                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection('users')
                      .doc(userid)
                      .collection('friends')
                      .doc(document.get('idFrom'));
                  docRef.get().then((DocumentSnapshot documentSnapshot) {
                    if (documentSnapshot.exists) {
                      print('Document exists on the database');
                      print(documentSnapshot.get('isFriend'));
                      isfriendfirebase = documentSnapshot.get('isFriend');
                    } else {
                      isfriendfirebase = false;
                    }
                  });

                  // FirebaseFirestore.instance
                  //     .collection('users')
                  //     .doc(userid)
                  //     .collection('friends')
                  //     .get()
                  //     .then(
                  //   (value) {
                  //     value.docs.forEach(
                  //       (result) {
                  //         print('fiiiiiiiiiiiire');
                  //         print(value.docs[0]);
                  //       },
                  //     );
                  //   },
                  // );

                  // return Stack(
                  //   children: <Widget>[
                  //     // The containers in the background
                  //     FractionallySizedBox(
                  //       heightFactor: 0.40,
                  //       child: Column(
                  //         children: <Widget>[
                  //           Container(
                  //               // height: MediaQuery.of(context).size.height * .50,
                  //               // color: Colors.blue,
                  //               ),
                  //           Container(
                  //             // height: MediaQuery.of(context).size.height * .20,
                  //             color: Colors.white,
                  //             child: Center(
                  //               child: Text("aaaaa"),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //     // The card widget with top padding,
                  //     // incase if you wanted bottom padding to work,
                  //     // set the `alignment` of container to Alignment.bottomCenter
                  //     new Container(
                  //       alignment: Alignment.topCenter,
                  //       padding: new EdgeInsets.only(
                  //           top: MediaQuery.of(context).size.height * .58,
                  //           right: 20.0,
                  //           left: 20.0),
                  //       child: new Container(
                  //         // height: 200.0,
                  //         // width: MediaQuery.of(context).size.width,
                  //         child: CircleAvatar(
                  //           child: Image.asset("assets/images/Profile Image.png"),
                  //           backgroundColor: kPrimaryColor,
                  //           radius: 50,
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // );
                  return FractionallySizedBox(
                    heightFactor: 0.41,
                    child: Stack(children: [
                      Column(
                        children: [
                          new Container(
                            height: 25,
                            color: Colors.transparent.withOpacity(0.0),
                          ),
                          Container(
                            height: 290,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                            // color: Colors.amber,

                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 12),
                                      child: Container(
                                        height: 22,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.orange,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "@",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 20, top: 12),
                                      child: Container(
                                        height: 22,
                                        width: 25,
                                        child: Icon(
                                          Icons.report_problem_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                      ),
                                    )
                                    // IconButton(
                                    //   onPressed: () {},
                                    //   icon: Icon(Icons.report_gmailerrorred),
                                    // ),

                                    // Spacer(),
                                  ],
                                ),
                                // Container(
                                //   height: 35,
                                //   color: Colors.transparent.withOpacity(0.5),

                                //   // color: Colors.grey.withOpacity(0.5),
                                //   // decoration: BoxDecoration(
                                //   //   color: Colors.transparent.withOpacity(0.5),
                                //   //   borderRadius: BorderRadius.only(
                                //   //     // topRight: Radius.circular(10),
                                //   //     bottomRight: Radius.circular(10),
                                //   //     bottomLeft: Radius.circular(10),
                                //   //     // topLeft: Radius.circular(10),
                                //   //   ),

                                //   //   // shape: BoxShape.circle,
                                //   // ),
                                //   // height: MediaQuery.of(context).size.height * .20,
                                //   //             color: Colors.white,
                                //   //             child: Center(
                                //   //               child: Text("aaaaa"),
                                //   //             ),
                                // ),

                                // Container(
                                //   child: FloatingActionButton(
                                //       child: CircleAvatar(
                                //         radius: 50,
                                //         backgroundImage: AssetImage(
                                //           "assets/images/Profile Image.png",
                                //         ),
                                //       ),
                                //       onPressed: () {}),
                                // ),
                                // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

                                SizedBox(
                                  height: 20,
                                ),
                                Text(document.get('username')),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    if (document.get('userType') ==
                                        'user')
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight:
                                                Radius.circular(10),
                                                bottomRight:
                                                Radius.circular(10),
                                                bottomLeft:
                                                Radius.circular(10),
                                                topLeft:
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: kPrimaryColor,
                                                style: BorderStyle.solid,
                                              ),
                                              // shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                                child: Text(
                                                  'عضو',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ))),
                                      ),
                                    if (document.get('userType') ==
                                        'supervisor')
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight:
                                                Radius.circular(10),
                                                bottomRight:
                                                Radius.circular(10),
                                                bottomLeft:
                                                Radius.circular(10),
                                                topLeft:
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: kPrimaryColor,
                                                style: BorderStyle.solid,
                                              ),
                                              // shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                                child: Text(
                                                  'مشرف',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ))),
                                      ),
                                    if (document.get('userType') ==
                                        'owner')
                                      Padding(
                                        padding:
                                        const EdgeInsets.all(8.0),
                                        child: Container(
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: kPrimaryColor,
                                              borderRadius:
                                              BorderRadius.only(
                                                topRight:
                                                Radius.circular(10),
                                                bottomRight:
                                                Radius.circular(10),
                                                bottomLeft:
                                                Radius.circular(10),
                                                topLeft:
                                                Radius.circular(10),
                                              ),
                                              border: Border.all(
                                                width: 1,
                                                color: kPrimaryColor,
                                                style: BorderStyle.solid,
                                              ),
                                              // shape: BoxShape.circle,
                                            ),
                                            child: Center(
                                                child: Text(
                                                  'مالك',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12),
                                                ))),
                                      ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'ID:${document.get('idFrom').toString()}',
                                      style:
                                      TextStyle(color: Colors.grey),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'LV ${document.get('userLevel')
                                          .toString()}',
                                      style: TextStyle(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 18,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.amber,
                                          )),
                                      child: Center(
                                        child: Icon(
                                          Icons.person,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.amber,
                                          )),
                                      child: Center(
                                        child: Icon(
                                          Icons.markunread_mailbox,
                                          color: Colors.amber,
                                          size: 10,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                      height: 18,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.red,
                                          border: Border.all(
                                            width: 2,
                                            color: Colors.amber,
                                          )),
                                      child: Center(
                                        child: Icon(
                                          Icons.home,
                                          color: Colors.amber,
                                          size: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: [
                                      // if (isfriendfirebase == true)
                                      isfriendfirebase == true
                                          ? Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              // Get.to(Onechat(
                                              //   userModel: model,
                                              //   fromRoomUser: true,
                                              //   //  createUserModel: model,
                                              //   //  userModel: model,
                                              // ));

                                              // print(HomeCubit.get(context)
                                              //     .addfriendsModel
                                              //     .message);
                                            },
                                            color: Colors.yellow,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.message_rounded,
                                              size: 14,
                                            ),
                                            padding:
                                            EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            "الرسائل",
                                            style: TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      )
                                          :
                                      // if (model.isFriend == false)

                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              // HomeCubit.get(context)
                                              //     .addfriend(
                                              //   id: model.userId,
                                              // );

                                              // print(HomeCubit.get(context)
                                              //     .addfriendsModel
                                              //     .message);
                                            },
                                            color: Colors.yellow,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.person_add,
                                              size: 14,
                                            ),
                                            padding:
                                            EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            'إضافه صديق',
                                            style: TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {},
                                            color: kPrimaryLightColor,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons
                                                  .mic_external_off_rounded,
                                              size: 14,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            'كتم الصوت',
                                            style: TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              // Get.to(StackDemo());
                                            },
                                            color: Colors.pink,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.star,
                                              size: 14,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            'البطاقات السحرية',
                                            style: TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);

                                              showModalBottomSheet(
                                                  backgroundColor:
                                                  Colors.transparent,
                                                  context: context,
                                                  builder: (BuildContext
                                                  context) {
                                                    return GiftScreen(
                                                        roomID: roomID,
                                                        userID: document.get(
                                                            'ApiUserID'),
                                                        check: true,
                                                        username: document
                                                            .get('username'
                                                            .toString()) // userID: model.userId
                                                      // .toString(),
                                                    );
                                                  });
                                            },
                                            color: Colors.blueAccent,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.card_giftcard,
                                              size: 14,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            'إرسال هديه',
                                            style: TextStyle(
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                          height: 45,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  width: 1.0,
                                                  color: Colors
                                                      .grey.shade300),
                                              bottom: BorderSide(
                                                  width: 1.0,
                                                  color: Colors.lightBlue
                                                      .shade900),
                                            ),
                                            color: Colors.white,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) =>
                                                          Directionality(
                                                            textDirection:
                                                            TextDirection
                                                                .rtl,
                                                            child:
                                                            AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                      Radius
                                                                          .circular(
                                                                          15))),
                                                              title: Center(
                                                                child: const Text(
                                                                    'هل تريد حظر العضو'),
                                                              ),
                                                              // content: const Text('AlertDialog description'),
                                                              actions: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        HomeCubit
                                                                            .get(
                                                                            context)
                                                                            .addBlockList(
                                                                            id: document
                                                                                .get(
                                                                                'ApiUserID'));
                                                                        Navigator
                                                                            .pop(
                                                                            context,
                                                                            'yes');

                                                                        CommonFunctions
                                                                            .showToast(
                                                                            'تم حظر العضو',
                                                                            Colors
                                                                                .green);
                                                                      },
                                                                      child: const Text(
                                                                          'نعم'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'no'),
                                                                      child: const Text(
                                                                          'لا'),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                    );
                                                    // print(model.userId);
                                                  },
                                                  icon: Icon(
                                                    Icons.logout,
                                                    color: Colors
                                                        .grey.shade400,
                                                    size: 25,
                                                  )),
                                              VerticalDivider(),
                                              IconButton(
                                                  onPressed: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                      context) =>
                                                          Directionality(
                                                            textDirection:
                                                            TextDirection
                                                                .rtl,
                                                            child:
                                                            AlertDialog(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                      Radius
                                                                          .circular(
                                                                          15))),
                                                              title: Center(
                                                                child: const Text(
                                                                    'هل تريد اصمات العضو'),
                                                              ),
                                                              // content: const Text('AlertDialog description'),
                                                              actions: <
                                                                  Widget>[
                                                                Row(
                                                                  mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        ismuted =
                                                                        false;
                                                                        _updateuserDataFirebase(
                                                                            roomID,
                                                                            document
                                                                                .get(
                                                                                'username'),
                                                                            document
                                                                                .get(
                                                                                'idFrom'));

                                                                        _updateMutedFirebase(
                                                                          roomID,
                                                                        );

                                                                        Navigator
                                                                            .pop(
                                                                            context,
                                                                            'yes');

                                                                        CommonFunctions
                                                                            .showToast(
                                                                            'تم اصمات العضو',
                                                                            Colors
                                                                                .green);
                                                                      },
                                                                      child: const Text(
                                                                          'نعم'),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () =>
                                                                          Navigator
                                                                              .pop(
                                                                              context,
                                                                              'no'),
                                                                      child: const Text(
                                                                          'لا'),
                                                                    ),
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                    );

                                                    // FirebaseFirestore.instance
                                                    //     .collection('users')
                                                    //     .doc(model.spacialId)
                                                    //     .add(
                                                    //       model.toMap(),
                                                    //     );
                                                  },
                                                  icon: Icon(
                                                    Icons.block_rounded,
                                                    color: Colors
                                                        .grey.shade400,
                                                    size: 25,
                                                  )),
                                              VerticalDivider(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: Icon(
                                                    Icons.mic,
                                                    color: Colors
                                                        .grey.shade400,
                                                    size: 25,
                                                  )),
                                              VerticalDivider(),
                                              Theme(
                                                  data: Theme.of(context)
                                                      .copyWith(
                                                    dividerTheme:
                                                    DividerThemeData(
                                                      color: Colors.white,
                                                    ),
                                                    cardColor: Colors
                                                        .black
                                                        .withOpacity(0.7),
                                                  ),
                                                  child: PopupMenuButton<
                                                      int>(
                                                    icon: Icon(
                                                      Icons.person,
                                                      color: Colors.green,
                                                      size: 25,
                                                    ),
                                                    onSelected: (item) =>
                                                        onSelected2(
                                                          // context,
                                                            item,
                                                            document.get(
                                                                'ApiUserID'),
                                                            roomID),
                                                    itemBuilder:
                                                        (context) =>
                                                    [
                                                      PopupMenuItem<int>(
                                                          value: 0,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Center(
                                                                child:
                                                                Text(
                                                                  "تعين مشرف",
                                                                  style: TextStyle(
                                                                      color:
                                                                      Colors
                                                                          .white),
                                                                ),
                                                              )
                                                            ],
                                                          )),
                                                      PopupMenuDivider(),
                                                      PopupMenuItem<int>(
                                                          value: 1,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                    "تعين عضو",
                                                                    style:
                                                                    TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              )
                                                            ],
                                                          )),
                                                      PopupMenuDivider(),
                                                      PopupMenuItem<int>(
                                                          value: 2,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Text(
                                                                "ازالة العضو",
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors
                                                                        .white),
                                                              )
                                                            ],
                                                          )),
                                                    ],
                                                  )),
                                            ],
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Container(
                        // height: 70,

                        alignment: Alignment.topCenter,

                        // padding: new EdgeInsets.only(
                        //     top: MediaQuery.of(context).size.height * .58,
                        //     right: 20.0,
                        //     left: 20.0),
                        child: FloatingActionButton(
                          onPressed: () {},
                          child: CircleAvatar(
                            child: Image.asset(
                                "assets/images/Profile Image.png"),
                            backgroundColor: kPrimaryColor,
                            radius: 50,
                          ),
                        ),
                      ),

                      // Container(
                      //   child: FloatingActionButton(
                      //       child: CircleAvatar(
                      //         radius: 50,
                      //         backgroundImage: AssetImage(
                      //           "assets/images/Profile Image.png",
                      //         ),
                      //       ),
                      //       onPressed: () {}),
                      // ),

                      // Positioned(
                      //   top: -10,
                      //   right: 10,
                      //   child: FloatingActionButton(
                      //       child: CircleAvatar(
                      //         radius: 50,
                      //         backgroundImage: AssetImage(
                      //           "assets/images/Profile Image.png",
                      //         ),
                      //       ),
                      //       onPressed: () {}),
                      // )
                    ]),
                  );
                });
          },
        ),
      )
          : document.get('type') == 1
      // Image
          ? Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Container(
              width: 36,
              height: 36,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Image.asset(
                  kDefaultProfileImage,
                  width: 36,
                  height: 36,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  document.get('userType') == 'owner'
                      ? Icon(
                    Icons.person,
                    color: Colors.red,
                  )
                      : Container(),
                  document.get('userType') == 'user'
                      ? Icon(
                    Icons.person,
                    color: Colors.blue,
                  )
                      : Container(),
                  document.get('userType') == 'supervisor'
                      ? Icon(
                    Icons.person,
                    color: kPrimaryLightColor,
                  )
                      : Container(),

                  document.get('packageColor') == null
                      ? Container(
                    child: Text(
                      document.get('username'),
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    color: Colors.transparent,
                    // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                    // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                  )
                      : Container(
                    child: Text(
                      document.get('username'),
                      style: TextStyle(
                          color: HexColor(
                              document.get('packageColor')),
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                    color: Colors.transparent,
                    // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                    // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  document.get('hasSpecialID') == true
                      ? Container(
                    height: 18,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(
                          width: 2,
                          color: Colors.amber,
                        )),
                    child: Center(
                      child: Icon(
                        Icons.person,
                        color: Colors.amber,
                        size: 12,
                      ),
                    ),
                  )
                      : Container(),
                  document.get('packageBadge') != null
                      ? Container(
                    height: 25,
                    width: 25,
                    // decoration: BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     color: HexColor(packageColor),
                    //     border: Border.all(
                    //         width: 2,
                    //         color: HexColor(
                    //             packageColor))),
                    child: Center(
                        child: Image.network(
                            document.get('packageBadge'))),
                  )
                      : Container(),
                  Container(
                    height: 18,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                        border: Border.all(
                          width: 2,
                          color: Colors.amber,
                        )),
                    child: Center(
                      child: Icon(
                        Icons.home,
                        color: Colors.amber,
                        size: 12,
                      ),
                    ),
                  ),

                  // document.get('userType') == 'user'
                  //     ? Icon(
                  //         Icons.person,
                  //         color: Colors.blue,
                  //       )
                  //     : Container(),
                  // document.get('userType') == 'supervisor'
                  //     ? Icon(
                  //         Icons.person,
                  //         color: kPrimaryLightColor,
                  //       )
                  //     : Container(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: OutlinedButton(
                    child: Material(
                      child: Image.network(
                        document.get("content"),
                        loadingBuilder: (BuildContext context,
                            Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade600,
                              borderRadius: BorderRadius.all(
                                Radius.circular(8.0),
                              ),
                            ),
                            width: 200.0,
                            height: 200.0,
                            child: Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null &&
                                    loadingProgress
                                        .expectedTotalBytes !=
                                        null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes
                                    : null,
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, object, stackTrace) {
                          return Material(
                            child: Image.asset(
                              'images/img_not_available.jpeg',
                              width: 200.0,
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            clipBehavior: Clip.hardEdge,
                          );
                        },
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                      BorderRadius.all(Radius.circular(8.0)),
                      clipBehavior: Clip.hardEdge,
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                        padding:
                        MaterialStateProperty.all<EdgeInsets>(
                            EdgeInsets.all(0))),
                  ),
                  // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
              )
            ],
          )
        ],
      )

      // Sticker
          : Container(
        child: Image.asset(
          'images/${document.get('content')}.gif',
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,
        ),
        // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildListMessage(Size size) {
    return Flexible(
      child: widget.roomId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('messages')
            .doc(widget.roomId.toString())
            .collection(widget.roomId.toString())
            .orderBy('timestamp', descending: true)
            .limit(limit)
            .snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> snapshot) {
          print("messaegs: ${snapshot.toString()}");
          if (snapshot.hasData) {
            listMessage.addAll(snapshot.data.docs);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) =>
                  buildItem(
                    index,
                    snapshot.data?.docs[index],
                    size,
                  ),
              itemCount: snapshot.data?.docs.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            );
          }
        },
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
      ),
    );
  }

  Future<bool> _closeRoom() async {
    await CommonFunctions.showAlertWithTwoActions(
        widget.roomId, context, "خروج", "هل تريد الخروج من الغرفة؟", () async {
      // check if this user hold mic or not first
      // var existingItem = _micUsersList.firstWhere(
      //     (itemToCheck) =>
      //         itemToCheck.userId == PreferencesServices.getString(ID_KEY),
      //     orElse: () => null);
      // if (existingItem != null) {
      //   // user already holds mic before
      //   print(existingItem.micNumber);
      //   print(existingItem.userName);
      //   // leave mic
      //   existingItem.userName = null;
      //   existingItem.userId = null;
      //   existingItem.micNumber = existingItem.micNumber;
      //   existingItem.micStatus = false;
      //   finish(context);
      //   // _updateMicsToFirebase(existingItem.micNumber, existingItem);
      // } else {
      {
        finish(context);
      }

      finish(
        context,
      );
    });
    return true;
  }

  static StreamTransformer transformer<T>(
      T Function(Map<String, dynamic> json) fromJson) =>
      StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
        handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
          final snaps = data.docs.map((doc) => doc.data()).toList();
          final users = snaps.map((json) => fromJson(json)).toList();

          sink.add(users);
        },
      );

  // Future<Widget> _userMicItem() async {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           padding: const EdgeInsets.all(16.0),
  //           decoration: BoxDecoration(
  //               color: Colors.grey,
  //               shape: BoxShape.circle,
  //               border: Border.all(width: 2, color: kPrimaryColor)),
  //           child: Icon(
  //             Icons.mic,
  //             color: Colors.white,
  //             size: 28,
  //           ),
  //         ),
  //         2.height,
  //         Text(
  //           "userName",
  //           style: secondaryTextStyle(
  //             color: Colors.white,
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Future getRoomUsers() async {
  //   _isLoadingMics = true;
  //   var collection = FirebaseFirestore.instance.collection('roomUsers');
  //   var docSnapshot = await collection.doc(roomID).collection(roomID).get();
  //   // Map<String, dynamic> data = docSnapshot.docs;
  //   // QuerySnapshot querySnapshot = await _firestoreInstance.collection('roomUsers').doc(roomID).get().;
  //   // // // Get data from docs and convert map to List
  //   if (collection != null && docSnapshot != null) {
  //     // docSnapshot.docs.length > 0 ? _addMicsToFirebase() : null;
  //     roomUsersList = docSnapshot.docs;
  //     setState(() {
  //       _isLoadingMics = false;
  //     });
  //   }
  //   // // roomUsersList = querySnapshot.docs.map((doc) => doc.data()).toList();
  //   // setState(() {
  //   //   _usersCount = roomUsersList.length;
  //   // });
  //   // print(roomUsersList.toString());
  //   // print("userslst: ${roomUsersList.length}");
  //   // roomUsersList.forEach((querySnapshot) {
  //   //   Map<String, dynamic> jsonData = querySnapshot.data();
  //   //   UserMicModel userMicModel = UserMicModel.fromJson(jsonData);
  //   //   print(userMicModel.userId);
  //   //   print("users: ${userMicModel.userName}");
  //   //   print("users: ${querySnapshot.data()['userName']}");
  //   // });
  //   // _firestore.collection('favorites').where('user_id', isEqualTo: uid).getDocuments()
  //   //     .then((querySnap) {
  //   //   querySnap.documents.forEach((document) {
  //   //     print(document.data);
  //   //
  //   //     Map<String, dynamic> json = document.data; //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
  //   //     Album album = new Album.fromJson(json['favorite_albums'][0]); //Throws the type exception
  //   //   });
  //   // })
  //   //     .catchError((error) {
  //   //   print(error);
  //   // });
  // }

  // void _updateMicsToFirebase(int index, UserMicModel micModel) async {
  //   print("inUpdate doc: $index");
  //   print("name: ${micModel.userName}");
  //   print("id: ${micModel.userId}");
  //   CollectionReference _collectionRef = FirebaseFirestore.instance
  //       .collection('roomUsers')
  //       .doc(widget.roomId)
  //       .collection(widget.roomId);
  //   await _collectionRef.doc("$index").update({
  //     "id": micModel.id,
  //     "userId": micModel.userId,
  //     "userName": micModel.userName,
  //     "micNumber": micModel.micNumber,
  //     "micStatus": micModel.micStatus,
  //     "isLocked": micModel.isLocked
  //   }).catchError((e) {
  //     print(e);
  //     return;
  //   });
  //   setState(() {
  //     micModel.micStatus
  //         ? _engine
  //             .setClientRole(
  //             ClientRole.Broadcaster,
  //           )
  //             .then(
  //             (value) {
  //               print("Broadcaster user");
  //             },
  //           )
  //         : _engine
  //             .setClientRole(
  //             ClientRole.Audience,
  //           )
  //             .then(
  //             (value) {
  //               print("Audience user");
  //             },
  //           );
  //   });
  // }

  // Widget _personInRoom(int index, UserMicModel micModel) {
  //   return Expanded(
  //     child: Container(
  //       child: Column(
  //         children: [
  //           Stack(
  //             alignment: Alignment.center,
  //             children: [
  //               isHaveFrame == ''
  //                   ? Stack(
  //                       alignment: Alignment.center,
  //                       children: [
  //                         Container(
  //                             width: 50,
  //                             child: Image.network(
  //                                 'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
  //                         // Back image
  //                         Container(
  //                             padding: const EdgeInsets.all(6.0),
  //                             decoration: BoxDecoration(
  //                                 color: Colors.grey,
  //                                 shape: BoxShape.circle,
  //                                 border: Border.all(
  //                                     width: 2, color: kPrimaryColor)),
  //                             child: Icon(
  //                               micModel.isLocked != null
  //                                   ? micModel.isLocked
  //                                       ? Icons.lock
  //                                       : Icons.mic
  //                                   : Icons.mic,
  //                               color: Colors.white,
  //                               size: 26,
  //                             ))
  //                       ],
  //                     )
  //                   :
  //                   // Back image
  //                   Container(
  //                       padding: const EdgeInsets.all(6.0),
  //                       decoration: BoxDecoration(
  //                           color: Colors.grey,
  //                           shape: BoxShape.circle,
  //                           border: Border.all(width: 2, color: kPrimaryColor)),
  //                       child: Icon(
  //                         micModel.isLocked != null
  //                             ? micModel.isLocked
  //                                 ? Icons.lock
  //                                 : Icons.mic
  //                             : Icons.mic,
  //                         color: Colors.white,
  //                         size: 26,
  //                       )),
  //             ],
  //           ),
  //           2.height,
  //           Text(
  //             "${index + 1}",
  //             overflow: TextOverflow.ellipsis,
  //             style: secondaryTextStyle(size: 12, color: black),
  //           ),
  //         ],
  //       ),
  //     ).onTap(() {
  //       {
  //         print(index);

  //         HomeCubit.get(context).joinmics(id: roomID, micsnumber: index);
  //         setState(() {
  //           isHaveFrame = '';
  //         });
  //         // showDialog(
  //         //     context: context,
  //         //     builder: (BuildContext context) {
  //         //       return MicClickDialog(
  //         //         takeMicFunction: () {
  //         //           // go to new mic
  //         //           micModel.id = index.toString();
  //         //           micModel.userName = PreferencesServices.getString(Name_KEY);
  //         //           micModel.userId = PreferencesServices.getString(ID_KEY);
  //         //           micModel.micNumber = index;
  //         //           micModel.micStatus = true;
  //         //           micModel.isLocked = false;
  //         //           print("name: ${micModel.userName}");
  //         //           print("userId: ${micModel.userId}");
  //         //           print("micNumber: ${micModel.micNumber}");
  //         //           print("id: ${micModel.micNumber}");
  //         //           print("micStatus: ${micModel.micStatus}");
  //         //           _updateMicsToFirebase(index, micModel);
  //         //           finish(context);
  //         //         },
  //         //         leaveMicFunction: () {
  //         //           finish(context);
  //         //         },
  //         //         lockMicFunction: () {},
  //         //         unLockMicFunction: () {},
  //         //         showTakeMic: true,
  //         //         showLeaveMic: true,
  //         //         showLockMic: false,
  //         //         micIsLocked: false,
  //         //       );
  //         //     });
  //       }

  //       // else{
  //       //   print("_micUsersList: ${_micUsersList.length}");
  //       //   //find existing item per link criteria
  //       //           var existingItem = _micUsersList.firstWhere((itemToCheck) => itemToCheck.userId == PreferencesServices.getString(ID_KEY), orElse: () => null);
  //       //           if(existingItem != null){
  //       //             // user already holds mic before
  //       //             print(existingItem.micNumber);
  //       //             print(existingItem.userName);
  //       //             print("take other mic");
  //       //             showDialog(context: context,
  //       //                 builder: (BuildContext context){
  //       //                   return MicClickDialog(takeMicFunction: (){
  //       //                     print("clicked take");
  //       //                     print("clicked index: $index");
  //       //                     // leave old mic
  //       //                     existingItem.id = null;
  //       //                     existingItem.userName = null;
  //       //                     existingItem.userId = null;
  //       //                     existingItem.micNumber = existingItem.micNumber;
  //       //                     existingItem.micStatus = false;
  //       //                     _updateMicsToFirebase(existingItem.micNumber, existingItem);
  //       //                     print("existname: ${existingItem.userName}");
  //       //                     print("existuserId: ${existingItem.userId}");
  //       //                     print("existmicNumber: ${existingItem.micNumber}");
  //       //                     print("existid: ${existingItem.micNumber}");
  //       //                     print("existmicStatus: ${existingItem.micStatus}");
  //       //
  //       //                     // go to new mic
  //       //                     micModel.id = index.toString();
  //       //                     micModel.userName = PreferencesServices.getString(Name_KEY);
  //       //                     micModel.userId = PreferencesServices.getString(ID_KEY);
  //       //                     micModel.micNumber = index;
  //       //                     micModel.micStatus = true;
  //       //                     print("name: ${micModel.userName}");
  //       //                     print("userId: ${micModel.userId}");
  //       //                     print("micNumber: ${micModel.micNumber}");
  //       //                     print("id: ${micModel.micNumber}");
  //       //                     print("micStatus: ${micModel.micStatus}");
  //       //                     finish(context);
  //       //                     _updateMicsToFirebase(index, micModel);
  //       //                   }, leaveMicFunction: (){
  //       //                     print("leave index: $index");
  //       //                     finish(context);
  //       //                   });
  //       //                 }
  //       //             );
  //       //           } else{
  //       //             print("not take other mic");
  //       //             showDialog(context: context,
  //       //                 builder: (BuildContext context){
  //       //                   return MicClickDialog(takeMicFunction: (){
  //       //                     print("clicked take");
  //       //                     print("clicked index: $index");
  //       //                     micModel.id = "$index";
  //       //                     micModel.userName = PreferencesServices.getString(Name_KEY);
  //       //                     micModel.userId = PreferencesServices.getString(ID_KEY);
  //       //                     micModel.micNumber = index;
  //       //                     micModel.micStatus = true;
  //       //                     print("name: ${micModel.userName}");
  //       //                     print("userId: ${micModel.userId}");
  //       //                     print("micNumber: ${micModel.micNumber}");
  //       //                     print("id: ${micModel.micNumber}");
  //       //                     print("micStatus: ${micModel.micStatus}");
  //       //                     finish(context);
  //       //                     _updateMicsToFirebase(index, micModel);
  //       //
  //       //                   }, leaveMicFunction: (){
  //       //                     print("leave index: $index");
  //       //                     finish(context);
  //       //                   });
  //       //                 }
  //       //             );
  //       //           }
  //       // }
  //     }),
  //   );
  // }

  // Widget roomMicslayout(int micnum) => Container(
  //       padding: const EdgeInsets.all(6.0),
  //       child: Stack(
  //         alignment: Alignment.center,
  //         children: [
  //           isHaveFrame == ''
  //               ? Stack(
  //                   alignment: Alignment.center,
  //                   children: [
  //                     Container(
  //                         width: 50,
  //                         child: Image.network(
  //                             'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
  //                     // Back image
  //                     Container(
  //                       width: double.infinity,
  //                       // margin: const EdgeInsets.only(top:10, right: 60),
  //                       child: IconButton(
  //                         icon: Icon(Icons.mic),
  //                         onPressed: () {
  //                           // setState(() {
  //                           //   test = true;
  //                           // });
  //                           // HomeCubit.get(context)
  //                           //     .joinmics(id: roomID, micsnumber: '3');
  //                         },
  //                       ),
  //                       // child: _roomMicsLayout(),
  //                     ),
  //                   ],
  //                 )
  //               : // Back image
  //               Container(
  //                   width: double.infinity,
  //                   // margin: const EdgeInsets.only(top:10, right: 60),
  //                   child: IconButton(
  //                     icon: Icon(Icons.mic),
  //                     onPressed: () {
  //                       HomeCubit.get(context)
  //                           .joinmics(id: roomID, micsnumber: '3');
  //                       var model = HomeCubit.get(context).micModel;
  //                     },
  //                   )
  //                   // child: _roomMicsLayout(),
  //                   ),
  //         ],
  //       ),
  //       // child: Stack(
  //       //   // fit: StackFit.expand,
  //       //   // overflow: Overflow.visible,
  //       //   children: [
  //       //     Container(
  //       //       width: double.infinity,
  //       //       // margin: const EdgeInsets.only(top:10, right: 60),
  //       //       child: IconButton(
  //       //         icon: Icon(Icons.mic),
  //       //         onPressed: () {
  //       //           HomeCubit.get(context).joinmics(
  //       //               id: roomID, micsnumber: '3');
  //       //         },
  //       //       ),
  //       //       // child: _roomMicsLayout(),
  //       //     ),
  //       //     // Positioned(
  //       //     //   top: 0,
  //       //     //   right: 0,
  //       //     //   child: _isMicHold?Container(): Container(
  //       //     //   // width: 68,
  //       //     //   // height: 68,
  //       //     //     padding: const EdgeInsets.all(6.0),
  //       //     //   decoration: BoxDecoration(
  //       //     //     shape: BoxShape.circle,
  //       //     //     color: Colors.white,
  //       //     //     border: Border.all(color: kPrimaryColor.withOpacity(0.4), width: 2.0),
  //       //     //   ),
  //       //     //   child: Column(
  //       //     //     mainAxisAlignment: MainAxisAlignment.center,
  //       //     //     children: [
  //       //     //       Icon(Icons.mic,color: kPrimaryColor, size: 28,),
  //       //     //       Text("طلب مايك", style: secondaryTextStyle(color: kPrimaryColor, size: 12),)
  //       //     //     ],
  //       //     //   ),
  //       //     // ).onTap(() {
  //       //     //
  //       //     // }),),
  //       //   ],
  //       // ),
  //     );
  // Text(micnum.toString()),
//////////////////////////////////////////////////////////////////   hashedcode
  Widget _roomMicsLayout() {
    Stream<List<UserMicModel>> _stream = _firestoreInstance
        .collection('roomUsers')
        .doc(widget.roomId)
        .collection(widget.roomId)
        .snapshots()
        .transform(transformer((json) => UserMicModel.fromJson(json)));
    return StreamBuilder<List<UserMicModel>>(
        stream: _stream,
        builder:
            (BuildContext context, AsyncSnapshot<List<UserMicModel>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            print(":has data");
            _micUsersList = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3.0),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
                    return _personInRoom(
                      index,
                      snapshot.data[index],
                    );
                  }).toList(),
                  // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    // index = 5;
                    // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
                    return _personInRoom(
                      index + 5,
                      snapshot.data[index + 5],
                    );
                  }).toList(),
                  // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
                ),
              ]),
              // child: Container(
              //   height: 100,
              //   child: ListView.builder(
              //       scrollDirection: Axis.horizontal,
              //       // shrinkWrap: true,
              //       itemCount: 5,
              //       itemBuilder: (BuildContext context, int index){
              //     return _personInRoom(index, snapshot.data[index],);
              //   }),
              // ),
            );
          } else {
            print("not has data");
            List<UserMicModel> _micsList = [];

            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 0,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 1,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 2,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 3,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 4,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 5,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 6,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 7,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 8,
                micStatus: false,
                isLocked: false));
            _micsList.add(UserMicModel(
                id: null,
                userId: null,
                userName: null,
                micNumber: 9,
                micStatus: false,
                isLocked: false));
            //  _micsList.add(UserMicModel(
            // id: null,
            // userId: null,
            // userName: null,
            // micNumber: 8,
            // micStatus: false,
            // isLocked: false));
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  _personInRoom(
                    0,
                    _micsList[0],
                  ),
                  _personInRoom(
                    1,
                    _micsList[1],
                  ),
                  _personInRoom(
                    2,
                    _micsList[2],
                  ),
                  _personInRoom(
                    3,
                    _micsList[3],
                  ),
                  _personInRoom(
                    4,
                    _micsList[4],
                  ),
                  _personInRoom(
                    5,
                    _micsList[5],
                  ),
                  _personInRoom(
                    6,
                    _micsList[6],
                  ),
                  _personInRoom(
                    7,
                    _micsList[7],
                  ),
                  _personInRoom(
                    8,
                    _micsList[8],
                  ),
                  _personInRoom(
                    9,
                    _micsList[9],
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.all(5.0),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
            itemBuilder: (context, index) {
              bool _isThisMic;
              for (var map in roomUsersList) {
                _micUsersList.add(UserMicModel.fromJson(map));
                // if (roomUsersList[index].data().containsKey("micNumber")) {
                //     if (roomUsersList[index].data()["micNumber"] == "${index +1}") {
                //       // your list of map contains key "id" which has value 3
                //       // CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
                //       // print("id: ${map.data()["userId"]}");
                //       setState(() {
                //         _isThisMic = true;
                //       });
                //     }
                //   }
              }
              return Container(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                          border: Border.all(width: 1, color: kPrimaryColor)),
                      child: Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    2.height,
                    Text(
                      roomUsersList[index].data() != null
                          ? "${roomUsersList[index].data()}"
                          : "${index + 1}",
                      style: secondaryTextStyle(color: Colors.white, size: 16),
                    ),
                  ],
                ),
              ).onTap(() {
                print("changeRole: to broadCast");
                // for (var map in roomUsersList) {
                //   if (map.data().containsKey("micNumber")) {
                //     if (map.data()["micNumber"] == "${index +1}") {
                //       // your list of map contains key "id" which has value 3
                //       CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
                //       print("id: ${map.data()["userId"]}");
                //       return;
                //     }
                //   }
                // }
                _firestoreInstance
                    .collection('roomUsers')
                    .doc(roomID)
                    .collection(roomID)
                    .add({
                  'micNumber': "${index + 1}",
                  'userId': PreferencesServices.getString(ID_KEY),
                  "userName": PreferencesServices.getString(Name_KEY)
                }).then((value) {
                  setState(() {
                    // _isMicHold = true;
                    _roomUsersCount++;
                    _engine
                        .setClientRole(
                      ClientRole.Broadcaster,
                    )
                        .then(
                          (value) {},
                    );
                  });
                });
              });
            },
            itemCount: 5,
            controller: listScrollController,
          );
        });
  }

  void _updateuserDataFirebase(String id, String name, String roomID) async {
    print("inUpdate doc: $id");
    print("name: $name");
    print("id: $roomID");

    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('UsersInRoom')
        .doc(id)
        .collection(id);
    await _collectionRef.doc(roomID).update({
      'username': name,
      'userID': roomID,
      'roomId': id,
      'state': ismuted
    }).catchError((e) {
      print("error in _updateuserDataFirebase " + e);
      return;
    });
    // setState(() {
    //   micModel.micStatus
    //       ? _engine
    //           .setClientRole(
    //           ClientRole.Broadcaster,
    //         )
    //           .then(
    //           (value) {
    //             print("Broadcaster user");
    //           },
    //         )
    //       : _engine
    //           .setClientRole(
    //           ClientRole.Audience,
    //         )
    //           .then(
    //           (value) {
    //             print("Audience user");
    //           },
    //         );
    // });
  }

  void _updateMutedFirebase(String roomID) async {
    // print("inUpdate doc: $index");
    // print("name: ${micModel.userName}");
    // print("id: ${micModel.userId}");
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('roomUsers')
        .doc(roomID)
        .collection(roomID);
    await _collectionRef.doc("0").update({
      "id": null,
      "userId": null,
      "userName": null,
      "micNumber": null,
      "micStatus": false,
      "isLocked": false
    }).catchError((e) {
      print(e);
      return;
    });
    // setState(() {
    //   micModel.micStatus
    //       ? _engine
    //           .setClientRole(
    //           ClientRole.Broadcaster,
    //         )
    //           .then(
    //           (value) {
    //             print("Broadcaster user");
    //           },
    //         )
    //       : _engine
    //           .setClientRole(
    //           ClientRole.Audience,
    //         )
    //           .then(
    //           (value) {
    //             print("Audience user");
    //           },
    //         );
    // });
  }

  void _updateMicsToFirebase(int index, UserMicModel micModel) async {
    print("inUpdate doc: $index");
    print("name: ${micModel.userName}");
    print("id: ${micModel.userId}");
    CollectionReference _collectionRef = FirebaseFirestore.instance
        .collection('roomUsers')
        .doc(roomID)
        .collection(roomID);
    await _collectionRef.doc("$index").update({
      "id": micModel.id,
      "userId": micModel.userId,
      "userName": micModel.userName,
      "micNumber": micModel.micNumber,
      "micStatus": micModel.micStatus,
      "isLocked": micModel.isLocked
    }).catchError((e) {
      print(e);
      return;
    });
    // setState(() {
    //   micModel.micStatus
    //       ? _engine
    //           .setClientRole(
    //           ClientRole.Broadcaster,
    //         )
    //           .then(
    //           (value) {
    //             print("Broadcaster user");
    //           },
    //         )
    //       : _engine
    //           .setClientRole(
    //           ClientRole.Audience,
    //         )
    //           .then(
    //           (value) {
    //             print("Audience user");
    //           },
    //         );
    // });
  }

  Widget builditem(InRoomUserModelModelData model, BuildContext context) =>
      InkWell(
        child: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(
                    "assets/images/Profile Image.png",
                  ),
                ),
              ),
              SizedBox(
                height: 2,
                // width: 10.0,
              ),
              Text(
                model.name.toString(),
                // style: TextStyle(fontSize: 10),
                style: TextStyle(color: Colors.white, fontSize: 10),
              ),
              Spacer(),
            ],
          ),
        ),
        onTap: () {
          showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent, // <-- SEE HERE

              // shape: RoundedRectangleBorder(
              //     // <-- SEE HERE
              //     borderRadius: BorderRadius.circular(60)),
              isScrollControlled: true,
              builder: (context) {
                // return Stack(
                //   children: <Widget>[
                //     // The containers in the background
                //     FractionallySizedBox(
                //       heightFactor: 0.40,
                //       child: Column(
                //         children: <Widget>[
                //           Container(
                //               // height: MediaQuery.of(context).size.height * .50,
                //               // color: Colors.blue,
                //               ),
                //           Container(
                //             // height: MediaQuery.of(context).size.height * .20,
                //             color: Colors.white,
                //             child: Center(
                //               child: Text("aaaaa"),
                //             ),
                //           )
                //         ],
                //       ),
                //     ),
                //     // The card widget with top padding,
                //     // incase if you wanted bottom padding to work,
                //     // set the `alignment` of container to Alignment.bottomCenter
                //     new Container(
                //       alignment: Alignment.topCenter,
                //       padding: new EdgeInsets.only(
                //           top: MediaQuery.of(context).size.height * .58,
                //           right: 20.0,
                //           left: 20.0),
                //       child: new Container(
                //         // height: 200.0,
                //         // width: MediaQuery.of(context).size.width,
                //         child: CircleAvatar(
                //           child: Image.asset("assets/images/Profile Image.png"),
                //           backgroundColor: kPrimaryColor,
                //           radius: 50,
                //         ),
                //       ),
                //     )
                //   ],
                // );
                return FractionallySizedBox(
                  heightFactor: 0.42,
                  child: Stack(children: [
                    Column(
                      children: [
                        new Container(
                          height: 25,
                          color: Colors.transparent.withOpacity(0.0),
                        ),
                        Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)),
                          ),
                          // color: Colors.amber,

                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 12),
                                    child: Container(
                                      height: 22,
                                      width: 25,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.orange,
                                      ),
                                      child: Center(
                                        child: Text(
                                          "@",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 12),
                                    child: Container(
                                      height: 22,
                                      width: 25,
                                      child: Icon(
                                        Icons.report_problem_outlined,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                  )
                                  // IconButton(
                                  //   onPressed: () {},
                                  //   icon: Icon(Icons.report_gmailerrorred),
                                  // ),

                                  // Spacer(),
                                ],
                              ),
                              // Container(
                              //   height: 35,
                              //   color: Colors.transparent.withOpacity(0.5),

                              //   // color: Colors.grey.withOpacity(0.5),
                              //   // decoration: BoxDecoration(
                              //   //   color: Colors.transparent.withOpacity(0.5),
                              //   //   borderRadius: BorderRadius.only(
                              //   //     // topRight: Radius.circular(10),
                              //   //     bottomRight: Radius.circular(10),
                              //   //     bottomLeft: Radius.circular(10),
                              //   //     // topLeft: Radius.circular(10),
                              //   //   ),

                              //   //   // shape: BoxShape.circle,
                              //   // ),
                              //   // height: MediaQuery.of(context).size.height * .20,
                              //   //             color: Colors.white,
                              //   //             child: Center(
                              //   //               child: Text("aaaaa"),
                              //   //             ),
                              // ),

                              // Container(
                              //   child: FloatingActionButton(
                              //       child: CircleAvatar(
                              //         radius: 50,
                              //         backgroundImage: AssetImage(
                              //           "assets/images/Profile Image.png",
                              //         ),
                              //       ),
                              //       onPressed: () {}),
                              // ),
                              // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

                              SizedBox(
                                height: 20,
                              ),
                              Text(model.name.toString()),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Text(text),
                                  if (model.typeUser == 'user')
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: kPrimaryColor,
                                              style: BorderStyle.solid,
                                            ),
                                            // shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                                'عضو',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ))),
                                    ),
                                  if (model.typeUser == 'supervisor')
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: kPrimaryColor,
                                              style: BorderStyle.solid,
                                            ),
                                            // shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                                'مشرف',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ))),
                                    ),
                                  if (model.typeUser == 'owner')
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                              topLeft: Radius.circular(10),
                                            ),
                                            border: Border.all(
                                              width: 1,
                                              color: kPrimaryColor,
                                              style: BorderStyle.solid,
                                            ),
                                            // shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                              child: Text(
                                                'مالك',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ))),
                                    ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'ID:${model.spacialId}',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "LV ${model.level.userCurrentLevel
                                        .toString()}",
                                    style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 18,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.amber,
                                        )),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 18,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.amber,
                                        )),
                                    child: Center(
                                      child: Icon(
                                        Icons.markunread_mailbox,
                                        color: Colors.amber,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    height: 18,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        border: Border.all(
                                          width: 2,
                                          color: Colors.amber,
                                        )),
                                    child: Center(
                                      child: Icon(
                                        Icons.home,
                                        color: Colors.amber,
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (model.isFriend == true)
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              Get.to(Onechat(
                                                user: model,
                                                fromRoomUser: true,
                                                //  createUserModel: model,
                                                //  userModel: model,
                                              ));

                                              // print(HomeCubit.get(context)
                                              //     .addfriendsModel
                                              //     .message);
                                            },
                                            color: Colors.yellow,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.message_rounded,
                                              size: 14,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            "الرسائل",
                                            style:
                                            TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    if (model.isFriend == false)
                                      Column(
                                        children: [
                                          MaterialButton(
                                            onPressed: () {
                                              HomeCubit.get(context).addfriend(
                                                id: model.userId,
                                              );

                                              // print(HomeCubit.get(context)
                                              //     .addfriendsModel
                                              //     .message);
                                            },
                                            color: Colors.yellow,
                                            textColor: Colors.white,
                                            child: Icon(
                                              Icons.person_add,
                                              size: 14,
                                            ),
                                            padding: EdgeInsets.all(16),
                                            shape: CircleBorder(),
                                          ),
                                          Text(
                                            'إضافه صديق',
                                            style:
                                            TextStyle(color: Colors.grey),
                                          )
                                        ],
                                      ),
                                    Column(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {},
                                          color: kPrimaryLightColor,
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.mic_external_off_rounded,
                                            size: 14,
                                          ),
                                          padding: EdgeInsets.all(16),
                                          shape: CircleBorder(),
                                        ),
                                        Text(
                                          'كتم الصوت',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            // Get.to(StackDemo());
                                          },
                                          color: Colors.pink,
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.star,
                                            size: 14,
                                          ),
                                          padding: EdgeInsets.all(16),
                                          shape: CircleBorder(),
                                        ),
                                        Text(
                                          'البطاقات السحرية',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        MaterialButton(
                                          onPressed: () {
                                            Navigator.pop(context);

                                            showModalBottomSheet(
                                                backgroundColor:
                                                Colors.transparent,
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return GiftScreen(
                                                    roomID: roomID,
                                                    userID:
                                                    model.userId.toString(),
                                                    check: true,
                                                    username: model.name,
                                                    // userID: model.userId
                                                    // .toString(),
                                                  );
                                                });
                                          },
                                          color: Colors.blueAccent,
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.card_giftcard,
                                            size: 14,
                                          ),
                                          padding: EdgeInsets.all(16),
                                          shape: CircleBorder(),
                                        ),
                                        Text(
                                          'إرسال هديه',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                        height: 45,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            top: BorderSide(
                                                width: 1.0,
                                                color: Colors.grey.shade300),
                                            bottom: BorderSide(
                                                width: 1.0,
                                                color:
                                                Colors.lightBlue.shade900),
                                          ),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) =>
                                                        Directionality(
                                                          textDirection:
                                                          TextDirection.rtl,
                                                          child: AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    15))),
                                                            title: Center(
                                                              child: const Text(
                                                                  'هل تريد حظر العضو'),
                                                            ),
                                                            // content: const Text('AlertDialog description'),
                                                            actions: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      HomeCubit
                                                                          .get(
                                                                          context)
                                                                          .addBlockList(
                                                                          id: model
                                                                              .userId);
                                                                      Navigator
                                                                          .pop(
                                                                          context,
                                                                          'yes');

                                                                      CommonFunctions
                                                                          .showToast(
                                                                          'تم حظر العضو',
                                                                          Colors
                                                                              .green);
                                                                    },
                                                                    child:
                                                                    const Text(
                                                                        'نعم'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator
                                                                            .pop(
                                                                            context,
                                                                            'no'),
                                                                    child:
                                                                    const Text(
                                                                        'لا'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.logout,
                                                  color: Colors.grey.shade400,
                                                  size: 25,
                                                )),
                                            VerticalDivider(),
                                            IconButton(
                                                onPressed: () {
                                                  showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext
                                                    context) =>
                                                        Directionality(
                                                          textDirection:
                                                          TextDirection.rtl,
                                                          child: AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                    .circular(
                                                                    15))),
                                                            title: Center(
                                                              child: const Text(
                                                                  'هل تريد اصمات العضو'),
                                                            ),
                                                            // content: const Text('AlertDialog description'),
                                                            actions: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      ismuted =
                                                                      false;
                                                                      _updateuserDataFirebase(
                                                                          roomID,
                                                                          model
                                                                              .name,
                                                                          model
                                                                              .spacialId);

                                                                      _updateMutedFirebase(
                                                                        roomID,
                                                                      );

                                                                      Navigator
                                                                          .pop(
                                                                          context,
                                                                          'yes');

                                                                      // CommonFunctions
                                                                      //     .showToast(
                                                                      //         'تم اصمات العضو',
                                                                      //         Colors
                                                                      //             .green);
                                                                    },
                                                                    child:
                                                                    const Text(
                                                                        'نعم'),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator
                                                                            .pop(
                                                                            context,
                                                                            'no'),
                                                                    child:
                                                                    const Text(
                                                                        'لا'),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.block_rounded,
                                                  color: Colors.grey.shade400,
                                                  size: 25,
                                                )),
                                            VerticalDivider(),
                                            IconButton(
                                                onPressed: () {},
                                                icon: Icon(
                                                  Icons.mic,
                                                  color: Colors.grey.shade400,
                                                  size: 25,
                                                )),
                                            VerticalDivider(),
                                            Theme(
                                                data:
                                                Theme.of(context).copyWith(
                                                  dividerTheme:
                                                  DividerThemeData(
                                                    color: Colors.white,
                                                  ),
                                                  cardColor: Colors.black
                                                      .withOpacity(0.7),
                                                ),
                                                child: PopupMenuButton<int>(
                                                  icon: Icon(
                                                    Icons.person,
                                                    color: Colors.green,
                                                    size: 25,
                                                  ),
                                                  onSelected: (item) =>
                                                      onSelected1(context, item,
                                                          model.userId, roomID),
                                                  itemBuilder: (context) =>
                                                  [
                                                    PopupMenuItem<int>(
                                                        value: 0,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "تعين مشرف",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuDivider(),
                                                    PopupMenuItem<int>(
                                                        value: 1,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                  "تعين عضو",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            )
                                                          ],
                                                        )),
                                                    PopupMenuDivider(),
                                                    PopupMenuItem<int>(
                                                        value: 2,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Text(
                                                              "ازالة العضو",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            )
                                                          ],
                                                        )),
                                                  ],
                                                )),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Container(
                      // height: 70,

                      alignment: Alignment.topCenter,

                      // padding: new EdgeInsets.only(
                      //     top: MediaQuery.of(context).size.height * .58,
                      //     right: 20.0,
                      //     left: 20.0),
                      child: FloatingActionButton(
                        onPressed: () {},
                        child: CircleAvatar(
                          child: Image.asset("assets/images/Profile Image.png"),
                          backgroundColor: kPrimaryColor,
                          radius: 50,
                        ),
                      ),
                    ),

                    // Container(
                    //   child: FloatingActionButton(
                    //       child: CircleAvatar(
                    //         radius: 50,
                    //         backgroundImage: AssetImage(
                    //           "assets/images/Profile Image.png",
                    //         ),
                    //       ),
                    //       onPressed: () {}),
                    // ),

                    // Positioned(
                    //   top: -10,
                    //   right: 10,
                    //   child: FloatingActionButton(
                    //       child: CircleAvatar(
                    //         radius: 50,
                    //         backgroundImage: AssetImage(
                    //           "assets/images/Profile Image.png",
                    //         ),
                    //       ),
                    //       onPressed: () {}),
                    // )
                  ]),
                );
              });
        },
      );

// Widget _roomMicsLayout() {
//   return Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 12.0),
//     child: Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//                 child: InkWell(
//                     child: Container(
//                       child: Column(
//                         children: [
//                           Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               // isHaveFrame == isHaveFrame &&
//                               //         micIndex == 1 &&
//                               //         roomID == roomID
//                               // ? Stack(
//                               //     alignment: Alignment.center,
//                               //     children: [
//                               //       Container(
//                               //           width: 60,
//                               //           child: Image.network(
//                               //               'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                               //       // Back image
//                               //       Container(
//                               //           padding:
//                               //               const EdgeInsets.all(6.0),
//                               //           decoration: BoxDecoration(
//                               //               color: Colors.grey,
//                               //               shape: BoxShape.circle,
//                               //               border: Border.all(
//                               //                   width: 2,
//                               //                   color: kPrimaryColor)),
//                               //           child: Icon(
//                               //             Icons.mic,
//                               //             color: Colors.white,
//                               //             size: 26,
//                               //           ))
//                               //     ],
//                               //   )
//                               // :
//                               // Back image
//                               Container(
//                                   width: 50,
//                                   padding: const EdgeInsets.all(6.0),
//                                   decoration: BoxDecoration(
//                                       color: Colors.grey,
//                                       shape: BoxShape.circle,
//                                       border: Border.all(
//                                           width: 2, color: kPrimaryColor)),
//                                   child: Icon(
//                                     Icons.mic,
//                                     color: Colors.white,
//                                     size: 35,
//                                   )

//                                   // child:
//                                   //     Image.asset("assets/icons/micIcon.png"),
//                                   ),
//                             ],
//                           ),
//                           2.height,
//                           Text(
//                             "1",
//                             overflow: TextOverflow.ellipsis,
//                             style: secondaryTextStyle(size: 12, color: black),
//                           )
//                         ],
//                       ),
//                     ),
//                     onTap: () async {
//                       // await Permission.microphone.request();

//                       // return DetailsScreen(
//                       //   roomId: widget.roomId,
//                       //   // role: ClientRole.Broadcaster,
//                       // );
//                       // setState(() {
//                       //   micIndex = 1;
//                       //   HomeCubit.get(context)
//                       //       .joinmics(id: roomID, micsnumber: micIndex);
//                       // });
//                     })),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 2 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "2",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = '';
//                     micIndex = 2;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 3 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "3",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = ' ';
//                     micIndex = 3;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 4 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "4",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   print(micIndex);

//                   // setState(() {
//                   //   isHaveFrame = null;
//                   //   micIndex = 4;
//                   // });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 5 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "5",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 5;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 10,
//         ),
//         Row(
//           children: [
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 6 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "6",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 6;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 7 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "7",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 7;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 8 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "8",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 8;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 9 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "9",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 9;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//             Expanded(
//               child: Container(
//                 child: Column(
//                   children: [
//                     Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         // isHaveFrame == null &&
//                         //         micIndex == 10 &&
//                         //         roomID == roomID
//                         //     ? Stack(
//                         //         alignment: Alignment.center,
//                         //         children: [
//                         //           Container(
//                         //               width: 60,
//                         //               child: Image.network(
//                         //                   'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif')),
//                         //           // Back image
//                         //           Container(
//                         //               padding: const EdgeInsets.all(6.0),
//                         //               decoration: BoxDecoration(
//                         //                   color: Colors.grey,
//                         //                   shape: BoxShape.circle,
//                         //                   border: Border.all(
//                         //                       width: 2,
//                         //                       color: kPrimaryColor)),
//                         //               child: Icon(
//                         //                 Icons.mic,
//                         //                 color: Colors.white,
//                         //                 size: 26,
//                         //               ))
//                         //         ],
//                         //       )
//                         //     :
//                         // Back image
//                         Container(
//                             width: 50,
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.grey,
//                                 shape: BoxShape.circle,
//                                 border: Border.all(
//                                     width: 2, color: kPrimaryColor)),
//                             child: Icon(
//                               Icons.mic,
//                               color: Colors.white,
//                               size: 35,
//                             )

//                             // child:
//                             //     Image.asset("assets/icons/micIcon.png"),
//                             ),
//                       ],
//                     ),
//                     2.height,
//                     Text(
//                       "10",
//                       overflow: TextOverflow.ellipsis,
//                       style: secondaryTextStyle(size: 12, color: black),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 {
//                   setState(() {
//                     isHaveFrame = null;
//                     micIndex = 4;
//                   });

//                   HomeCubit.get(context)
//                       .joinmics(id: roomID, micsnumber: micIndex);
//                 }
//               }),
//             ),
//           ],
//         )
//       ],
//     ),
//   );

//   // return ListView.builder(
//   //   shrinkWrap: true,
//   //   scrollDirection: Axis.horizontal,
//   //   physics: NeverScrollableScrollPhysics(),
//   //   padding: EdgeInsets.all(5.0),
//   //   // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
//   //   itemBuilder: (context, index) {
//   //     bool _isThisMic;
//   //     for (var map in roomUsersList) {
//   //       // _micUsersList.add(UserMicModel.fromJson(map));
//   //       // if (roomUsersList[index].data().containsKey("micNumber")) {
//   //       //     if (roomUsersList[index].data()["micNumber"] == "${index +1}") {
//   //       //       // your list of map contains key "id" which has value 3
//   //       //       // CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
//   //       //       // print("id: ${map.data()["userId"]}");
//   //       //       setState(() {
//   //       //         _isThisMic = true;
//   //       //       });
//   //       //     }
//   //       //   }
//   //     }
//   //     return Container(
//   //       child: Column(
//   //         children: [
//   //           Container(
//   //             padding: const EdgeInsets.all(6.0),
//   //             decoration: BoxDecoration(
//   //                 color: Colors.grey,
//   //                 shape: BoxShape.circle,
//   //                 border: Border.all(width: 1, color: kPrimaryColor)),
//   //             child: Icon(
//   //               Icons.mic,
//   //               color: Colors.white,
//   //               size: 28,
//   //             ),
//   //           ),
//   //           2.height,
//   //           Text(
//   //             roomUsersList[index].data() != null
//   //                 ? "${roomUsersList[index].data()["userName"]}"
//   //                 : "${index + 1}",
//   //             style: secondaryTextStyle(color: Colors.white, size: 16),
//   //           ),
//   //         ],
//   //       ),
//   //     ).onTap(() {
//   //       print("changeRole: to broadCast");

//   //       return DetailsScreen(
//   //         role: ClientRole.Broadcaster,
//   //       );
//   //       // for (var map in roomUsersList) {
//   //       //   if (map.data().containsKey("micNumber")) {
//   //       //     if (map.data()["micNumber"] == "${index +1}") {
//   //       //       // your list of map contains key "id" which has value 3
//   //       //       CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
//   //       //       print("id: ${map.data()["userId"]}");
//   //       //       return;
//   //       //     }
//   //       //   }
//   //       // }
//   //       FirebaseFirestore.instance
//   //           .collection('roomUsers')
//   //           .doc(widget.roomId)
//   //           .collection(widget.roomId)
//   //           .add({
//   //         'micNumber': "${index + 1}",
//   //         'userId': PreferencesServices.getString(ID_KEY),
//   //         "userName": PreferencesServices.getString(Name_KEY)
//   //       }).then((value) {
//   //         setState(() {
//   //           // _isMicHold = true;
//   //           _roomUsersCount++;
//   //           _engine
//   //               .setClientRole(
//   //                 ClientRole.Broadcaster,
//   //               )
//   //               .then(
//   //                 (value) {},
//   //               );
//   //         });
//   //       });
//   //     });
//   //   },
//   //   itemCount: 10,
//   //   controller: listScrollController,
//   // );
//   // }
// }
}
