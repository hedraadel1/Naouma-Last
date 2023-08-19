/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

// // // import 'dart:async';
// // // import 'dart:ui';

// // // import 'package:agora_rtc_engine/rtc_engine.dart';
// // // import 'package:cloud_firestore/cloud_firestore.dart';
// // // import 'package:conditional_builder/conditional_builder.dart';
// // // import 'package:firebase_analytics/firebase_analytics.dart';
// // // import 'package:firebase_messaging/firebase_messaging.dart';
// // // import 'package:flutter/gestures.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:get/get.dart';

// // // import 'package:nb_utils/nb_utils.dart';
// // // import 'package:project/audiocall.dart';
// // // import 'package:project/common_functions.dart';
// // // import 'package:project/models/firebase_room_model.dart';
// // // import 'package:project/models/notification_model.dart';
// // // import 'package:project/models/roomUser.dart';
// // // import 'package:project/models/room_index.dart';
// // // import 'package:project/models/user_mic_model.dart';
// // // import 'package:project/utils/constants.dart';
// // // import 'package:project/utils/images.dart';
// // // import 'package:project/utils/preferences_services.dart';
// // // import 'package:project/view/details/users_Inroom.dart';
// // // import 'package:project/view/home/homeCubit.dart';
// // // import 'package:project/view/home/states.dart';

// // // import '../../gift_screen.dart';
// // // import '../../shop_background_gift.dart';
// // // import 'components/mic_click_dialog.dart';

// // import 'dart:async';

// // import 'package:agora_rtc_engine/rtc_engine.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:project/models/room_data_model.dart';
// // import 'package:project/models/room_user_model.dart';
// // import 'package:project/models/user_mic_model.dart';
// // import 'package:project/utils/common_functions.dart';
// // import 'package:project/utils/constants.dart';
// // import 'package:project/utils/images.dart';
// // import 'package:project/utils/preferences_services.dart';
// // import 'package:nb_utils/nb_utils.dart';
// // import 'package:project/view/home/homeCubit.dart';

// // import '../../common_functions.dart';
// // import 'components/mic_click_dialog.dart';

// // class DetailsScreen extends StatefulWidget {
// //   final String roomId;
// //   final String roomName;
// //   final String roomDesc;
// //   final String roomOwnerId;

// //   DetailsScreen(
// //       {Key key, this.roomId, this.roomName, this.roomDesc, this.roomOwnerId})
// //       : super(key: key);

// //   @override
// //   _DetailsScreenState createState() => _DetailsScreenState();
// // }

// // class _DetailsScreenState extends State<DetailsScreen> {
// //   TextEditingController _messageController = TextEditingController();

// // //  final controller = Get.put(DetailsController());

// //   static final _users = <int>[];
// //   final _infoStrings = <String>[];
// //   bool muted = false;
// //   RtcEngine _engine;
// //   bool _isSpeaking = false;

// //   bool get isSpeaking => _isSpeaking;
// //   bool _isLoadingMics = true;

// //   // for chat
// //   String peerAvatar;
// //   List<QueryDocumentSnapshot> listMessage = new List.from([]);
// //   List<QueryDocumentSnapshot> roomUsersList = new List.from([]);
// //   List<UserMicModel> _micUsersList = [];

// //   int limit = 20;
// //   int _roomUsersCount = 0;
// //   String groupChatId = "";
// //   String id;
// //   String roomID = "";

// //   bool isLoading = false;
// //   bool isShowSticker = false;
// //   String imageUrl = "";
// //   final ScrollController listScrollController = ScrollController();
// //   final FocusNode focusNode = FocusNode();
// //   final _firestoreInstance = FirebaseFirestore.instance;
// //   bool _isMicHold = false;
// //   bool _isRoomOnFirebase = false;

// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     readLocal();
// //     initialize();
// //     _addMicsToFirebase(roomID);
// //     //  _addMicsToFirebase();
// //     getRoomUsers();
// //     print("roomId: $roomID");
// //   }

// //   @override
// //   void dispose() {
// //     // TODO: implement dispose
// //     // _users.clear();
// //     // destroy sdk
// //     // HomeCubit.get(context).logoutUserRoom(id: roomID)
// //     // _engine.leaveChannel();
// //     // print("oncloseeeeee");
// //     // _engine.destroy();
// //     super.dispose();
// //   }

// //   Future<void> initialize() async {
// //     // check room found or not at first
// //     await checkRoomFoundOrNot();
// //     // initialize agora
// //     // await _initAgoraRtcEngine();
// //     // _addAgoraEventHandlers();
// //     // await _engine.joinChannel(
// //     //     "00645f4567598af4f32afca701cccd0cf2dIADRIb4LxYD/WX4B1uQnZIJqrURDf6xrB/V2mFU7a+SDTwnn9jMAAAAAEAD+bihbcUpCYQEAAQCfyEJh",
// //     //     // "naoumaRoom",
// //     //     "${widget.roomName}",
// //     //     null,
// //     //     0);
// //   }

// //   Future<void> _initAgoraRtcEngine() async {
// //     if (AppId.isEmpty) {
// //       setState(() {
// //         _infoStrings.add(
// //           'APP_ID missing, please provide your APP_ID in settings.dart',
// //         );
// //         _infoStrings.add('Agora Engine is not starting');
// //       });
// //       return;
// //     }
// //     _engine = await RtcEngine.create(AppId);
// //     await _engine.enableAudio();
// //     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
// //     // if (PreferencesServices.getString(ID_KEY) == widget.roomOwnerId) {
// //     //   await _engine.setClientRole(ClientRole.Broadcaster);
// //     // } else {
// //     //   await _engine.setClientRole(ClientRole.Audience);
// //     // }
// //   }

// //   void _addAgoraEventHandlers() {
// //     _engine.setEventHandler(RtcEngineEventHandler(
// //       error: (code) {
// //         setState(() {
// //           print('onError: $code');
// //         });
// //       },
// //       joinChannelSuccess: (channel, uid, elapsed) {
// //         print('onJoinChannel: $channel, uid: $uid');
// //         print("userJoinChannel");
// //         setState(() {
// //           _roomUsersCount++;
// //         });
// //       },
// //       leaveChannel: (stats) {
// //         setState(() {
// //           print('onLeaveChannel');
// //           // _users.clear();
// //           _roomUsersCount > 0 ? _roomUsersCount-- : null;
// //         });
// //       },
// //       userJoined: (uid, elapsed) {
// //         print('userJoined: $uid');
// //         setState(() {
// //           _users.add(uid);
// //           // _roomUsersCount++;
// //         });
// //       },
// //       audioVolumeIndication: (speakers, int volume) {
// //         print("isSpeak: ${speakers.any((speaker) => speaker.volume > 0)}");
// //         if (speakers.any((speaker) => speaker.volume > 0)) {
// //           setState(() {
// //             _isSpeaking = true;
// //           });
// //         } else {
// //           setState(() {
// //             _isSpeaking = false;
// //           });
// //         }
// //         // for(var speaker in speakers){
// //         //   for(var user in _users) {
// //         //     if (speaker.volume > 0 && speaker.uid == user) {
// //         //       // user is speaking now...
// //         //       // update user speaking ui
// //         //     }
// //         //   }
// //         // }
// //       },
// //     ));
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final theme = Theme.of(context);
// //     final size = MediaQuery.of(context).size;
// //     //controller.roomID = widget.roomData.id;
// //     return Directionality(
// //       textDirection: TextDirection.rtl,
// //       child: SafeArea(
// //           top: false,
// //           child: WillPopScope(
// //             onWillPop: _closeRoom,
// //             child: Scaffold(
// //               body: // GetBuilder<DetailsController>(
// //                   //     init: Get.find(),
// //                   // builder:(controller)=>
// //                   Container(
// //                 child: Stack(
// //                   children: [
// //                     Container(
// //                       decoration: BoxDecoration(
// //                         image: DecorationImage(
// //                             image: NetworkImage(
// //                                 'https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80'),
// //                             fit: BoxFit.cover),
// //                       ),
// //                     ),
// //                     Container(
// //                       padding: const EdgeInsets.symmetric(
// //                           vertical: 40.0, horizontal: 8.0),
// //                       child: Column(
// //                         children: [
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                             children: [
// //                               Container(
// //                                 width: size.width / 2 - 16,
// //                                 padding: const EdgeInsets.symmetric(
// //                                     vertical: 2.0, horizontal: 6.0),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.black26,
// //                                   borderRadius: BorderRadius.only(
// //                                       topLeft: Radius.circular(16.0),
// //                                       bottomLeft: Radius.circular(16.0)),
// //                                 ),
// //                                 child: Row(
// //                                   children: [
// //                                     SizedBox(
// //                                       width: 4.0,
// //                                     ),
// //                                     Expanded(
// //                                       child: Column(
// //                                         crossAxisAlignment:
// //                                             CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             widget.roomName,
// //                                             maxLines: 1,
// //                                             style: theme.textTheme.bodyText1
// //                                                 .copyWith(
// //                                                     color: Colors.white,
// //                                                     fontSize: 17),
// //                                           ),
// //                                           Text(
// //                                             "ID: 99",
// //                                             maxLines: 1,
// //                                             style: theme.textTheme.bodyText2
// //                                                 .copyWith(
// //                                                     color: Colors.white,
// //                                                     fontSize: 15),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                     Icon(
// //                                       Icons.favorite_border,
// //                                       color: Colors.white,
// //                                     ),
// //                                   ],
// //                                 ),
// //                               ),
// //                               Row(
// //                                 children: [
// //                                   IconButton(
// //                                       icon: Icon(Icons.ios_share,
// //                                           color: Colors.white),
// //                                       onPressed: () {
// //                                         print("share btn clicked");
// //                                       }),
// //                                   GestureDetector(
// //                                       child: Icon(Icons.close,
// //                                           color: Colors.white),
// //                                       onTap: () {
// //                                         _closeRoom();
// //                                       })
// //                                 ],
// //                               )
// //                             ],
// //                           ),
// //                           16.height,
// //                           Container(
// //                             child: Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Container(
// //                                   width: 150,
// //                                   padding: const EdgeInsets.symmetric(
// //                                       vertical: 2.0, horizontal: 6.0),
// //                                   decoration: BoxDecoration(
// //                                     color: Colors.black26,
// //                                     borderRadius: BorderRadius.only(
// //                                         topLeft: Radius.circular(16.0),
// //                                         bottomLeft: Radius.circular(16.0)),
// //                                   ),
// //                                   child: Row(
// //                                     children: [
// //                                       Icon(Icons.monetization_on_rounded,
// //                                           color: Colors.orange),
// //                                       SizedBox(
// //                                         width: 6.0,
// //                                       ),
// //                                       Expanded(
// //                                         child: Text(
// //                                           widget.roomName,
// //                                           maxLines: 1,
// //                                           style: theme.textTheme.bodyText1
// //                                               .copyWith(
// //                                                   color: Colors.white,
// //                                                   fontSize: 17),
// //                                         ),
// //                                       ),
// //                                       Icon(
// //                                         Icons.arrow_back_ios_rounded,
// //                                         color: Colors.grey,
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                                 Row(
// //                                   children: [
// //                                     Image.asset(
// //                                       kDefaultProfileImage,
// //                                       width: 36,
// //                                       height: 36,
// //                                     ),
// //                                     16.width,
// //                                     Text(
// //                                       "$_roomUsersCount",
// //                                       style: theme.textTheme.bodyText1.copyWith(
// //                                           color: Colors.white, fontSize: 18),
// //                                     ),
// //                                     Icon(Icons.person_outline,
// //                                         color: Colors.white),
// //                                   ],
// //                                 )
// //                               ],
// //                             ),
// //                           ),
// //                           16.height,
// //                           // Wrap(
// //                           //   spacing: 16.0,
// //                           //   runSpacing: 16.0,
// //                           //   children: [
// //                           //     _personInRoom(1, "1"),
// //                           //     _personInRoom(2, "2"),
// //                           //     _personInRoom(3, "3"),
// //                           //     _personInRoom(4, "4"),
// //                           //     _personInRoom(5, "5"),
// //                           //   ],
// //                           // ),
// //                           Container(
// //                             padding: const EdgeInsets.all(6.0),
// //                             child: Stack(
// //                               // fit: StackFit.expand,
// //                               // overflow: Overflow.visible,
// //                               children: [
// //                                 Container(
// //                                   width: double.infinity,
// //                                   // margin: const EdgeInsets.only(top:10, right: 60),
// //                                   child: _roomMicsLayout(),
// //                                 ),
// //                                 // Positioned(
// //                                 //   top: 0,
// //                                 //   right: 0,
// //                                 //   child: _isMicHold?Container(): Container(
// //                                 //   // width: 68,
// //                                 //   // height: 68,
// //                                 //     padding: const EdgeInsets.all(6.0),
// //                                 //   decoration: BoxDecoration(
// //                                 //     shape: BoxShape.circle,
// //                                 //     color: Colors.white,
// //                                 //     border: Border.all(color: kPrimaryColor.withOpacity(0.4), width: 2.0),
// //                                 //   ),
// //                                 //   child: Column(
// //                                 //     mainAxisAlignment: MainAxisAlignment.center,
// //                                 //     children: [
// //                                 //       Icon(Icons.mic,color: kPrimaryColor, size: 28,),
// //                                 //       Text("طلب مايك", style: secondaryTextStyle(color: kPrimaryColor, size: 12),)
// //                                 //     ],
// //                                 //   ),
// //                                 // ).onTap(() {
// //                                 //
// //                                 // }),),
// //                               ],
// //                             ),
// //                           ),
// //                           16.height,
// //                           Container(
// //                             width: double.infinity,
// //                             padding: const EdgeInsets.symmetric(
// //                                 vertical: 4.0, horizontal: 8.0),
// //                             decoration: BoxDecoration(
// //                               color: Colors.black54,
// //                             ),
// //                             child: Marquee(
// //                               child: Text(
// //                                 'Some sample text that takes some space, Some sample text that takes some space. ',
// //                                 style: theme.textTheme.bodyText1
// //                                     .copyWith(color: Colors.white),
// //                               ),
// //                               direction: Axis.horizontal,
// //                               textDirection: TextDirection.rtl,
// //                               pauseDuration: Duration(seconds: 2),
// //                               backDuration: Duration(seconds: 2),
// //                               animationDuration: Duration(seconds: 6),
// //                               directionMarguee: DirectionMarguee.oneDirection,
// //                             ),
// //                           ),
// //                           buildListMessage(size),
// //                         ],
// //                       ),
// //                     ),
// //                     Positioned(
// //                       bottom: 10,
// //                       left: 10,
// //                       right: 10,
// //                       child: Row(
// //                         children: [
// //                           Container(
// //                             padding: const EdgeInsets.all(6.0),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: Colors.black45,
// //                             ),
// //                             child: Icon(
// //                               Icons.mic_external_on,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                           8.width,
// //                           Expanded(
// //                             child: Container(
// //                               padding: const EdgeInsets.symmetric(
// //                                   horizontal: 6, vertical: 2.0),
// //                               decoration: BoxDecoration(
// //                                 color: Colors.black26,
// //                                 borderRadius:
// //                                     BorderRadius.all(Radius.circular(16.0)),
// //                               ),
// //                               child: TextField(
// //                                 keyboardType: TextInputType.text,
// //                                 controller: _messageController,
// //                                 style: TextStyle(color: Colors.white),
// //                                 decoration: InputDecoration.collapsed(
// //                                   hintText: "رسالتك...",
// //                                   hintStyle: TextStyle(color: Colors.white),
// //                                 ),
// //                               ),
// //                             ),
// //                           ),
// //                           8.width,
// //                           Container(
// //                             padding: const EdgeInsets.all(5.0),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: Colors.orange,
// //                             ),
// //                             child: Icon(
// //                               Icons.send,
// //                               color: Colors.white,
// //                             ),
// //                           ).onTap(() {
// //                             onSendMessage(_messageController.text, 0);
// //                           }),
// //                           8.width,
// //                           Container(
// //                             padding: const EdgeInsets.all(6.0),
// //                             decoration: BoxDecoration(
// //                               shape: BoxShape.circle,
// //                               color: Colors.black45,
// //                             ),
// //                             child: Icon(
// //                               Icons.mic_external_on,
// //                               color: Colors.white,
// //                             ),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           )),
// //     );
// //   }

// //   checkRoomFoundOrNot() async {
// //     DocumentSnapshot ds =
// //         await _firestoreInstance.collection("roomUsers").doc(roomID).get();
// //     this.setState(() {
// //       _isRoomOnFirebase = ds.exists;
// //       print("_isRoomOnFirebase: $_isRoomOnFirebase");
// //     });
// //     // if room not exist add it to firebase
// //     _isRoomOnFirebase ? null : _addMicsToFirebase(roomID);
// //   }

// //   Widget _personInRoom(int index, UserMicModel micModel) {
// //     print("$index");
// //     print("${micModel.userName}");
// //     return Expanded(
// //       child: Container(
// //         child: Column(
// //           children: [
// //             Container(
// //               padding: const EdgeInsets.all(6.0),
// //               decoration: BoxDecoration(
// //                   color: Colors.grey,
// //                   shape: BoxShape.circle,
// //                   border: Border.all(width: 2, color: kPrimaryColor)),
// //               child: Icon(
// //                 micModel.isLocked != null
// //                     ? micModel.isLocked
// //                         ? Icons.lock
// //                         : Icons.mic
// //                     : Icons.mic,
// //                 color: Colors.white,
// //                 size: 26,
// //               ),
// //             ),
// //             2.height,
// //             Text(
// //               micModel.isLocked != null && micModel.isLocked
// //                   ? "مقفل"
// //                   : micModel.micStatus
// //                       ? micModel.userName.length > 7
// //                           ? ".${micModel.userName}"
// //                           : "${micModel.userName}"
// //                       : "${index + 1}",
// //               overflow: TextOverflow.ellipsis,
// //               style: secondaryTextStyle(size: 12, color: black),
// //             ),
// //           ],
// //         ),
// //       ).onTap(() {
// //         if (micModel.micStatus==false &&
// //             micModel.isLocked==false &&
// //             micModel.userId == null &&
// //             micModel.roomOwnerId == null) {
// //           // Iam room owner and mic is empty
// //           print("Iam owner and mic is empty.");
// //           var existingItem = _micUsersList.firstWhere(
// //               (itemToCheck) =>
// //                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// //               orElse: () => null);
// //           if (existingItem == null) {
// //             // user already holds mic before
// //             print(existingItem.micNumber);
// //             print(existingItem.userName);
// //             print("take other mic");
// //             showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return MicClickDialog(
// //                     takeMicFunction: () {
// //                       print("clicked take");
// //                       print("clicked index: $index");
// //                       // leave old mic
// //                       existingItem.id = null;
// //                       existingItem.userName = null;
// //                       existingItem.userId = null;
// //                       existingItem.micNumber = existingItem.micNumber;
// //                       existingItem.micStatus = false;
// //                       _updateMicsToFirebase(
// //                           existingItem.micNumber, existingItem);
// //                       print("existname: ${existingItem.userName}");
// //                       print("existuserId: ${existingItem.userId}");
// //                       print("existmicNumber: ${existingItem.micNumber}");
// //                       print("existid: ${existingItem.micNumber}");
// //                       print("existmicStatus: ${existingItem.micStatus}");

// //                       // go to new mic
// //                       micModel.id = index.toString();
// //                       micModel.userName =
// //                           PreferencesServices.getString(Name_KEY);
// //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = true;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       finish(context);
// //                       _updateMicsToFirebase(index, micModel);
// //                     },
// //                     leaveMicFunction: () {},
// //                     lockMicFunction: () {
// //                       // lock mic
// //                       micModel.id = null;
// //                       micModel.userName = null;
// //                       micModel.userId = null;
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = false;
// //                       micModel.isLocked = true;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     unLockMicFunction: () {},
// //                     showTakeMic: true,
// //                     showLeaveMic: false,
// //                     showLockMic: true,
// //                     micIsLocked: false,
// //                   );
// //                 });
// //           } else {
// //             print("not take other mic");
// //             showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return MicClickDialog(
// //                     takeMicFunction: () {
// //                       // go to new mic
// //                       micModel.id = index.toString();
// //                       micModel.userName =
// //                           PreferencesServices.getString(Name_KEY);
// //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = true;
// //                       micModel.isLocked = false;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     leaveMicFunction: () {},
// //                     lockMicFunction: () {
// //                       // lock mic
// //                       micModel.id = null;
// //                       micModel.userName = null;
// //                       micModel.userId = null;
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = false;
// //                       micModel.isLocked = true;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     unLockMicFunction: () {},
// //                     showTakeMic: true,
// //                     showLeaveMic: false,
// //                     showLockMic: true,
// //                     micIsLocked: false,
// //                   );
// //                 });
// //           }
// //         } else if (!micModel.micStatus &&
// //             micModel.isLocked &&
// //             micModel.userId == null &&
// //             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
// //           // Iam room owner and mic is locked
// //           print("Iam room owner and mic is locked...");
// //           showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return MicClickDialog(
// //                   takeMicFunction: () {},
// //                   leaveMicFunction: () {},
// //                   unLockMicFunction: () {
// //                     print("unLock Mic index: $index");
// //                     micModel.id = null;
// //                     micModel.userName = null;
// //                     micModel.userId = null;
// //                     micModel.micNumber = index;
// //                     micModel.micStatus = false;
// //                     micModel.isLocked = false;
// //                     print("name: ${micModel.userName}");
// //                     print("userId: ${micModel.userId}");
// //                     print("micNumber: ${micModel.micNumber}");
// //                     print("id: ${micModel.micNumber}");
// //                     print("micStatus: ${micModel.micStatus}");
// //                     _updateMicsToFirebase(index, micModel);
// //                     finish(context);
// //                   },
// //                   showTakeMic: false,
// //                   showLeaveMic: false,
// //                   showLockMic: false,
// //                   micIsLocked: true,
// //                 );
// //               });
// //         } else if (micModel.micStatus &&
// //             !micModel.isLocked &&
// //             micModel.userId == PreferencesServices.getString(ID_KEY) &&
// //             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
// //           // Iam room owner and mic is locked
// //           print("Iam room owner and mic is taken by me...");
// //           showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return MicClickDialog(
// //                   takeMicFunction: () {},
// //                   leaveMicFunction: () {
// //                     print("unLock Mic index: $index");
// //                     micModel.id = null;
// //                     micModel.userName = null;
// //                     micModel.userId = null;
// //                     micModel.micNumber = index;
// //                     micModel.micStatus = false;
// //                     micModel.isLocked = false;
// //                     print("name: ${micModel.userName}");
// //                     print("userId: ${micModel.userId}");
// //                     print("micNumber: ${micModel.micNumber}");
// //                     print("id: ${micModel.micNumber}");
// //                     print("micStatus: ${micModel.micStatus}");
// //                     _updateMicsToFirebase(index, micModel);
// //                     finish(context);
// //                   },
// //                   unLockMicFunction: () {},
// //                   showTakeMic: false,
// //                   showLeaveMic: true,
// //                   showLockMic: false,
// //                   micIsLocked: false,
// //                 );
// //               });
// //         } else if (!micModel.micStatus &&
// //             !micModel.isLocked &&
// //             micModel.userId == null &&
// //             micModel.roomOwnerId != PreferencesServices.getString(ID_KEY)) {
// //           // Iam not room owner and mic is locked
// //           print("Iam not room owner and mic is taken by me...");
// //           var existingItem = _micUsersList.firstWhere(
// //               (itemToCheck) =>
// //                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// //               orElse: () => null);
// //           if (existingItem != null) {
// //             // user already holds mic before
// //             print(existingItem.micNumber);
// //             print(existingItem.userName);
// //             print("take other mic");
// //             showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return MicClickDialog(
// //                     takeMicFunction: () {
// //                       print("clicked take");
// //                       print("clicked index: $index");
// //                       // leave old mic
// //                       existingItem.id = null;
// //                       existingItem.userName = null;
// //                       existingItem.userId = null;
// //                       existingItem.micNumber = existingItem.micNumber;
// //                       existingItem.micStatus = false;
// //                       _updateMicsToFirebase(
// //                           existingItem.micNumber, existingItem);
// //                       print("existname: ${existingItem.userName}");
// //                       print("existuserId: ${existingItem.userId}");
// //                       print("existmicNumber: ${existingItem.micNumber}");
// //                       print("existid: ${existingItem.micNumber}");
// //                       print("existmicStatus: ${existingItem.micStatus}");

// //                       // go to new mic
// //                       micModel.id = index.toString();
// //                       micModel.userName =
// //                           PreferencesServices.getString(Name_KEY);
// //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = true;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       // update firebase
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     leaveMicFunction: () {
// //                       print("leave index: $index");
// //                       micModel.id = null;
// //                       micModel.userName = null;
// //                       micModel.userId = null;
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = false;
// //                       micModel.isLocked = false;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       // update firebase
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     lockMicFunction: () {},
// //                     unLockMicFunction: () {},
// //                     showTakeMic: true,
// //                     showLeaveMic: true,
// //                     showLockMic: false,
// //                     micIsLocked: false,
// //                   );
// //                 });
// //           } else {
// //             print("not take other mic");
// //             showDialog(
// //                 context: context,
// //                 builder: (BuildContext context) {
// //                   return MicClickDialog(
// //                     takeMicFunction: () {
// //                       // go to new mic
// //                       micModel.id = index.toString();
// //                       micModel.userName =
// //                           PreferencesServices.getString(Name_KEY);
// //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// //                       micModel.micNumber = index;
// //                       micModel.micStatus = true;
// //                       micModel.isLocked = false;
// //                       print("name: ${micModel.userName}");
// //                       print("userId: ${micModel.userId}");
// //                       print("micNumber: ${micModel.micNumber}");
// //                       print("id: ${micModel.micNumber}");
// //                       print("micStatus: ${micModel.micStatus}");
// //                       _updateMicsToFirebase(index, micModel);
// //                       finish(context);
// //                     },
// //                     leaveMicFunction: () {
// //                       finish(context);
// //                     },
// //                     lockMicFunction: () {},
// //                     unLockMicFunction: () {},
// //                     showTakeMic: true,
// //                     showLeaveMic: true,
// //                     showLockMic: false,
// //                     micIsLocked: false,
// //                   );
// //                 });
// //           }
// //         } else if (micModel.micStatus &&
// //             !micModel.isLocked &&
// //             micModel.userId != null &&
// //             micModel.userId == PreferencesServices.getString(ID_KEY)) {
// //           // mic taken by me...
// //           print("mic taken by me...");
// //           showDialog(
// //               context: context,
// //               builder: (BuildContext context) {
// //                 return MicClickDialog(
// //                   takeMicFunction: () {},
// //                   leaveMicFunction: () {
// //                     print("leave index: $index");
// //                     micModel.id = null;
// //                     micModel.userName = null;
// //                     micModel.userId = null;
// //                     micModel.micNumber = index;
// //                     micModel.micStatus = false;
// //                     print("name: ${micModel.userName}");
// //                     print("userId: ${micModel.userId}");
// //                     print("micNumber: ${micModel.micNumber}");
// //                     print("id: ${micModel.micNumber}");
// //                     print("micStatus: ${micModel.micStatus}");
// //                     finish(context);
// //                     _updateMicsToFirebase(index, micModel);
// //                   },
// //                   lockMicFunction: () {},
// //                   unLockMicFunction: () {},
// //                   showLockMic: false,
// //                   micIsLocked: false,
// //                   showTakeMic: false,
// //                   showLeaveMic: true,
// //                 );
// //               });
// //         } else if (micModel.micStatus &&
// //             !micModel.isLocked &&
// //             micModel.userId != null &&
// //             micModel.userId != PreferencesServices.getString(ID_KEY)) {
// //           // taken by other one
// //           CommonFunctions.showToast("Mic already taken", Colors.red);
// //         } else if (!micModel.micStatus &&
// //             micModel.isLocked &&
// //             micModel.userId != null &&
// //             micModel.userId != PreferencesServices.getString(ID_KEY)) {
// //           // Mic is locked
// //           CommonFunctions.showToast("Mic is locked", Colors.red);
// //         }
// //         // else{
// //         //   print("_micUsersList: ${_micUsersList.length}");
// //         //   //find existing item per link criteria
// //         //           var existingItem = _micUsersList.firstWhere((itemToCheck) => itemToCheck.userId == PreferencesServices.getString(ID_KEY), orElse: () => null);
// //         //           if(existingItem != null){
// //         //             // user already holds mic before
// //         //             print(existingItem.micNumber);
// //         //             print(existingItem.userName);
// //         //             print("take other mic");
// //         //             showDialog(context: context,
// //         //                 builder: (BuildContext context){
// //         //                   return MicClickDialog(takeMicFunction: (){
// //         //                     print("clicked take");
// //         //                     print("clicked index: $index");
// //         //                     // leave old mic
// //         //                     existingItem.id = null;
// //         //                     existingItem.userName = null;
// //         //                     existingItem.userId = null;
// //         //                     existingItem.micNumber = existingItem.micNumber;
// //         //                     existingItem.micStatus = false;
// //         //                     _updateMicsToFirebase(existingItem.micNumber, existingItem);
// //         //                     print("existname: ${existingItem.userName}");
// //         //                     print("existuserId: ${existingItem.userId}");
// //         //                     print("existmicNumber: ${existingItem.micNumber}");
// //         //                     print("existid: ${existingItem.micNumber}");
// //         //                     print("existmicStatus: ${existingItem.micStatus}");
// //         //
// //         //                     // go to new mic
// //         //                     micModel.id = index.toString();
// //         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
// //         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
// //         //                     micModel.micNumber = index;
// //         //                     micModel.micStatus = true;
// //         //                     print("name: ${micModel.userName}");
// //         //                     print("userId: ${micModel.userId}");
// //         //                     print("micNumber: ${micModel.micNumber}");
// //         //                     print("id: ${micModel.micNumber}");
// //         //                     print("micStatus: ${micModel.micStatus}");
// //         //                     finish(context);
// //         //                     _updateMicsToFirebase(index, micModel);
// //         //                   }, leaveMicFunction: (){
// //         //                     print("leave index: $index");
// //         //                     finish(context);
// //         //                   });
// //         //                 }
// //         //             );
// //         //           } else{
// //         //             print("not take other mic");
// //         //             showDialog(context: context,
// //         //                 builder: (BuildContext context){
// //         //                   return MicClickDialog(takeMicFunction: (){
// //         //                     print("clicked take");
// //         //                     print("clicked index: $index");
// //         //                     micModel.id = "$index";
// //         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
// //         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
// //         //                     micModel.micNumber = index;
// //         //                     micModel.micStatus = true;
// //         //                     print("name: ${micModel.userName}");
// //         //                     print("userId: ${micModel.userId}");
// //         //                     print("micNumber: ${micModel.micNumber}");
// //         //                     print("id: ${micModel.micNumber}");
// //         //                     print("micStatus: ${micModel.micStatus}");
// //         //                     finish(context);
// //         //                     _updateMicsToFirebase(index, micModel);
// //         //
// //         //                   }, leaveMicFunction: (){
// //         //                     print("leave index: $index");
// //         //                     finish(context);
// //         //                   });
// //         //                 }
// //         //             );
// //         //           }
// //         // }
// //       }),
// //     );
// //   }

// //   void onSendMessage(String content, int type) {
// //     // type: 0 = text, 1 = image, 2 = sticker
// //     if (content.trim() != '') {
// //       _messageController.clear();

// //       var documentReference = FirebaseFirestore.instance
// //           .collection('messages')
// //           .doc(groupChatId)
// //           .collection(groupChatId)
// //           .doc(DateTime.now().millisecondsSinceEpoch.toString());

// //       FirebaseFirestore.instance.runTransaction((transaction) async {
// //         transaction.set(
// //           documentReference,
// //           {
// //             'idFrom': id,
// //             'idTo': widget.roomId,
// //             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
// //             'content': content,
// //             'type': type
// //           },
// //         );
// //       });
// //       listScrollController.animateTo(0.0,
// //           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
// //     } else {
// //       CommonFunctions.showToast('Nothing to send', Colors.red);
// //     }
// //   }

// //   void onFocusChange() {
// //     if (focusNode.hasFocus) {
// //       // Hide sticker when keyboard appear
// //       setState(() {
// //         isShowSticker = false;
// //       });
// //     }
// //   }

// //   readLocal() async {
// //     id = PreferencesServices.getString(ID_KEY);
// //     if (id.hashCode <= widget.roomId.hashCode) {
// //       setState(() {
// //         groupChatId = '${widget.roomId}';
// //         roomID = widget.roomId;
// //       });
// //     } else {
// //       setState(() {
// //         groupChatId = '${widget.roomId}';
// //         roomID = widget.roomId;
// //       });
// //     }
// //   }

// //   Widget buildListMessage(Size size) {
// //     return Flexible(
// //       child: groupChatId.isNotEmpty
// //           ? StreamBuilder<QuerySnapshot>(
// //               stream: FirebaseFirestore.instance
// //                   .collection('messages')
// //                   .doc(groupChatId)
// //                   .collection(groupChatId)
// //                   .orderBy('timestamp', descending: true)
// //                   .limit(limit)
// //                   .snapshots(),
// //               builder: (BuildContext context,
// //                   AsyncSnapshot<QuerySnapshot> snapshot) {
// //                 print("messaegs: ${snapshot.toString()}");
// //                 if (snapshot.hasData) {
// //                   listMessage.addAll(snapshot.data.docs);
// //                   return ListView.builder(
// //                     padding: EdgeInsets.all(10.0),
// //                     itemBuilder: (context, index) =>
// //                         buildItem(index, snapshot.data?.docs[index], size),
// //                     itemCount: snapshot.data?.docs.length,
// //                     reverse: true,
// //                     controller: listScrollController,
// //                   );
// //                 } else {
// //                   return Center(
// //                     child: CircularProgressIndicator(
// //                       valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
// //                     ),
// //                   );
// //                 }
// //               },
// //             )
// //           : Center(
// //               child: CircularProgressIndicator(
// //                 valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
// //               ),
// //             ),
// //     );
// //   }

// //   Widget buildItem(int index, DocumentSnapshot document, Size size) {
// //     if (document != null) {
// //       // Right (my message)
// //       return document.get('type') == 0
// //           // Text
// //           ? Container(
// //               width: size.width * 0.7,
// //               padding: const EdgeInsets.all(6.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.start,
// //                 children: [
// //                   Container(
// //                     width: 36,
// //                     height: 36,
// //                     child: ClipRRect(
// //                       borderRadius: BorderRadius.all(Radius.circular(16.0)),
// //                       child: Image.asset(
// //                         kDefaultProfileImage,
// //                         width: 36,
// //                         height: 36,
// //                       ),
// //                     ),
// //                   ),
// //                   10.width,
// //                   Expanded(
// //                     child: Container(
// //                       child: Text(
// //                         document.get('content'),
// //                         style: secondaryTextStyle(color: Colors.white),
// //                         maxLines: 2,
// //                         textAlign: TextAlign.start,
// //                         overflow: TextOverflow.ellipsis,
// //                       ),
// //                       // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
// //                       color: Colors.transparent,
// //                       // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
// //                       // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             )
// //           : document.get('type') == 1
// //               // Image
// //               ? Container(
// //                   child: OutlinedButton(
// //                     child: Material(
// //                       child: Image.network(
// //                         document.get("content"),
// //                         loadingBuilder: (BuildContext context, Widget child,
// //                             ImageChunkEvent loadingProgress) {
// //                           if (loadingProgress == null) return child;
// //                           return Container(
// //                             decoration: BoxDecoration(
// //                               color: Colors.grey.shade600,
// //                               borderRadius: BorderRadius.all(
// //                                 Radius.circular(8.0),
// //                               ),
// //                             ),
// //                             width: 200.0,
// //                             height: 200.0,
// //                             child: Center(
// //                               child: CircularProgressIndicator(
// //                                 value: loadingProgress.expectedTotalBytes !=
// //                                             null &&
// //                                         loadingProgress.expectedTotalBytes !=
// //                                             null
// //                                     ? loadingProgress.cumulativeBytesLoaded /
// //                                         loadingProgress.expectedTotalBytes
// //                                     : null,
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                         errorBuilder: (context, object, stackTrace) {
// //                           return Material(
// //                             child: Image.asset(
// //                               'images/img_not_available.jpeg',
// //                               width: 200.0,
// //                               height: 200.0,
// //                               fit: BoxFit.cover,
// //                             ),
// //                             borderRadius: BorderRadius.all(
// //                               Radius.circular(8.0),
// //                             ),
// //                             clipBehavior: Clip.hardEdge,
// //                           );
// //                         },
// //                         width: 200.0,
// //                         height: 200.0,
// //                         fit: BoxFit.cover,
// //                       ),
// //                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
// //                       clipBehavior: Clip.hardEdge,
// //                     ),
// //                     onPressed: () {},
// //                     style: ButtonStyle(
// //                         padding: MaterialStateProperty.all<EdgeInsets>(
// //                             EdgeInsets.all(0))),
// //                   ),
// //                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// //                 )
// //               // Sticker
// //               : Container(
// //                   child: Image.asset(
// //                     'images/${document.get('content')}.gif',
// //                     width: 100.0,
// //                     height: 100.0,
// //                     fit: BoxFit.cover,
// //                   ),
// //                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// //                 );
// //     } else {
// //       return SizedBox.shrink();
// //     }
// //   }

// //   Future getRoomUsers() async {
// //     _isLoadingMics = true;
// //     var collection = FirebaseFirestore.instance.collection('roomUsers');
// //     var docSnapshot = await collection.doc(roomID).collection(roomID).get();
// //     // Map<String, dynamic> data = docSnapshot.docs;
// //     // QuerySnapshot querySnapshot = await _firestoreInstance.collection('roomUsers').doc(roomID).get().;
// //     // // // Get data from docs and convert map to List
// //     if (collection != null && docSnapshot != null) {
// //       // docSnapshot.docs.length > 0 ? _addMicsToFirebase() : null;
// //       roomUsersList = docSnapshot.docs;
// //       setState(() {
// //         _isLoadingMics = false;
// //       });
// //     }
// //     // // roomUsersList = querySnapshot.docs.map((doc) => doc.data()).toList();
// //     // setState(() {
// //     //   _usersCount = roomUsersList.length;
// //     // });
// //     // print(roomUsersList.toString());
// //     // print("userslst: ${roomUsersList.length}");
// //     // roomUsersList.forEach((querySnapshot) {
// //     //   Map<String, dynamic> jsonData = querySnapshot.data();
// //     //   UserMicModel userMicModel = UserMicModel.fromJson(jsonData);
// //     //   print(userMicModel.userId);
// //     //   print("users: ${userMicModel.userName}");
// //     //   print("users: ${querySnapshot.data()['userName']}");
// //     // });
// //     // _firestore.collection('favorites').where('user_id', isEqualTo: uid).getDocuments()
// //     //     .then((querySnap) {
// //     //   querySnap.documents.forEach((document) {
// //     //     print(document.data);
// //     //
// //     //     Map<String, dynamic> json = document.data; //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
// //     //     Album album = new Album.fromJson(json['favorite_albums'][0]); //Throws the type exception
// //     //   });
// //     // })
// //     //     .catchError((error) {
// //     //   print(error);
// //     // });
// //   }

// //   Widget _roomMicsLayout() {
// //     Stream<List<UserMicModel>> _stream = _firestoreInstance
// //         .collection('roomUsers')
// //         .doc(widget.roomId)
// //         .collection(widget.roomId)
// //         .snapshots()
// //         .transform(transformer((json) => UserMicModel.fromJson(json)));
// //     return StreamBuilder<List<UserMicModel>>(
// //         stream: _stream,
// //         builder:
// //             (BuildContext context, AsyncSnapshot<List<UserMicModel>> snapshot) {
// //           if (snapshot.hasData && snapshot.data.length > 0) {
// //             print(":has data");
// //             _micUsersList = snapshot.data;
// //             return Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3.0),
// //               child: Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: List.generate(5, (index) {
// //                   // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
// //                   return _personInRoom(
// //                     index,
// //                     snapshot.data[index],
// //                   );
// //                 }).toList(),
// //                 // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
// //               ),
// //               // child: Container(
// //               //   height: 100,
// //               //   child: ListView.builder(
// //               //       scrollDirection: Axis.horizontal,
// //               //       // shrinkWrap: true,
// //               //       itemCount: 5,
// //               //       itemBuilder: (BuildContext context, int index){
// //               //     return _personInRoom(index, snapshot.data[index],);
// //               //   }),
// //               // ),
// //             );
// //           } else {
// //             print("not has data");
// //             List<UserMicModel> _micsList = [];

// //             _micsList.add(UserMicModel(
// //                 id: null,
// //                 userId: null,
// //                 userName: null,
// //                 micNumber: 0,
// //                 micStatus: false,
// //                 isLocked: false));
// //             _micsList.add(UserMicModel(
// //                 id: null,
// //                 userId: null,
// //                 userName: null,
// //                 micNumber: 1,
// //                 micStatus: false,
// //                 isLocked: false));
// //             _micsList.add(UserMicModel(
// //                 id: null,
// //                 userId: null,
// //                 userName: null,
// //                 micNumber: 2,
// //                 micStatus: false,
// //                 isLocked: false));
// //             _micsList.add(UserMicModel(
// //                 id: null,
// //                 userId: null,
// //                 userName: null,
// //                 micNumber: 3,
// //                 micStatus: false,
// //                 isLocked: false));
// //             _micsList.add(UserMicModel(
// //                 id: null,
// //                 userId: null,
// //                 userName: null,
// //                 micNumber: 4,
// //                 micStatus: false,
// //                 isLocked: false));
// //             return Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 12.0),
// //               child: Row(
// //                 children: [
// //                   _personInRoom(
// //                     0,
// //                     _micsList[0],
// //                   ),
// //                   _personInRoom(
// //                     1,
// //                     _micsList[1],
// //                   ),
// //                   _personInRoom(
// //                     2,
// //                     _micsList[2],
// //                   ),
// //                   _personInRoom(
// //                     3,
// //                     _micsList[3],
// //                   ),
// //                   _personInRoom(
// //                     4,
// //                     _micsList[4],
// //                   ),
// //                 ],
// //               ),
// //             );
// //           }
// //           return ListView.builder(
// //             shrinkWrap: true,
// //             scrollDirection: Axis.horizontal,
// //             physics: NeverScrollableScrollPhysics(),
// //             padding: EdgeInsets.all(5.0),
// //             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
// //             itemBuilder: (context, index) {
// //               bool _isThisMic;
// //               for (var map in roomUsersList) {
// //                 _micUsersList.add(UserMicModel.fromJson(map));
// //                 // if (roomUsersList[index].data().containsKey("micNumber")) {
// //                 //     if (roomUsersList[index].data()["micNumber"] == "${index +1}") {
// //                 //       // your list of map contains key "id" which has value 3
// //                 //       // CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
// //                 //       // print("id: ${map.data()["userId"]}");
// //                 //       setState(() {
// //                 //         _isThisMic = true;
// //                 //       });
// //                 //     }
// //                 //   }
// //               }
// //               return Container(
// //                 child: Column(
// //                   children: [
// //                     Container(
// //                       padding: const EdgeInsets.all(6.0),
// //                       decoration: BoxDecoration(
// //                           color: Colors.grey,
// //                           shape: BoxShape.circle,
// //                           border: Border.all(width: 1, color: kPrimaryColor)),
// //                       child: Icon(
// //                         Icons.mic,
// //                         color: Colors.white,
// //                         size: 28,
// //                       ),
// //                     ),
// //                     2.height,
// //                     Text(
// //                       roomUsersList[index].data() != null
// //                           ? "${roomUsersList[index].data()["userName"]}"
// //                           : "${index + 1}",
// //                       style: secondaryTextStyle(color: Colors.white, size: 16),
// //                     ),
// //                   ],
// //                 ),
// //               ).onTap(() {
// //                 print("changeRole: to broadCast");
// //                 // for (var map in roomUsersList) {
// //                 //   if (map.data().containsKey("micNumber")) {
// //                 //     if (map.data()["micNumber"] == "${index +1}") {
// //                 //       // your list of map contains key "id" which has value 3
// //                 //       CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
// //                 //       print("id: ${map.data()["userId"]}");
// //                 //       return;
// //                 //     }
// //                 //   }
// //                 // }
// //                 _firestoreInstance
// //                     .collection('roomUsers')
// //                     .doc(roomID)
// //                     .collection(roomID)
// //                     .add({
// //                   'micNumber': "${index + 1}",
// //                   'userId': PreferencesServices.getString(ID_KEY),
// //                   "userName": PreferencesServices.getString(Name_KEY)
// //                 }).then((value) {
// //                   setState(() {
// //                     // _isMicHold = true;
// //                     _roomUsersCount++;
// //                     _engine
// //                         .setClientRole(
// //                           ClientRole.Broadcaster,
// //                         )
// //                         .then(
// //                           (value) {},
// //                         );
// //                   });
// //                 });
// //               });
// //             },
// //             itemCount: 5,
// //             controller: listScrollController,
// //           );
// //         });
// //   }

// //   void _updateMicsToFirebase(int index, UserMicModel micModel) async {
// //     print("inUpdate doc: $index");
// //     print("name: ${micModel.userName}");
// //     print("id: ${micModel.userId}");
// //     CollectionReference _collectionRef = FirebaseFirestore.instance
// //         .collection('roomUsers')
// //         .doc(roomID)
// //         .collection(roomID);
// //     await _collectionRef.doc("$index").update({
// //       "id": micModel.id,
// //       "userId": userid,
// //       "userName": username,
// //       "micNumber": micModel.micNumber,
// //       "micStatus": micModel.micStatus,
// //       "isLocked": 'false'
// //     }).catchError((e) {
// //       print(e);
// //       return;
// //     });
// //     // setState(() {
// //     //   micModel.micStatus
// //     //       ? _engine
// //     //           .setClientRole(
// //     //           ClientRole.Broadcaster,
// //     //         )
// //     //           .then(
// //     //           (value) {
// //     //             print("Broadcaster user");
// //     //           },
// //     //         )
// //     //       : _engine
// //     //           .setClientRole(
// //     //           ClientRole.Audience,
// //     //         )
// //     //           .then(
// //     //           (value) {
// //     //             print("Audience user");
// //     //           },
// //     //         );
// //     // });
// //   }

// //   static StreamTransformer transformer<T>(
// //           T Function(Map<String, dynamic> json) fromJson) =>
// //       StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
// //         handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
// //           final snaps = data.docs.map((doc) => doc.data()).toList();
// //           final users = snaps.map((json) => fromJson(json)).toList();

// //           sink.add(users);
// //         },
// //       );

// //   Future<Widget> _userMicItem() async {
// //     return Container(
// //       child: Column(
// //         children: [
// //           Container(
// //             padding: const EdgeInsets.all(16.0),
// //             decoration: BoxDecoration(
// //                 color: Colors.grey,
// //                 shape: BoxShape.circle,
// //                 border: Border.all(width: 2, color: kPrimaryColor)),
// //             child: Icon(
// //               Icons.mic,
// //               color: Colors.white,
// //               size: 28,
// //             ),
// //           ),
// //           2.height,
// //           Text(
// //             "userName",
// //             style: secondaryTextStyle(
// //               color: Colors.white,
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }

// //   Future<bool> _closeRoom() async {
// //     await CommonFunctions.showAlertWithTwoActions(
// //         widget.roomId, context, "خروج", "هل تريد الخروج من الغرفة؟", () async {
// //       // check if this user hold mic or not first
// //       // var existingItem = _micUsersList.firstWhere(
// //       //     (itemToCheck) =>
// //       //         itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// //       //     orElse: () => null);
// //       // if (existingItem != null) {
// //       //   // user already holds mic before
// //       //   print(existingItem.micNumber);
// //       //   print(existingItem.userName);
// //       //   // leave mic
// //       //   existingItem.userName = null;
// //       //   existingItem.userId = null;
// //       //   existingItem.micNumber = existingItem.micNumber;
// //       //   existingItem.micStatus = false;
// //       //   finish(context);
// //       //   // _updateMicsToFirebase(existingItem.micNumber, existingItem);
// //       // } else {
// //       {
// //         finish(context);
// //       }

// //       finish(
// //         context,
// //       );
// //     });
// //     return true;
// //   }

// //   void _addMicsToFirebase(String roomID) async {
// //     // await _firestoreInstance.collection('roomUsers')
// //     //     .doc(roomID).collection(roomID).doc().delete();
// //     List<UserMicModel> _micsList = [];

// //     _micsList.add(UserMicModel(
// //         id: null,
// //         userId: null,
// //         userName: null,
// //         micNumber: 0,
// //         micStatus: false,
// //         isLocked: false));
// //     _micsList.add(UserMicModel(
// //         id: null,
// //         userId: null,
// //         userName: null,
// //         micNumber: 1,
// //         isLocked: false,
// //         micStatus: false));
// //     _micsList.add(UserMicModel(
// //         id: null,
// //         userId: null,
// //         userName: null,
// //         micNumber: 2,
// //         micStatus: false));
// //     _micsList.add(UserMicModel(
// //         id: null,
// //         userId: null,
// //         userName: null,
// //         micNumber: 3,
// //         micStatus: false));
// //     _micsList.add(UserMicModel(
// //         id: null,
// //         userId: null,
// //         userName: null,
// //         micNumber: 4,
// //         micStatus: false));
// //     CollectionReference _collectionRef = FirebaseFirestore.instance
// //         .collection('roomUsers')
// //         .doc(roomID)
// //         .collection(roomID);
// //     await _collectionRef
// //         .doc(_micsList[0].micNumber.toString())
// //         .set(_micsList[0].toJson());
// //     await _collectionRef
// //         .doc(_micsList[1].micNumber.toString())
// //         .set(_micsList[1].toJson());
// //     await _collectionRef
// //         .doc(_micsList[2].micNumber.toString())
// //         .set(_micsList[2].toJson());
// //     await _collectionRef
// //         .doc(_micsList[3].micNumber.toString())
// //         .set(_micsList[3].toJson());
// //     await _collectionRef
// //         .doc(_micsList[4].micNumber.toString())
// //         .set(_micsList[4].toJson());
// //     _micsList.forEach((element) async {
// //       await _collectionRef
// //           .doc("${_micsList.indexOf(element)}")
// //           .set(element.toJson());
// //     });
// //   }
// // }

// // // class DetailsScreen extends StatefulWidget {
// // //   final String roomId;
// // //   final String roomName;
// // //   final String roomDesc;
// // //   final String roomOwnerId;

// // //   DetailsScreen(
// // //       {Key key, this.roomId, this.roomName, this.roomDesc, this.roomOwnerId})
// // //       : super(key: key);

// // //   @override
// // //   _DetailsScreenState createState() => _DetailsScreenState();
// // // }

// // // class _DetailsScreenState extends State<DetailsScreen> {
// // //   TextEditingController _messageController = TextEditingController();

// // // //  final controller = Get.put(DetailsController());

// // //   static final _users = <int>[];
// // //   final _infoStrings = <String>[];
// // //   bool muted = false;
// // //   RtcEngine _engine;
// // //   bool _isSpeaking = false;

// // //   bool get isSpeaking => _isSpeaking;
// // //   bool _isLoadingMics = true;

// // //   // for chat
// // //   String peerAvatar;
// // //   List<QueryDocumentSnapshot> listMessage = new List.from([]);
// // //   List<QueryDocumentSnapshot> roomUsersList = new List.from([]);
// // //   List<UserMicModel> _micUsersList = [];

// // //   int limit = 20;
// // //   int _roomUsersCount = 0;
// // //   String groupChatId = "";
// // //   String id;
// // //   String roomID = "";

// // //   bool isLoading = false;
// // //   bool isShowSticker = false;
// // //   String imageUrl = "";
// // //   final ScrollController listScrollController = ScrollController();
// // //   final FocusNode focusNode = FocusNode();
// // //   final _firestoreInstance = FirebaseFirestore.instance;
// // //   bool _isMicHold = false;
// // //   bool _isRoomOnFirebase = false;

// // //   @override
// // //   void initState() {
// // //     // TODO: implement initState
// // //     super.initState();
// // //     // readLocal();
// // //     // initialize();
// // //     // _addMicsToFirebase();
// // //     // getRoomUsers();
// // //     print("roomId: $roomID");
// // //   }

// // //   @override
// // //   void dispose() {
// // //     // TODO: implement dispose
// // //     // _users.clear();
// // //     // destroy sdk
// // //     // _engine.leaveChannel();
// // //     print("oncloseeeeee");
// // //     _engine.destroy();
// // //     super.dispose();
// // //   }

// // //   // Future<void> initialize() async {
// // //   //   // check room found or not at first
// // //   //   // await checkRoomFoundOrNot();
// // //   //   // initialize agora
// // //   //   await _initAgoraRtcEngine();
// // //   //   _addAgoraEventHandlers();
// // //   //   await _engine.joinChannel(
// // //   //       "00645f4567598af4f32afca701cccd0cf2dIADRIb4LxYD/WX4B1uQnZIJqrURDf6xrB/V2mFU7a+SDTwnn9jMAAAAAEAD+bihbcUpCYQEAAQCfyEJh",
// // //   //       // "naoumaRoom",
// // //   //       "${widget.roomName}",
// // //   //       null,
// // //   //       0);
// // //   // }

// // //   // Future<void> _initAgoraRtcEngine() async {
// // //   //   if (APP_ID.isEmpty) {
// // //   //     setState(() {
// // //   //       _infoStrings.add(
// // //   //         'APP_ID missing, please provide your APP_ID in settings.dart',
// // //   //       );
// // //   //       _infoStrings.add('Agora Engine is not starting');
// // //   //     });
// // //   //     return;
// // //   //   }
// // //   //   _engine = await RtcEngine.create(APP_ID);
// // //   //   await _engine.enableAudio();
// // //   //   await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
// // //   //   // if (PreferencesServices.getString(ID_KEY) == widget.roomOwnerId) {
// // //   //   //   await _engine.setClientRole(ClientRole.Broadcaster);
// // //   //   // } else {
// // //   //   //   await _engine.setClientRole(ClientRole.Audience);
// // //   //   // }
// // //   // }

// // //   void _addAgoraEventHandlers() {
// // //     _engine.setEventHandler(RtcEngineEventHandler(
// // //       error: (code) {
// // //         setState(() {
// // //           print('onError: $code');
// // //         });
// // //       },
// // //       joinChannelSuccess: (channel, uid, elapsed) {
// // //         print('onJoinChannel: $channel, uid: $uid');
// // //         print("userJoinChannel");
// // //         setState(() {
// // //           _roomUsersCount++;
// // //         });
// // //       },
// // //       leaveChannel: (stats) {
// // //         setState(() {
// // //           print('onLeaveChannel');
// // //           // _users.clear();
// // //           _roomUsersCount > 0 ? _roomUsersCount-- : null;
// // //         });
// // //       },
// // //       userJoined: (uid, elapsed) {
// // //         print('userJoined: $uid');
// // //         setState(() {
// // //           _users.add(uid);
// // //           // _roomUsersCount++;
// // //         });
// // //       },
// // //       audioVolumeIndication: (speakers, int volume) {
// // //         print("isSpeak: ${speakers.any((speaker) => speaker.volume > 0)}");
// // //         if (speakers.any((speaker) => speaker.volume > 0)) {
// // //           setState(() {
// // //             _isSpeaking = true;
// // //           });
// // //         } else {
// // //           setState(() {
// // //             _isSpeaking = false;
// // //           });
// // //         }
// // //         // for(var speaker in speakers){
// // //         //   for(var user in _users) {
// // //         //     if (speaker.volume > 0 && speaker.uid == user) {
// // //         //       // user is speaking now...
// // //         //       // update user speaking ui
// // //         //     }
// // //         //   }
// // //         // }
// // //       },
// // //     ));
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final theme = Theme.of(context);
// // //     final size = MediaQuery.of(context).size;
// // //     //controller.roomID = widget.roomData.id;
// // //     return Directionality(
// // //       textDirection: TextDirection.rtl,
// // //       child: SafeArea(
// // //           top: false,
// // //           child: WillPopScope(
// // //             onWillPop: _closeRoom,
// // //             child: Scaffold(
// // //               body: // GetBuilder<DetailsController>(
// // //                   //     init: Get.find(),
// // //                   // builder:(controller)=>
// // //                   Container(
// // //                 child: Stack(
// // //                   children: [
// // //                     Container(
// // //                       decoration: BoxDecoration(
// // //                         image: DecorationImage(
// // //                             image: NetworkImage(
// // //                                 'https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80'),
// // //                             fit: BoxFit.cover),
// // //                       ),
// // //                     ),
// // //                     Container(
// // //                       padding: const EdgeInsets.symmetric(
// // //                           vertical: 40.0, horizontal: 8.0),
// // //                       child: Column(
// // //                         children: [
// // //                           Row(
// // //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                             children: [
// // //                               Container(
// // //                                 width: size.width / 2 - 16,
// // //                                 padding: const EdgeInsets.symmetric(
// // //                                     vertical: 2.0, horizontal: 6.0),
// // //                                 decoration: BoxDecoration(
// // //                                   color: Colors.black26,
// // //                                   borderRadius: BorderRadius.only(
// // //                                       topLeft: Radius.circular(16.0),
// // //                                       bottomLeft: Radius.circular(16.0)),
// // //                                 ),
// // //                                 child: Row(
// // //                                   children: [
// // //                                     SizedBox(
// // //                                       width: 4.0,
// // //                                     ),
// // //                                     Expanded(
// // //                                       child: Column(
// // //                                         crossAxisAlignment:
// // //                                             CrossAxisAlignment.start,
// // //                                         children: [
// // //                                           Text(
// // //                                             widget.roomName,
// // //                                             maxLines: 1,
// // //                                             style: theme.textTheme.bodyText1
// // //                                                 .copyWith(
// // //                                                     color: Colors.white,
// // //                                                     fontSize: 17),
// // //                                           ),
// // //                                           Text(
// // //                                             "ID: 99",
// // //                                             maxLines: 1,
// // //                                             style: theme.textTheme.bodyText2
// // //                                                 .copyWith(
// // //                                                     color: Colors.white,
// // //                                                     fontSize: 15),
// // //                                           ),
// // //                                         ],
// // //                                       ),
// // //                                     ),
// // //                                     Icon(
// // //                                       Icons.favorite_border,
// // //                                       color: Colors.white,
// // //                                     ),
// // //                                   ],
// // //                                 ),
// // //                               ),
// // //                               Row(
// // //                                 children: [
// // //                                   IconButton(
// // //                                       icon: Icon(Icons.ios_share,
// // //                                           color: Colors.white),
// // //                                       onPressed: () {
// // //                                         print("share btn clicked");
// // //                                       }),
// // //                                   GestureDetector(
// // //                                       child: Icon(Icons.close,
// // //                                           color: Colors.white),
// // //                                       onTap: () {
// // //                                         _closeRoom();
// // //                                       })
// // //                                 ],
// // //                               )
// // //                             ],
// // //                           ),
// // //                           16.height,
// // //                           Container(
// // //                             child: Row(
// // //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                               children: [
// // //                                 Container(
// // //                                   width: 150,
// // //                                   padding: const EdgeInsets.symmetric(
// // //                                       vertical: 2.0, horizontal: 6.0),
// // //                                   decoration: BoxDecoration(
// // //                                     color: Colors.black26,
// // //                                     borderRadius: BorderRadius.only(
// // //                                         topLeft: Radius.circular(16.0),
// // //                                         bottomLeft: Radius.circular(16.0)),
// // //                                   ),
// // //                                   child: Row(
// // //                                     children: [
// // //                                       Icon(Icons.monetization_on_rounded,
// // //                                           color: Colors.orange),
// // //                                       SizedBox(
// // //                                         width: 6.0,
// // //                                       ),
// // //                                       Expanded(
// // //                                         child: Text(
// // //                                           widget.roomName,
// // //                                           maxLines: 1,
// // //                                           style: theme.textTheme.bodyText1
// // //                                               .copyWith(
// // //                                                   color: Colors.white,
// // //                                                   fontSize: 17),
// // //                                         ),
// // //                                       ),
// // //                                       Icon(
// // //                                         Icons.arrow_back_ios_rounded,
// // //                                         color: Colors.grey,
// // //                                       ),
// // //                                     ],
// // //                                   ),
// // //                                 ),
// // //                                 Row(
// // //                                   children: [
// // //                                     Image.asset(
// // //                                       kDefaultProfileImage,
// // //                                       width: 36,
// // //                                       height: 36,
// // //                                     ),
// // //                                     16.width,
// // //                                     Text(
// // //                                       "$_roomUsersCount",
// // //                                       style: theme.textTheme.bodyText1.copyWith(
// // //                                           color: Colors.white, fontSize: 18),
// // //                                     ),
// // //                                     Icon(Icons.person_outline,
// // //                                         color: Colors.white),
// // //                                   ],
// // //                                 )
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           16.height,
// // //                           // Wrap(
// // //                           //   spacing: 16.0,
// // //                           //   runSpacing: 16.0,
// // //                           //   children: [
// // //                           //     _personInRoom(1, "1"),
// // //                           //     _personInRoom(2, "2"),
// // //                           //     _personInRoom(3, "3"),
// // //                           //     _personInRoom(4, "4"),
// // //                           //     _personInRoom(5, "5"),
// // //                           //   ],
// // //                           // ),
// // //                           Container(
// // //                             padding: const EdgeInsets.all(6.0),
// // //                             child: Stack(
// // //                               // fit: StackFit.expand,
// // //                               // overflow: Overflow.visible,
// // //                               children: [
// // //                                 Container(
// // //                                   width: double.infinity,
// // //                                   // margin: const EdgeInsets.only(top:10, right: 60),
// // //                                   child: _roomMicsLayout(),
// // //                                 ),
// // //                                 // Positioned(
// // //                                 //   top: 0,
// // //                                 //   right: 0,
// // //                                 //   child: _isMicHold?Container(): Container(
// // //                                 //   // width: 68,
// // //                                 //   // height: 68,
// // //                                 //     padding: const EdgeInsets.all(6.0),
// // //                                 //   decoration: BoxDecoration(
// // //                                 //     shape: BoxShape.circle,
// // //                                 //     color: Colors.white,
// // //                                 //     border: Border.all(color: kPrimaryColor.withOpacity(0.4), width: 2.0),
// // //                                 //   ),
// // //                                 //   child: Column(
// // //                                 //     mainAxisAlignment: MainAxisAlignment.center,
// // //                                 //     children: [
// // //                                 //       Icon(Icons.mic,color: kPrimaryColor, size: 28,),
// // //                                 //       Text("طلب مايك", style: secondaryTextStyle(color: kPrimaryColor, size: 12),)
// // //                                 //     ],
// // //                                 //   ),
// // //                                 // ).onTap(() {
// // //                                 //
// // //                                 // }),),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                           16.height,
// // //                           Container(
// // //                             width: double.infinity,
// // //                             padding: const EdgeInsets.symmetric(
// // //                                 vertical: 4.0, horizontal: 8.0),
// // //                             decoration: BoxDecoration(
// // //                               color: Colors.black54,
// // //                             ),
// // //                             child: Marquee(
// // //                               child: Text(
// // //                                 'Some sample text that takes some space, Some sample text that takes some space. ',
// // //                                 style: theme.textTheme.bodyText1
// // //                                     .copyWith(color: Colors.white),
// // //                               ),
// // //                               direction: Axis.horizontal,
// // //                               textDirection: TextDirection.rtl,
// // //                               pauseDuration: Duration(seconds: 2),
// // //                               backDuration: Duration(seconds: 2),
// // //                               animationDuration: Duration(seconds: 6),
// // //                               directionMarguee: DirectionMarguee.oneDirection,
// // //                             ),
// // //                           ),
// // //                           buildListMessage(size),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                     Positioned(
// // //                       bottom: 10,
// // //                       left: 10,
// // //                       right: 10,
// // //                       child: Row(
// // //                         children: [
// // //                           Container(
// // //                             padding: const EdgeInsets.all(6.0),
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               color: Colors.black45,
// // //                             ),
// // //                             child: Icon(
// // //                               Icons.mic_external_on,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ),
// // //                           8.width,
// // //                           Expanded(
// // //                             child: Container(
// // //                               padding: const EdgeInsets.symmetric(
// // //                                   horizontal: 6, vertical: 2.0),
// // //                               decoration: BoxDecoration(
// // //                                 color: Colors.black26,
// // //                                 borderRadius:
// // //                                     BorderRadius.all(Radius.circular(16.0)),
// // //                               ),
// // //                               child: TextField(
// // //                                 keyboardType: TextInputType.text,
// // //                                 controller: _messageController,
// // //                                 style: TextStyle(color: Colors.white),
// // //                                 decoration: InputDecoration.collapsed(
// // //                                   hintText: "رسالتك...",
// // //                                   hintStyle: TextStyle(color: Colors.white),
// // //                                 ),
// // //                               ),
// // //                             ),
// // //                           ),
// // //                           8.width,
// // //                           Container(
// // //                             padding: const EdgeInsets.all(5.0),
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               color: Colors.orange,
// // //                             ),
// // //                             child: Icon(
// // //                               Icons.send,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ).onTap(() {
// // //                             onSendMessage(_messageController.text, 0);
// // //                           }),
// // //                           8.width,
// // //                           Container(
// // //                             padding: const EdgeInsets.all(6.0),
// // //                             decoration: BoxDecoration(
// // //                               shape: BoxShape.circle,
// // //                               color: Colors.black45,
// // //                             ),
// // //                             child: Icon(
// // //                               Icons.mic_external_on,
// // //                               color: Colors.white,
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           )),
// // //     );
// // //   }

// // //   checkRoomFoundOrNot() async {
// // //     DocumentSnapshot ds =
// // //         await _firestoreInstance.collection("roomUsers").doc(roomID).get();
// // //     this.setState(() {
// // //       _isRoomOnFirebase = ds.exists;
// // //       print("_isRoomOnFirebase: $_isRoomOnFirebase");
// // //     });
// // //     // if room not exist add it to firebase
// // //     _isRoomOnFirebase ? null : _addMicsToFirebase(roomID);
// // //   }

// // //   Widget _personInRoom(int index, UserMicModel micModel) {
// // //     print("$index");
// // //     print("${micModel.userName}");
// // //     return Expanded(
// // //       child: Container(
// // //         child: Column(
// // //           children: [
// // //             Container(
// // //               padding: const EdgeInsets.all(6.0),
// // //               decoration: BoxDecoration(
// // //                   color: Colors.grey,
// // //                   shape: BoxShape.circle,
// // //                   border: Border.all(width: 2, color: kPrimaryColor)),
// // //               child: Icon(
// // //                 micModel.isLocked != null
// // //                     ? micModel.isLocked
// // //                         ? Icons.lock
// // //                         : Icons.mic
// // //                     : Icons.mic,
// // //                 color: Colors.white,
// // //                 size: 26,
// // //               ),
// // //             ),
// // //             2.height,
// // //             Text(
// // //               micModel.isLocked != null && micModel.isLocked
// // //                   ? "مقفل"
// // //                   : micModel.micStatus
// // //                       ? micModel.userName.length > 7
// // //                           ? ".${micModel.userName}"
// // //                           : "${micModel.userName}"
// // //                       : "${index + 1}",
// // //               overflow: TextOverflow.ellipsis,
// // //               style: secondaryTextStyle(size: 12, color: black),
// // //             ),
// // //           ],
// // //         ),
// // //       ).onTap(() {
// // //         if (!micModel.micStatus &&
// // //             !micModel.isLocked &&
// // //             micModel.userId == null &&
// // //             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
// // //           // Iam room owner and mic is empty
// // //           print("Iam owner and mic is empty.");
// // //           var existingItem = _micUsersList.firstWhere(
// // //               (itemToCheck) =>
// // //                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// // //               orElse: () => null);
// // //           if (existingItem != null) {
// // //             // user already holds mic before
// // //             print(existingItem.micNumber);
// // //             print(existingItem.userName);
// // //             print("take other mic");
// // //             showDialog(
// // //                 context: context,
// // //                 builder: (BuildContext context) {
// // //                   return MicClickDialog(
// // //                     takeMicFunction: () {
// // //                       print("clicked take");
// // //                       print("clicked index: $index");
// // //                       // leave old mic
// // //                       existingItem.id = null;
// // //                       existingItem.userName = null;
// // //                       existingItem.userId = null;
// // //                       existingItem.micNumber = existingItem.micNumber;
// // //                       existingItem.micStatus = false;
// // //                       _updateMicsToFirebase(
// // //                           existingItem.micNumber, existingItem);
// // //                       print("existname: ${existingItem.userName}");
// // //                       print("existuserId: ${existingItem.userId}");
// // //                       print("existmicNumber: ${existingItem.micNumber}");
// // //                       print("existid: ${existingItem.micNumber}");
// // //                       print("existmicStatus: ${existingItem.micStatus}");

// // //                       // go to new mic
// // //                       micModel.id = index.toString();
// // //                       micModel.userName =
// // //                           PreferencesServices.getString(Name_KEY);
// // //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = true;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       finish(context);
// // //                       _updateMicsToFirebase(index, micModel);
// // //                     },
// // //                     leaveMicFunction: () {},
// // //                     lockMicFunction: () {
// // //                       // lock mic
// // //                       micModel.id = null;
// // //                       micModel.userName = null;
// // //                       micModel.userId = null;
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = false;
// // //                       micModel.isLocked = true;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     unLockMicFunction: () {},
// // //                     showTakeMic: true,
// // //                     showLeaveMic: false,
// // //                     showLockMic: true,
// // //                     micIsLocked: false,
// // //                   );
// // //                 });
// // //           } else {
// // //             print("not take other mic");
// // //             showDialog(
// // //                 context: context,
// // //                 builder: (BuildContext context) {
// // //                   return MicClickDialog(
// // //                     takeMicFunction: () {
// // //                       // go to new mic
// // //                       micModel.id = index.toString();
// // //                       micModel.userName =
// // //                           PreferencesServices.getString(Name_KEY);
// // //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = true;
// // //                       micModel.isLocked = false;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     leaveMicFunction: () {},
// // //                     lockMicFunction: () {
// // //                       // lock mic
// // //                       micModel.id = null;
// // //                       micModel.userName = null;
// // //                       micModel.userId = null;
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = false;
// // //                       micModel.isLocked = true;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     unLockMicFunction: () {},
// // //                     showTakeMic: true,
// // //                     showLeaveMic: false,
// // //                     showLockMic: true,
// // //                     micIsLocked: false,
// // //                   );
// // //                 });
// // //           }
// // //         } else if (!micModel.micStatus &&
// // //             micModel.isLocked &&
// // //             micModel.userId == null &&
// // //             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
// // //           // Iam room owner and mic is locked
// // //           print("Iam room owner and mic is locked...");
// // //           showDialog(
// // //               context: context,
// // //               builder: (BuildContext context) {
// // //                 return MicClickDialog(
// // //                   takeMicFunction: () {},
// // //                   leaveMicFunction: () {},
// // //                   unLockMicFunction: () {
// // //                     print("unLock Mic index: $index");
// // //                     micModel.id = null;
// // //                     micModel.userName = null;
// // //                     micModel.userId = null;
// // //                     micModel.micNumber = index;
// // //                     micModel.micStatus = false;
// // //                     micModel.isLocked = false;
// // //                     print("name: ${micModel.userName}");
// // //                     print("userId: ${micModel.userId}");
// // //                     print("micNumber: ${micModel.micNumber}");
// // //                     print("id: ${micModel.micNumber}");
// // //                     print("micStatus: ${micModel.micStatus}");
// // //                     _updateMicsToFirebase(index, micModel);
// // //                     finish(context);
// // //                   },
// // //                   showTakeMic: false,
// // //                   showLeaveMic: false,
// // //                   showLockMic: false,
// // //                   micIsLocked: true,
// // //                 );
// // //               });
// // //         } else if (micModel.micStatus &&
// // //             !micModel.isLocked &&
// // //             micModel.userId == PreferencesServices.getString(ID_KEY) &&
// // //             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
// // //           // Iam room owner and mic is locked
// // //           print("Iam room owner and mic is taken by me...");
// // //           showDialog(
// // //               context: context,
// // //               builder: (BuildContext context) {
// // //                 return MicClickDialog(
// // //                   takeMicFunction: () {},
// // //                   leaveMicFunction: () {
// // //                     print("unLock Mic index: $index");
// // //                     micModel.id = null;
// // //                     micModel.userName = null;
// // //                     micModel.userId = null;
// // //                     micModel.micNumber = index;
// // //                     micModel.micStatus = false;
// // //                     micModel.isLocked = false;
// // //                     print("name: ${micModel.userName}");
// // //                     print("userId: ${micModel.userId}");
// // //                     print("micNumber: ${micModel.micNumber}");
// // //                     print("id: ${micModel.micNumber}");
// // //                     print("micStatus: ${micModel.micStatus}");
// // //                     _updateMicsToFirebase(index, micModel);
// // //                     finish(context);
// // //                   },
// // //                   unLockMicFunction: () {},
// // //                   showTakeMic: false,
// // //                   showLeaveMic: true,
// // //                   showLockMic: false,
// // //                   micIsLocked: false,
// // //                 );
// // //               });
// // //         } else if (!micModel.micStatus &&
// // //             !micModel.isLocked &&
// // //             micModel.userId == null &&
// // //             micModel.roomOwnerId != PreferencesServices.getString(ID_KEY)) {
// // //           // Iam not room owner and mic is locked
// // //           print("Iam not room owner and mic is taken by me...");
// // //           var existingItem = _micUsersList.firstWhere(
// // //               (itemToCheck) =>
// // //                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// // //               orElse: () => null);
// // //           if (existingItem != null) {
// // //             // user already holds mic before
// // //             print(existingItem.micNumber);
// // //             print(existingItem.userName);
// // //             print("take other mic");
// // //             showDialog(
// // //                 context: context,
// // //                 builder: (BuildContext context) {
// // //                   return MicClickDialog(
// // //                     takeMicFunction: () {
// // //                       print("clicked take");
// // //                       print("clicked index: $index");
// // //                       // leave old mic
// // //                       existingItem.id = null;
// // //                       existingItem.userName = null;
// // //                       existingItem.userId = null;
// // //                       existingItem.micNumber = existingItem.micNumber;
// // //                       existingItem.micStatus = false;
// // //                       _updateMicsToFirebase(
// // //                           existingItem.micNumber, existingItem);
// // //                       print("existname: ${existingItem.userName}");
// // //                       print("existuserId: ${existingItem.userId}");
// // //                       print("existmicNumber: ${existingItem.micNumber}");
// // //                       print("existid: ${existingItem.micNumber}");
// // //                       print("existmicStatus: ${existingItem.micStatus}");

// // //                       // go to new mic
// // //                       micModel.id = index.toString();
// // //                       micModel.userName =
// // //                           PreferencesServices.getString(Name_KEY);
// // //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = true;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       // update firebase
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     leaveMicFunction: () {
// // //                       print("leave index: $index");
// // //                       micModel.id = null;
// // //                       micModel.userName = null;
// // //                       micModel.userId = null;
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = false;
// // //                       micModel.isLocked = false;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       // update firebase
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     lockMicFunction: () {},
// // //                     unLockMicFunction: () {},
// // //                     showTakeMic: true,
// // //                     showLeaveMic: true,
// // //                     showLockMic: false,
// // //                     micIsLocked: false,
// // //                   );
// // //                 });
// // //           } else {
// // //             print("not take other mic");
// // //             showDialog(
// // //                 context: context,
// // //                 builder: (BuildContext context) {
// // //                   return MicClickDialog(
// // //                     takeMicFunction: () {
// // //                       // go to new mic
// // //                       micModel.id = index.toString();
// // //                       micModel.userName =
// // //                           PreferencesServices.getString(Name_KEY);
// // //                       micModel.userId = PreferencesServices.getString(ID_KEY);
// // //                       micModel.micNumber = index;
// // //                       micModel.micStatus = true;
// // //                       micModel.isLocked = false;
// // //                       print("name: ${micModel.userName}");
// // //                       print("userId: ${micModel.userId}");
// // //                       print("micNumber: ${micModel.micNumber}");
// // //                       print("id: ${micModel.micNumber}");
// // //                       print("micStatus: ${micModel.micStatus}");
// // //                       _updateMicsToFirebase(index, micModel);
// // //                       finish(context);
// // //                     },
// // //                     leaveMicFunction: () {
// // //                       finish(context);
// // //                     },
// // //                     lockMicFunction: () {},
// // //                     unLockMicFunction: () {},
// // //                     showTakeMic: true,
// // //                     showLeaveMic: true,
// // //                     showLockMic: false,
// // //                     micIsLocked: false,
// // //                   );
// // //                 });
// // //           }
// // //         } else if (micModel.micStatus &&
// // //             !micModel.isLocked &&
// // //             micModel.userId != null &&
// // //             micModel.userId == PreferencesServices.getString(ID_KEY)) {
// // //           // mic taken by me...
// // //           print("mic taken by me...");
// // //           showDialog(
// // //               context: context,
// // //               builder: (BuildContext context) {
// // //                 return MicClickDialog(
// // //                   takeMicFunction: () {},
// // //                   leaveMicFunction: () {
// // //                     print("leave index: $index");
// // //                     micModel.id = null;
// // //                     micModel.userName = null;
// // //                     micModel.userId = null;
// // //                     micModel.micNumber = index;
// // //                     micModel.micStatus = false;
// // //                     print("name: ${micModel.userName}");
// // //                     print("userId: ${micModel.userId}");
// // //                     print("micNumber: ${micModel.micNumber}");
// // //                     print("id: ${micModel.micNumber}");
// // //                     print("micStatus: ${micModel.micStatus}");
// // //                     finish(context);
// // //                     _updateMicsToFirebase(index, micModel);
// // //                   },
// // //                   lockMicFunction: () {},
// // //                   unLockMicFunction: () {},
// // //                   showLockMic: false,
// // //                   micIsLocked: false,
// // //                   showTakeMic: false,
// // //                   showLeaveMic: true,
// // //                 );
// // //               });
// // //         } else if (micModel.micStatus &&
// // //             !micModel.isLocked &&
// // //             micModel.userId != null &&
// // //             micModel.userId != PreferencesServices.getString(ID_KEY)) {
// // //           // taken by other one
// // //           CommonFunctions.showToast("Mic already taken", Colors.red);
// // //         } else if (!micModel.micStatus &&
// // //             micModel.isLocked &&
// // //             micModel.userId != null &&
// // //             micModel.userId != PreferencesServices.getString(ID_KEY)) {
// // //           // Mic is locked
// // //           CommonFunctions.showToast("Mic is locked", Colors.red);
// // //         }
// // //         // else{
// // //         //   print("_micUsersList: ${_micUsersList.length}");
// // //         //   //find existing item per link criteria
// // //         //           var existingItem = _micUsersList.firstWhere((itemToCheck) => itemToCheck.userId == PreferencesServices.getString(ID_KEY), orElse: () => null);
// // //         //           if(existingItem != null){
// // //         //             // user already holds mic before
// // //         //             print(existingItem.micNumber);
// // //         //             print(existingItem.userName);
// // //         //             print("take other mic");
// // //         //             showDialog(context: context,
// // //         //                 builder: (BuildContext context){
// // //         //                   return MicClickDialog(takeMicFunction: (){
// // //         //                     print("clicked take");
// // //         //                     print("clicked index: $index");
// // //         //                     // leave old mic
// // //         //                     existingItem.id = null;
// // //         //                     existingItem.userName = null;
// // //         //                     existingItem.userId = null;
// // //         //                     existingItem.micNumber = existingItem.micNumber;
// // //         //                     existingItem.micStatus = false;
// // //         //                     _updateMicsToFirebase(existingItem.micNumber, existingItem);
// // //         //                     print("existname: ${existingItem.userName}");
// // //         //                     print("existuserId: ${existingItem.userId}");
// // //         //                     print("existmicNumber: ${existingItem.micNumber}");
// // //         //                     print("existid: ${existingItem.micNumber}");
// // //         //                     print("existmicStatus: ${existingItem.micStatus}");
// // //         //
// // //         //                     // go to new mic
// // //         //                     micModel.id = index.toString();
// // //         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
// // //         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
// // //         //                     micModel.micNumber = index;
// // //         //                     micModel.micStatus = true;
// // //         //                     print("name: ${micModel.userName}");
// // //         //                     print("userId: ${micModel.userId}");
// // //         //                     print("micNumber: ${micModel.micNumber}");
// // //         //                     print("id: ${micModel.micNumber}");
// // //         //                     print("micStatus: ${micModel.micStatus}");
// // //         //                     finish(context);
// // //         //                     _updateMicsToFirebase(index, micModel);
// // //         //                   }, leaveMicFunction: (){
// // //         //                     print("leave index: $index");
// // //         //                     finish(context);
// // //         //                   });
// // //         //                 }
// // //         //             );
// // //         //           } else{
// // //         //             print("not take other mic");
// // //         //             showDialog(context: context,
// // //         //                 builder: (BuildContext context){
// // //         //                   return MicClickDialog(takeMicFunction: (){
// // //         //                     print("clicked take");
// // //         //                     print("clicked index: $index");
// // //         //                     micModel.id = "$index";
// // //         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
// // //         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
// // //         //                     micModel.micNumber = index;
// // //         //                     micModel.micStatus = true;
// // //         //                     print("name: ${micModel.userName}");
// // //         //                     print("userId: ${micModel.userId}");
// // //         //                     print("micNumber: ${micModel.micNumber}");
// // //         //                     print("id: ${micModel.micNumber}");
// // //         //                     print("micStatus: ${micModel.micStatus}");
// // //         //                     finish(context);
// // //         //                     _updateMicsToFirebase(index, micModel);
// // //         //
// // //         //                   }, leaveMicFunction: (){
// // //         //                     print("leave index: $index");
// // //         //                     finish(context);
// // //         //                   });
// // //         //                 }
// // //         //             );
// // //         //           }
// // //         // }
// // //       }),
// // //     );
// // //   }

// // //   void onSendMessage(String content, int type) {
// // //     // type: 0 = text, 1 = image, 2 = sticker
// // //     if (content.trim() != '') {
// // //       _messageController.clear();

// // //       var documentReference = FirebaseFirestore.instance
// // //           .collection('messages')
// // //           .doc(groupChatId)
// // //           .collection(groupChatId)
// // //           .doc(DateTime.now().millisecondsSinceEpoch.toString());

// // //       FirebaseFirestore.instance.runTransaction((transaction) async {
// // //         transaction.set(
// // //           documentReference,
// // //           {
// // //             'idFrom': id,
// // //             'idTo': widget.roomId,
// // //             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
// // //             'content': content,
// // //             'type': type
// // //           },
// // //         );
// // //       });
// // //       listScrollController.animateTo(0.0,
// // //           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
// // //     } else {
// // //       CommonFunctions.showToast('Nothing to send', Colors.red);
// // //     }
// // //   }

// // //   void onFocusChange() {
// // //     if (focusNode.hasFocus) {
// // //       // Hide sticker when keyboard appear
// // //       setState(() {
// // //         isShowSticker = false;
// // //       });
// // //     }
// // //   }

// // //   readLocal() async {
// // //     id = PreferencesServices.getString(ID_KEY);
// // //     if (id.hashCode <= widget.roomId.hashCode) {
// // //       setState(() {
// // //         groupChatId = '${widget.roomId}';
// // //         roomID = widget.roomId;
// // //       });
// // //     } else {
// // //       setState(() {
// // //         groupChatId = '${widget.roomId}';
// // //         roomID = widget.roomId;
// // //       });
// // //     }
// // //   }

// // //   Widget buildListMessage(Size size) {
// // //     return Flexible(
// // //       child: groupChatId.isNotEmpty
// // //           ? StreamBuilder<QuerySnapshot>(
// // //               stream: FirebaseFirestore.instance
// // //                   .collection('messages')
// // //                   .doc(groupChatId)
// // //                   .collection(groupChatId)
// // //                   .orderBy('timestamp', descending: true)
// // //                   .limit(limit)
// // //                   .snapshots(),
// // //               builder: (BuildContext context,
// // //                   AsyncSnapshot<QuerySnapshot> snapshot) {
// // //                 print("messaegs: ${snapshot.toString()}");
// // //                 if (snapshot.hasData) {
// // //                   listMessage.addAll(snapshot.data.docs);
// // //                   return ListView.builder(
// // //                     padding: EdgeInsets.all(10.0),
// // //                     itemBuilder: (context, index) =>
// // //                         buildItem(index, snapshot.data?.docs[index], size),
// // //                     itemCount: snapshot.data?.docs.length,
// // //                     reverse: true,
// // //                     controller: listScrollController,
// // //                   );
// // //                 } else {
// // //                   return Center(
// // //                     child: CircularProgressIndicator(
// // //                       valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
// // //                     ),
// // //                   );
// // //                 }
// // //               },
// // //             )
// // //           : Center(
// // //               child: CircularProgressIndicator(
// // //                 valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
// // //               ),
// // //             ),
// // //     );
// // //   }

// // //   Widget buildItem(int index, DocumentSnapshot document, Size size) {
// // //     if (document != null) {
// // //       // Right (my message)
// // //       return document.get('type') == 0
// // //           // Text
// // //           ? Container(
// // //               width: size.width * 0.7,
// // //               padding: const EdgeInsets.all(6.0),
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.start,
// // //                 children: [
// // //                   Container(
// // //                     width: 36,
// // //                     height: 36,
// // //                     child: ClipRRect(
// // //                       borderRadius: BorderRadius.all(Radius.circular(16.0)),
// // //                       child: Image.asset(
// // //                         kDefaultProfileImage,
// // //                         width: 36,
// // //                         height: 36,
// // //                       ),
// // //                     ),
// // //                   ),
// // //                   10.width,
// // //                   Expanded(
// // //                     child: Container(
// // //                       child: Text(
// // //                         document.get('content'),
// // //                         style: secondaryTextStyle(color: Colors.white),
// // //                         maxLines: 2,
// // //                         textAlign: TextAlign.start,
// // //                         overflow: TextOverflow.ellipsis,
// // //                       ),
// // //                       // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
// // //                       color: Colors.transparent,
// // //                       // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
// // //                       // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// // //                     ),
// // //                   ),
// // //                 ],
// // //               ),
// // //             )
// // //           : document.get('type') == 1
// // //               // Image
// // //               ? Container(
// // //                   child: OutlinedButton(
// // //                     child: Material(
// // //                       child: Image.network(
// // //                         document.get("content"),
// // //                         loadingBuilder: (BuildContext context, Widget child,
// // //                             ImageChunkEvent loadingProgress) {
// // //                           if (loadingProgress == null) return child;
// // //                           return Container(
// // //                             decoration: BoxDecoration(
// // //                               color: Colors.grey.shade600,
// // //                               borderRadius: BorderRadius.all(
// // //                                 Radius.circular(8.0),
// // //                               ),
// // //                             ),
// // //                             width: 200.0,
// // //                             height: 200.0,
// // //                             child: Center(
// // //                               child: CircularProgressIndicator(
// // //                                 value: loadingProgress.expectedTotalBytes !=
// // //                                             null &&
// // //                                         loadingProgress.expectedTotalBytes !=
// // //                                             null
// // //                                     ? loadingProgress.cumulativeBytesLoaded /
// // //                                         loadingProgress.expectedTotalBytes
// // //                                     : null,
// // //                               ),
// // //                             ),
// // //                           );
// // //                         },
// // //                         errorBuilder: (context, object, stackTrace) {
// // //                           return Material(
// // //                             child: Image.asset(
// // //                               'images/img_not_available.jpeg',
// // //                               width: 200.0,
// // //                               height: 200.0,
// // //                               fit: BoxFit.cover,
// // //                             ),
// // //                             borderRadius: BorderRadius.all(
// // //                               Radius.circular(8.0),
// // //                             ),
// // //                             clipBehavior: Clip.hardEdge,
// // //                           );
// // //                         },
// // //                         width: 200.0,
// // //                         height: 200.0,
// // //                         fit: BoxFit.cover,
// // //                       ),
// // //                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
// // //                       clipBehavior: Clip.hardEdge,
// // //                     ),
// // //                     onPressed: () {},
// // //                     style: ButtonStyle(
// // //                         padding: MaterialStateProperty.all<EdgeInsets>(
// // //                             EdgeInsets.all(0))),
// // //                   ),
// // //                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// // //                 )
// // //               // Sticker
// // //               : Container(
// // //                   child: Image.asset(
// // //                     'images/${document.get('content')}.gif',
// // //                     width: 100.0,
// // //                     height: 100.0,
// // //                     fit: BoxFit.cover,
// // //                   ),
// // //                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
// // //                 );
// // //     } else {
// // //       return SizedBox.shrink();
// // //     }
// // //   }

// // //   Future getRoomUsers() async {
// // //     _isLoadingMics = true;
// // //     var collection = FirebaseFirestore.instance.collection('roomUsers');
// // //     var docSnapshot = await collection.doc(roomID).collection(roomID).get();
// // //     // Map<String, dynamic> data = docSnapshot.docs;
// // //     // QuerySnapshot querySnapshot = await _firestoreInstance.collection('roomUsers').doc(roomID).get().;
// // //     // // // Get data from docs and convert map to List
// // //     if (collection != null && docSnapshot != null) {
// // //       // docSnapshot.docs.length > 0 ? _addMicsToFirebase() : null;
// // //       roomUsersList = docSnapshot.docs;
// // //       setState(() {
// // //         _isLoadingMics = false;
// // //       });
// // //     }
// // //     // // roomUsersList = querySnapshot.docs.map((doc) => doc.data()).toList();
// // //     // setState(() {
// // //     //   _usersCount = roomUsersList.length;
// // //     // });
// // //     // print(roomUsersList.toString());
// // //     // print("userslst: ${roomUsersList.length}");
// // //     // roomUsersList.forEach((querySnapshot) {
// // //     //   Map<String, dynamic> jsonData = querySnapshot.data();
// // //     //   UserMicModel userMicModel = UserMicModel.fromJson(jsonData);
// // //     //   print(userMicModel.userId);
// // //     //   print("users: ${userMicModel.userName}");
// // //     //   print("users: ${querySnapshot.data()['userName']}");
// // //     // });
// // //     // _firestore.collection('favorites').where('user_id', isEqualTo: uid).getDocuments()
// // //     //     .then((querySnap) {
// // //     //   querySnap.documents.forEach((document) {
// // //     //     print(document.data);
// // //     //
// // //     //     Map<String, dynamic> json = document.data; //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
// // //     //     Album album = new Album.fromJson(json['favorite_albums'][0]); //Throws the type exception
// // //     //   });
// // //     // })
// // //     //     .catchError((error) {
// // //     //   print(error);
// // //     // });
// // //   }

// // //   Widget _roomMicsLayout() {
// // //     Stream<List<UserMicModel>> _stream = _firestoreInstance
// // //         .collection('roomUsers')
// // //         .doc(widget.roomId)
// // //         .collection(widget.roomId)
// // //         .snapshots()
// // //         .transform(transformer((json) => UserMicModel.fromJson(json)));
// // //     return StreamBuilder<List<UserMicModel>>(
// // //         stream: _stream,
// // //         builder:
// // //             (BuildContext context, AsyncSnapshot<List<UserMicModel>> snapshot) {
// // //           if (snapshot.hasData && snapshot.data.length > 0) {
// // //             print(":has data");
// // //             _micUsersList = snapshot.data;
// // //             return Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3.0),
// // //               child: Row(
// // //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// // //                 children: List.generate(5, (index) {
// // //                   // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
// // //                   return _personInRoom(
// // //                     index,
// // //                     snapshot.data[index],
// // //                   );
// // //                 }).toList(),
// // //                 // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
// // //               ),
// // //               // child: Container(
// // //               //   height: 100,
// // //               //   child: ListView.builder(
// // //               //       scrollDirection: Axis.horizontal,
// // //               //       // shrinkWrap: true,
// // //               //       itemCount: 5,
// // //               //       itemBuilder: (BuildContext context, int index){
// // //               //     return _personInRoom(index, snapshot.data[index],);
// // //               //   }),
// // //               // ),
// // //             );
// // //           } else {
// // //             print("not has data");
// // //             List<UserMicModel> _micsList = [];

// // //             _micsList.add(UserMicModel(
// // //                 id: null,
// // //                 userId: null,
// // //                 userName: null,
// // //                 micNumber: 0,
// // //                 micStatus: false,
// // //                 isLocked: false));
// // //             _micsList.add(UserMicModel(
// // //                 id: null,
// // //                 userId: null,
// // //                 userName: null,
// // //                 micNumber: 1,
// // //                 micStatus: false,
// // //                 isLocked: false));
// // //             _micsList.add(UserMicModel(
// // //                 id: null,
// // //                 userId: null,
// // //                 userName: null,
// // //                 micNumber: 2,
// // //                 micStatus: false,
// // //                 isLocked: false));
// // //             _micsList.add(UserMicModel(
// // //                 id: null,
// // //                 userId: null,
// // //                 userName: null,
// // //                 micNumber: 3,
// // //                 micStatus: false,
// // //                 isLocked: false));
// // //             _micsList.add(UserMicModel(
// // //                 id: null,
// // //                 userId: null,
// // //                 userName: null,
// // //                 micNumber: 4,
// // //                 micStatus: false,
// // //                 isLocked: false));
// // //             return Padding(
// // //               padding: const EdgeInsets.symmetric(horizontal: 12.0),
// // //               child: Row(
// // //                 children: [
// // //                   _personInRoom(
// // //                     0,
// // //                     _micsList[0],
// // //                   ),
// // //                   _personInRoom(
// // //                     1,
// // //                     _micsList[1],
// // //                   ),
// // //                   _personInRoom(
// // //                     2,
// // //                     _micsList[2],
// // //                   ),
// // //                   _personInRoom(
// // //                     3,
// // //                     _micsList[3],
// // //                   ),
// // //                   _personInRoom(
// // //                     4,
// // //                     _micsList[4],
// // //                   ),
// // //                 ],
// // //               ),
// // //             );
// // //           }
// // //           return ListView.builder(
// // //             shrinkWrap: true,
// // //             scrollDirection: Axis.horizontal,
// // //             physics: NeverScrollableScrollPhysics(),
// // //             padding: EdgeInsets.all(5.0),
// // //             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
// // //             itemBuilder: (context, index) {
// // //               bool _isThisMic;
// // //               for (var map in roomUsersList) {
// // //                 _micUsersList.add(UserMicModel.fromJson(map));
// // //                 // if (roomUsersList[index].data().containsKey("micNumber")) {
// // //                 //     if (roomUsersList[index].data()["micNumber"] == "${index +1}") {
// // //                 //       // your list of map contains key "id" which has value 3
// // //                 //       // CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
// // //                 //       // print("id: ${map.data()["userId"]}");
// // //                 //       setState(() {
// // //                 //         _isThisMic = true;
// // //                 //       });
// // //                 //     }
// // //                 //   }
// // //               }
// // //               return Container(
// // //                 child: Column(
// // //                   children: [
// // //                     Container(
// // //                       padding: const EdgeInsets.all(6.0),
// // //                       decoration: BoxDecoration(
// // //                           color: Colors.grey,
// // //                           shape: BoxShape.circle,
// // //                           border: Border.all(width: 1, color: kPrimaryColor)),
// // //                       child: Icon(
// // //                         Icons.mic,
// // //                         color: Colors.white,
// // //                         size: 28,
// // //                       ),
// // //                     ),
// // //                     2.height,
// // //                     Text(
// // //                       roomUsersList[index].data() != null
// // //                           ? "${roomUsersList[index].data()["userName"]}"
// // //                           : "${index + 1}",
// // //                       style: secondaryTextStyle(color: Colors.white, size: 16),
// // //                     ),
// // //                   ],
// // //                 ),
// // //               ).onTap(() {
// // //                 print("changeRole: to broadCast");
// // //                 // for (var map in roomUsersList) {
// // //                 //   if (map.data().containsKey("micNumber")) {
// // //                 //     if (map.data()["micNumber"] == "${index +1}") {
// // //                 //       // your list of map contains key "id" which has value 3
// // //                 //       CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
// // //                 //       print("id: ${map.data()["userId"]}");
// // //                 //       return;
// // //                 //     }
// // //                 //   }
// // //                 // }
// // //                 _firestoreInstance
// // //                     .collection('roomUsers')
// // //                     .doc(roomID)
// // //                     .collection(roomID)
// // //                     .add({
// // //                   'micNumber': "${index + 1}",
// // //                   'userId': PreferencesServices.getString(ID_KEY),
// // //                   "userName": PreferencesServices.getString(Name_KEY)
// // //                 }).then((value) {
// // //                   setState(() {
// // //                     // _isMicHold = true;
// // //                     _roomUsersCount++;
// // //                     _engine
// // //                         .setClientRole(
// // //                           ClientRole.Broadcaster,
// // //                         )
// // //                         .then(
// // //                           (value) {},
// // //                         );
// // //                   });
// // //                 });
// // //               });
// // //             },
// // //             itemCount: 5,
// // //             controller: listScrollController,
// // //           );
// // //         });
// // //   }

// // //   void _updateMicsToFirebase(int index, UserMicModel micModel) async {
// // //     print("inUpdate doc: $index");
// // //     print("name: ${micModel.userName}");
// // //     print("id: ${micModel.userId}");
// // //     CollectionReference _collectionRef = FirebaseFirestore.instance
// // //         .collection('roomUsers')
// // //         .doc(roomID)
// // //         .collection(roomID);
// // //     await _collectionRef.doc("$index").update({
// // //       "id": micModel.id,
// // //       "userId": micModel.userId,
// // //       "userName": micModel.userName,
// // //       "micNumber": micModel.micNumber,
// // //       "micStatus": micModel.micStatus,
// // //       "isLocked": micModel.isLocked
// // //     }).catchError((e) {
// // //       print(e);
// // //       return;
// // //     });
// // //     setState(() {
// // //       micModel.micStatus
// // //           ? _engine
// // //               .setClientRole(
// // //               ClientRole.Broadcaster,
// // //             )
// // //               .then(
// // //               (value) {
// // //                 print("Broadcaster user");
// // //               },
// // //             )
// // //           : _engine
// // //               .setClientRole(
// // //               ClientRole.Audience,
// // //             )
// // //               .then(
// // //               (value) {
// // //                 print("Audience user");
// // //               },
// // //             );
// // //     });
// // //   }

// // //   static StreamTransformer transformer<T>(
// // //           T Function(Map<String, dynamic> json) fromJson) =>
// // //       StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
// // //         handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
// // //           final snaps = data.docs.map((doc) => doc.data()).toList();
// // //           final users = snaps.map((json) => fromJson(json)).toList();

// // //           sink.add(users);
// // //         },
// // //       );

// // //   Future<Widget> _userMicItem() async {
// // //     return Container(
// // //       child: Column(
// // //         children: [
// // //           Container(
// // //             padding: const EdgeInsets.all(16.0),
// // //             decoration: BoxDecoration(
// // //                 color: Colors.grey,
// // //                 shape: BoxShape.circle,
// // //                 border: Border.all(width: 2, color: kPrimaryColor)),
// // //             child: Icon(
// // //               Icons.mic,
// // //               color: Colors.white,
// // //               size: 28,
// // //             ),
// // //           ),
// // //           2.height,
// // //           Text(
// // //             "userName",
// // //             style: secondaryTextStyle(
// // //               color: Colors.white,
// // //             ),
// // //           )
// // //         ],
// // //       ),
// // //     );
// // //   }

// // //   Future<bool> _closeRoom() async {
// // //     await CommonFunctions.showAlertWithTwoActions(
// // //         widget.roomId, context, "خروج", "هل تريد الخروج من الغرفة؟", () async {
// // //       // check if this user hold mic or not first
// // //       // var existingItem = _micUsersList.firstWhere(
// // //       //     (itemToCheck) =>
// // //       //         itemToCheck.userId == PreferencesServices.getString(ID_KEY),
// // //       //     orElse: () => null);
// // //       // if (existingItem != null) {
// // //       //   // user already holds mic before
// // //       //   print(existingItem.micNumber);
// // //       //   print(existingItem.userName);
// // //       //   // leave mic
// // //       //   existingItem.userName = null;
// // //       //   existingItem.userId = null;
// // //       //   existingItem.micNumber = existingItem.micNumber;
// // //       //   existingItem.micStatus = false;
// // //       //   finish(context);
// // //       //   // _updateMicsToFirebase(existingItem.micNumber, existingItem);
// // //       // } else {
// // //       {
// // //         finish(context);
// // //       }

// // //       finish(
// // //         context,
// // //       );
// // //     });
// // //     return true;
// // //   }

// // //   void _addMicsToFirebase(String roomID) async {
// // //     // await _firestoreInstance.collection('roomUsers')
// // //     //     .doc(roomID).collection(roomID).doc().delete();
// // //     List<UserMicModel> _micsList = [];

// // //     _micsList.add(UserMicModel(
// // //         id: null,
// // //         userId: null,
// // //         userName: null,
// // //         micNumber: 0,
// // //         micStatus: false));
// // //     _micsList.add(UserMicModel(
// // //         id: null,
// // //         userId: null,
// // //         userName: null,
// // //         micNumber: 1,
// // //         micStatus: false));
// // //     _micsList.add(UserMicModel(
// // //         id: null,
// // //         userId: null,
// // //         userName: null,
// // //         micNumber: 2,
// // //         micStatus: false));
// // //     _micsList.add(UserMicModel(
// // //         id: null,
// // //         userId: null,
// // //         userName: null,
// // //         micNumber: 3,
// // //         micStatus: false));
// // //     _micsList.add(UserMicModel(
// // //         id: null,
// // //         userId: null,
// // //         userName: null,
// // //         micNumber: 4,
// // //         micStatus: false));
// // //     CollectionReference _collectionRef = FirebaseFirestore.instance
// // //         .collection('roomUsers')
// // //         .doc(roomID)
// // //         .collection(roomID);
// // //     await _collectionRef
// // //         .doc(_micsList[0].micNumber.toString())
// // //         .set(_micsList[0].toJson());
// // //     await _collectionRef
// // //         .doc(_micsList[1].micNumber.toString())
// // //         .set(_micsList[1].toJson());
// // //     await _collectionRef
// // //         .doc(_micsList[2].micNumber.toString())
// // //         .set(_micsList[2].toJson());
// // //     await _collectionRef
// // //         .doc(_micsList[3].micNumber.toString())
// // //         .set(_micsList[3].toJson());
// // //     await _collectionRef
// // //         .doc(_micsList[4].micNumber.toString())
// // //         .set(_micsList[4].toJson());
// // //     _micsList.forEach((element) async {
// // //       await _collectionRef
// // //           .doc("${_micsList.indexOf(element)}")
// // //           .set(element.toJson());
// // //     });
// // //   }
// // // }

// import 'dart:async';

// import 'package:agora_rtc_engine/rtc_engine.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/common_functions.dart';
// import 'package:project/models/room_data_model.dart';
// import 'package:project/models/room_user_model.dart';
// import 'package:project/models/user_mic_model.dart';
// import 'package:project/utils/common_functions.dart';
// import 'package:project/utils/constants.dart';
// import 'package:project/utils/images.dart';
// import 'package:project/utils/preferences_services.dart';
// import 'package:nb_utils/nb_utils.dart';

// import 'components/mic_click_dialog.dart';

// class DetailsScreen extends StatefulWidget {
//   final String roomId;
//   final String roomName;
//   final String roomDesc;
//   final String roomOwnerId;

//   DetailsScreen(
//       {Key key, this.roomId, this.roomName, this.roomDesc, this.roomOwnerId})
//       : super(key: key);

//   @override
//   _DetailsScreenState createState() => _DetailsScreenState();
// }

// class _DetailsScreenState extends State<DetailsScreen> {
//   TextEditingController _messageController = TextEditingController();

// //  final controller = Get.put(DetailsController());

//   static final _users = <int>[];
//   final _infoStrings = <String>[];
//   bool muted = false;
//   RtcEngine _engine;
//   bool _isSpeaking = false;

//   bool get isSpeaking => _isSpeaking;
//   bool _isLoadingMics = true;

//   // for chat
//   String peerAvatar;
//   List<QueryDocumentSnapshot> listMessage = new List.from([]);
//   List<QueryDocumentSnapshot> roomUsersList = new List.from([]);
//   List<UserMicModel> _micUsersList = [];

//   int limit = 20;
//   int _roomUsersCount = 0;
//   String groupChatId = "";
//   String id;
//   String roomID = "";

//   bool isLoading = false;
//   bool isShowSticker = false;
//   String imageUrl = "";
//   final ScrollController listScrollController = ScrollController();
//   final FocusNode focusNode = FocusNode();
//   final _firestoreInstance = FirebaseFirestore.instance;
//   bool _isMicHold = false;
//   bool _isRoomOnFirebase = false;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     readLocal();
//     initialize();
//     // _addMicsToFirebase();
//     // getRoomUsers();
//     print("roomId: $roomID");
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     // _users.clear();
//     // destroy sdk
//     // _engine.leaveChannel();
//     print("oncloseeeeee");
//     // _engine.destroy();
//     super.dispose();
//   }

//   Future<void> initialize() async {
//     // check room found or not at first
//     await checkRoomFoundOrNot();
//     // initialize agora
//     // await _initAgoraRtcEngine();
//     // _addAgoraEventHandlers();
//     // await _engine.joinChannel(
//     //     "00645f4567598af4f32afca701cccd0cf2dIADRIb4LxYD/WX4B1uQnZIJqrURDf6xrB/V2mFU7a+SDTwnn9jMAAAAAEAD+bihbcUpCYQEAAQCfyEJh",
//     //     // "naoumaRoom",
//     //     "${widget.roomName}",
//     //     null,
//     //     0);
//   }

//   Future<void> _initAgoraRtcEngine() async {
//     if (AppId.isEmpty) {
//       setState(() {
//         _infoStrings.add(
//           'APP_ID missing, please provide your APP_ID in settings.dart',
//         );
//         _infoStrings.add('Agora Engine is not starting');
//       });
//       return;
//     }
//     _engine = await RtcEngine.create(AppId);
//     await _engine.enableAudio();
//     await _engine.setChannelProfile(ChannelProfile.LiveBroadcasting);
//     // if (PreferencesServices.getString(ID_KEY) == widget.roomOwnerId) {
//     //   await _engine.setClientRole(ClientRole.Broadcaster);
//     // } else {
//     //   await _engine.setClientRole(ClientRole.Audience);
//     // }
//   }

//   void _addAgoraEventHandlers() {
//     _engine.setEventHandler(RtcEngineEventHandler(
//       error: (code) {
//         setState(() {
//           print('onError: $code');
//         });
//       },
//       joinChannelSuccess: (channel, uid, elapsed) {
//         print('onJoinChannel: $channel, uid: $uid');
//         print("userJoinChannel");
//         setState(() {
//           _roomUsersCount++;
//         });
//       },
//       leaveChannel: (stats) {
//         setState(() {
//           print('onLeaveChannel');
//           // _users.clear();
//           _roomUsersCount > 0 ? _roomUsersCount-- : null;
//         });
//       },
//       userJoined: (uid, elapsed) {
//         print('userJoined: $uid');
//         setState(() {
//           _users.add(uid);
//           // _roomUsersCount++;
//         });
//       },
//       audioVolumeIndication: (speakers, int volume) {
//         print("isSpeak: ${speakers.any((speaker) => speaker.volume > 0)}");
//         if (speakers.any((speaker) => speaker.volume > 0)) {
//           setState(() {
//             _isSpeaking = true;
//           });
//         } else {
//           setState(() {
//             _isSpeaking = false;
//           });
//         }
//         // for(var speaker in speakers){
//         //   for(var user in _users) {
//         //     if (speaker.volume > 0 && speaker.uid == user) {
//         //       // user is speaking now...
//         //       // update user speaking ui
//         //     }
//         //   }
//         // }
//       },
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final size = MediaQuery.of(context).size;
//     //controller.roomID = widget.roomData.id;
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: SafeArea(
//           top: false,
//           child: WillPopScope(
//             onWillPop: _closeRoom,
//             child: Scaffold(
//               body: // GetBuilder<DetailsController>(
//                   //     init: Get.find(),
//                   // builder:(controller)=>
//                   Container(
//                 child: Stack(
//                   children: [
//                     Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(
//                                 'https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80'),
//                             fit: BoxFit.cover),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 40.0, horizontal: 8.0),
//                       child: Column(
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                 width: size.width / 2 - 16,
//                                 padding: const EdgeInsets.symmetric(
//                                     vertical: 2.0, horizontal: 6.0),
//                                 decoration: BoxDecoration(
//                                   color: Colors.black26,
//                                   borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(16.0),
//                                       bottomLeft: Radius.circular(16.0)),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     SizedBox(
//                                       width: 4.0,
//                                     ),
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             widget.roomName,
//                                             maxLines: 1,
//                                             style: theme.textTheme.bodyText1
//                                                 .copyWith(
//                                                     color: Colors.white,
//                                                     fontSize: 17),
//                                           ),
//                                           Text(
//                                             "ID: 99",
//                                             maxLines: 1,
//                                             style: theme.textTheme.bodyText2
//                                                 .copyWith(
//                                                     color: Colors.white,
//                                                     fontSize: 15),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Icon(
//                                       Icons.favorite_border,
//                                       color: Colors.white,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Row(
//                                 children: [
//                                   IconButton(
//                                       icon: Icon(Icons.ios_share,
//                                           color: Colors.white),
//                                       onPressed: () {
//                                         print("share btn clicked");
//                                       }),
//                                   GestureDetector(
//                                       child: Icon(Icons.close,
//                                           color: Colors.white),
//                                       onTap: () {
//                                         _closeRoom();
//                                       })
//                                 ],
//                               )
//                             ],
//                           ),
//                           16.height,
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   width: 150,
//                                   padding: const EdgeInsets.symmetric(
//                                       vertical: 2.0, horizontal: 6.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.black26,
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(16.0),
//                                         bottomLeft: Radius.circular(16.0)),
//                                   ),
//                                   child: Row(
//                                     children: [
//                                       Icon(Icons.monetization_on_rounded,
//                                           color: Colors.orange),
//                                       SizedBox(
//                                         width: 6.0,
//                                       ),
//                                       Expanded(
//                                         child: Text(
//                                           widget.roomName,
//                                           maxLines: 1,
//                                           style: theme.textTheme.bodyText1
//                                               .copyWith(
//                                                   color: Colors.white,
//                                                   fontSize: 17),
//                                         ),
//                                       ),
//                                       Icon(
//                                         Icons.arrow_back_ios_rounded,
//                                         color: Colors.grey,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   children: [
//                                     Image.asset(
//                                       kDefaultProfileImage,
//                                       width: 36,
//                                       height: 36,
//                                     ),
//                                     16.width,
//                                     Text(
//                                       "$_roomUsersCount",
//                                       style: theme.textTheme.bodyText1.copyWith(
//                                           color: Colors.white, fontSize: 18),
//                                     ),
//                                     Icon(Icons.person_outline,
//                                         color: Colors.white),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           ),
//                           16.height,
//                           // Wrap(
//                           //   spacing: 16.0,
//                           //   runSpacing: 16.0,
//                           //   children: [
//                           //     _personInRoom(1, "1"),
//                           //     _personInRoom(2, "2"),
//                           //     _personInRoom(3, "3"),
//                           //     _personInRoom(4, "4"),
//                           //     _personInRoom(5, "5"),
//                           //   ],
//                           // ),
//                           Container(
//                             padding: const EdgeInsets.all(6.0),
//                             child: Stack(
//                               // fit: StackFit.expand,
//                               // overflow: Overflow.visible,
//                               children: [
//                                 Container(
//                                   width: double.infinity,
//                                   // margin: const EdgeInsets.only(top:10, right: 60),
//                                   child: _roomMicsLayout(),
//                                 ),
//                                 // Positioned(
//                                 //   top: 0,
//                                 //   right: 0,
//                                 //   child: _isMicHold?Container(): Container(
//                                 //   // width: 68,
//                                 //   // height: 68,
//                                 //     padding: const EdgeInsets.all(6.0),
//                                 //   decoration: BoxDecoration(
//                                 //     shape: BoxShape.circle,
//                                 //     color: Colors.white,
//                                 //     border: Border.all(color: kPrimaryColor.withOpacity(0.4), width: 2.0),
//                                 //   ),
//                                 //   child: Column(
//                                 //     mainAxisAlignment: MainAxisAlignment.center,
//                                 //     children: [
//                                 //       Icon(Icons.mic,color: kPrimaryColor, size: 28,),
//                                 //       Text("طلب مايك", style: secondaryTextStyle(color: kPrimaryColor, size: 12),)
//                                 //     ],
//                                 //   ),
//                                 // ).onTap(() {
//                                 //
//                                 // }),),
//                               ],
//                             ),
//                           ),
//                           16.height,
//                           Container(
//                             width: double.infinity,
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 4.0, horizontal: 8.0),
//                             decoration: BoxDecoration(
//                               color: Colors.black54,
//                             ),
//                             child: Marquee(
//                               child: Text(
//                                 'Some sample text that takes some space, Some sample text that takes some space. ',
//                                 style: theme.textTheme.bodyText1
//                                     .copyWith(color: Colors.white),
//                               ),
//                               direction: Axis.horizontal,
//                               textDirection: TextDirection.rtl,
//                               pauseDuration: Duration(seconds: 2),
//                               backDuration: Duration(seconds: 2),
//                               animationDuration: Duration(seconds: 6),
//                               directionMarguee: DirectionMarguee.oneDirection,
//                             ),
//                           ),
//                           buildListMessage(size),
//                         ],
//                       ),
//                     ),
//                     Positioned(
//                       bottom: 10,
//                       left: 10,
//                       right: 10,
//                       child: Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.black45,
//                             ),
//                             child: Icon(
//                               Icons.mic_external_on,
//                               color: Colors.white,
//                             ),
//                           ),
//                           8.width,
//                           Expanded(
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 6, vertical: 2.0),
//                               decoration: BoxDecoration(
//                                 color: Colors.black26,
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(16.0)),
//                               ),
//                               child: TextField(
//                                 keyboardType: TextInputType.text,
//                                 controller: _messageController,
//                                 style: TextStyle(color: Colors.white),
//                                 decoration: InputDecoration.collapsed(
//                                   hintText: "رسالتك...",
//                                   hintStyle: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                           8.width,
//                           Container(
//                             padding: const EdgeInsets.all(5.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.orange,
//                             ),
//                             child: Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                           ).onTap(() {
//                             onSendMessage(_messageController.text, 0);
//                           }),
//                           8.width,
//                           Container(
//                             padding: const EdgeInsets.all(6.0),
//                             decoration: BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.black45,
//                             ),
//                             child: Icon(
//                               Icons.mic_external_on,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           )),
//     );
//   }

//   checkRoomFoundOrNot() async {
//     DocumentSnapshot ds =
//         await _firestoreInstance.collection("roomUsers").doc(roomID).get();
//     this.setState(() {
//       _isRoomOnFirebase = ds.exists;
//       print("_isRoomOnFirebase: $_isRoomOnFirebase");
//     });
//     // if room not exist add it to firebase
//     _isRoomOnFirebase ? null : _addMicsToFirebase(roomID);
//   }

//   Widget _personInRoom(int index, UserMicModel micModel) {
//     print("$index");
//     print("${micModel.userName}");
//     return Expanded(
//       child: Container(
//         child: Column(
//           children: [
//             micModel.micStatus == true
//                 ? Stack(
//                     children: [
//                       Container(
//                           width: 70,
//                           child: Image.network(
//                             hasFrame,
//                           )), // Back image
//                       Padding(
//                         padding: const EdgeInsets.all(9.0),
//                         child: Container(
//                           width: 50,
//                           child: Image.asset(
//                             "assets/images/Profile Image.png",
//                             // fit: BoxFit.cover,
//                           ),
//                         ),
//                       )
//                     ],
//                   )
//                 : Container(
//                     padding: const EdgeInsets.all(6.0),
//                     decoration: BoxDecoration(
//                         color: Colors.grey,
//                         shape: BoxShape.circle,
//                         border: Border.all(width: 2, color: kPrimaryColor)),
//                     child: Icon(
//                       micModel.isLocked != null
//                           ? micModel.isLocked
//                               ? Icons.lock
//                               : Icons.mic
//                           : Icons.mic,
//                       color: Colors.white,
//                       size: 32,
//                     ),
//                   ),
//             2.height,
//             Text(
//               micModel.isLocked != null && micModel.isLocked
//                   ? "مقفل"
//                   : micModel.micStatus
//                       ? micModel.userName.length > 7
//                           ? ".${micModel.userName}"
//                           : micModel.userName
//                       : "${index + 1}",
//               overflow: TextOverflow.ellipsis,
//               style: secondaryTextStyle(size: 12, color: black),
//             ),
//           ],
//         ),
//       ).onTap(() {
//         if (!micModel.micStatus &&
//             !micModel.isLocked &&
//             micModel.userId == null &&
//             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
//           // Iam room owner and mic is empty
//           print("Iam owner and mic is empty.");
//           var existingItem = _micUsersList.firstWhere(
//               (itemToCheck) =>
//                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
//               orElse: () => null);
//           if (existingItem != null) {
//             // user already holds mic before
//             print(existingItem.micNumber);
//             print(existingItem.userName);
//             print("take other mic");
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return MicClickDialog(
//                     takeMicFunction: () {
//                       print("clicked take");
//                       print("clicked index: $index");
//                       // leave old mic
//                       existingItem.id = null;
//                       existingItem.userName = null;
//                       existingItem.userId = null;
//                       existingItem.micNumber = existingItem.micNumber;
//                       existingItem.micStatus = false;
//                       _updateMicsToFirebase(
//                           existingItem.micNumber, existingItem);
//                       print("existname: ${existingItem.userName}");
//                       print("existuserId: ${existingItem.userId}");
//                       print("existmicNumber: ${existingItem.micNumber}");
//                       print("existid: ${existingItem.micNumber}");
//                       print("existmicStatus: ${existingItem.micStatus}");

//                       // go to new mic
//                       micModel.id = index.toString();
//                       micModel.userName =
//                           PreferencesServices.getString(Name_KEY);
//                       micModel.userId = PreferencesServices.getString(ID_KEY);
//                       micModel.micNumber = index;
//                       micModel.micStatus = true;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       finish(context);
//                       _updateMicsToFirebase(index, micModel);
//                     },
//                     leaveMicFunction: () {},
//                     lockMicFunction: () {
//                       // lock mic
//                       micModel.id = null;
//                       micModel.userName = null;
//                       micModel.userId = null;
//                       micModel.micNumber = index;
//                       micModel.micStatus = false;
//                       micModel.isLocked = true;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     unLockMicFunction: () {},
//                     showTakeMic: true,
//                     showLeaveMic: false,
//                     showLockMic: true,
//                     micIsLocked: false,
//                   );
//                 });
//           } else {
//             print("not take other mic");
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return MicClickDialog(
//                     takeMicFunction: () {
//                       // go to new mic
//                       micModel.id = index.toString();
//                       micModel.userName =
//                           PreferencesServices.getString(Name_KEY);
//                       micModel.userId = PreferencesServices.getString(ID_KEY);
//                       micModel.micNumber = index;
//                       micModel.micStatus = true;
//                       micModel.isLocked = false;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     leaveMicFunction: () {},
//                     lockMicFunction: () {
//                       // lock mic
//                       micModel.id = null;
//                       micModel.userName = null;
//                       micModel.userId = null;
//                       micModel.micNumber = index;
//                       micModel.micStatus = false;
//                       micModel.isLocked = true;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     unLockMicFunction: () {},
//                     showTakeMic: true,
//                     showLeaveMic: false,
//                     showLockMic: true,
//                     micIsLocked: false,
//                   );
//                 });
//           }
//         } else if (!micModel.micStatus &&
//             micModel.isLocked &&
//             micModel.userId == null &&
//             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
//           // Iam room owner and mic is locked
//           print("Iam room owner and mic is locked...");
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return MicClickDialog(
//                   takeMicFunction: () {},
//                   leaveMicFunction: () {},
//                   unLockMicFunction: () {
//                     print("unLock Mic index: $index");
//                     micModel.id = null;
//                     micModel.userName = null;
//                     micModel.userId = null;
//                     micModel.micNumber = index;
//                     micModel.micStatus = false;
//                     micModel.isLocked = false;
//                     print("name: ${micModel.userName}");
//                     print("userId: ${micModel.userId}");
//                     print("micNumber: ${micModel.micNumber}");
//                     print("id: ${micModel.micNumber}");
//                     print("micStatus: ${micModel.micStatus}");
//                     _updateMicsToFirebase(index, micModel);
//                     finish(context);
//                   },
//                   showTakeMic: false,
//                   showLeaveMic: false,
//                   showLockMic: false,
//                   micIsLocked: true,
//                 );
//               });
//         } else if (micModel.micStatus &&
//             !micModel.isLocked &&
//             micModel.userId == PreferencesServices.getString(ID_KEY) &&
//             micModel.roomOwnerId == PreferencesServices.getString(ID_KEY)) {
//           // Iam room owner and mic is locked
//           print("Iam room owner and mic is taken by me...");
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return MicClickDialog(
//                   takeMicFunction: () {},
//                   leaveMicFunction: () {
//                     print("unLock Mic index: $index");
//                     micModel.id = null;
//                     micModel.userName = null;
//                     micModel.userId = null;
//                     micModel.micNumber = index;
//                     micModel.micStatus = false;
//                     micModel.isLocked = false;
//                     print("name: ${micModel.userName}");
//                     print("userId: ${micModel.userId}");
//                     print("micNumber: ${micModel.micNumber}");
//                     print("id: ${micModel.micNumber}");
//                     print("micStatus: ${micModel.micStatus}");
//                     _updateMicsToFirebase(index, micModel);
//                     finish(context);
//                   },
//                   unLockMicFunction: () {},
//                   showTakeMic: false,
//                   showLeaveMic: true,
//                   showLockMic: false,
//                   micIsLocked: false,
//                 );
//               });
//         } else if (!micModel.micStatus &&
//             !micModel.isLocked &&
//             micModel.userId == null &&
//             micModel.roomOwnerId != PreferencesServices.getString(ID_KEY)) {
//           // Iam not room owner and mic is locked
//           print("Iam not room owner and mic is taken by me...");
//           var existingItem = _micUsersList.firstWhere(
//               (itemToCheck) =>
//                   itemToCheck.userId == PreferencesServices.getString(ID_KEY),
//               orElse: () => null);
//           if (existingItem != null) {
//             // user already holds mic before
//             print(existingItem.micNumber);
//             print(existingItem.userName);
//             print("take other mic");
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return MicClickDialog(
//                     takeMicFunction: () {
//                       print("clicked take");
//                       print("clicked index: $index");
//                       // leave old mic
//                       existingItem.id = null;
//                       existingItem.userName = null;
//                       existingItem.userId = null;
//                       existingItem.micNumber = existingItem.micNumber;
//                       existingItem.micStatus = false;
//                       _updateMicsToFirebase(
//                           existingItem.micNumber, existingItem);
//                       print("existname: ${existingItem.userName}");
//                       print("existuserId: ${existingItem.userId}");
//                       print("existmicNumber: ${existingItem.micNumber}");
//                       print("existid: ${existingItem.micNumber}");
//                       print("existmicStatus: ${existingItem.micStatus}");

//                       // go to new mic
//                       micModel.id = index.toString();
//                       micModel.userName =
//                           PreferencesServices.getString(Name_KEY);
//                       micModel.userId = PreferencesServices.getString(ID_KEY);
//                       micModel.micNumber = index;
//                       micModel.micStatus = true;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       // update firebase
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     leaveMicFunction: () {
//                       print("leave index: $index");
//                       micModel.id = null;
//                       micModel.userName = null;
//                       micModel.userId = null;
//                       micModel.micNumber = index;
//                       micModel.micStatus = false;
//                       micModel.isLocked = false;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       // update firebase
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     lockMicFunction: () {},
//                     unLockMicFunction: () {},
//                     showTakeMic: true,
//                     showLeaveMic: true,
//                     showLockMic: false,
//                     micIsLocked: false,
//                   );
//                 });
//           } else {
//             print("not take other mic");
//             showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return MicClickDialog(
//                     takeMicFunction: () {
//                       // go to new mic
//                       micModel.id = index.toString();
//                       micModel.userName = username;
//                       micModel.userId = PreferencesServices.getString(ID_KEY);
//                       micModel.micNumber = index;
//                       micModel.micStatus = true;
//                       micModel.isLocked = false;
//                       print("name: ${micModel.userName}");
//                       print("userId: ${micModel.userId}");
//                       print("micNumber: ${micModel.micNumber}");
//                       print("id: ${micModel.micNumber}");
//                       print("micStatus: ${micModel.micStatus}");
//                       _updateMicsToFirebase(index, micModel);
//                       finish(context);
//                     },
//                     leaveMicFunction: () {
//                       finish(context);
//                     },
//                     lockMicFunction: () {},
//                     unLockMicFunction: () {},
//                     showTakeMic: true,
//                     showLeaveMic: true,
//                     showLockMic: false,
//                     micIsLocked: false,
//                   );
//                 });
//           }
//         } else if (micModel.micStatus &&
//             !micModel.isLocked &&
//             micModel.userId != null &&
//             micModel.userId == PreferencesServices.getString(ID_KEY)) {
//           // mic taken by me...
//           print("mic taken by me...");
//           showDialog(
//               context: context,
//               builder: (BuildContext context) {
//                 return MicClickDialog(
//                   takeMicFunction: () {},
//                   leaveMicFunction: () {
//                     print("leave index: $index");
//                     micModel.id = null;
//                     micModel.userName = null;
//                     micModel.userId = null;
//                     micModel.micNumber = index;
//                     micModel.micStatus = false;
//                     print("name: ${micModel.userName}");
//                     print("userId: ${micModel.userId}");
//                     print("micNumber: ${micModel.micNumber}");
//                     print("id: ${micModel.micNumber}");
//                     print("micStatus: ${micModel.micStatus}");
//                     finish(context);
//                     _updateMicsToFirebase(index, micModel);
//                   },
//                   lockMicFunction: () {},
//                   unLockMicFunction: () {},
//                   showLockMic: false,
//                   micIsLocked: false,
//                   showTakeMic: false,
//                   showLeaveMic: true,
//                 );
//               });
//         } else if (micModel.micStatus &&
//             !micModel.isLocked &&
//             micModel.userId != null &&
//             micModel.userId != PreferencesServices.getString(ID_KEY)) {
//           // taken by other one
//           CommonFunctions.showToast("Mic already taken", Colors.red);
//         } else if (!micModel.micStatus &&
//             micModel.isLocked &&
//             micModel.userId != null &&
//             micModel.userId != PreferencesServices.getString(ID_KEY)) {
//           // Mic is locked
//           CommonFunctions.showToast("Mic is locked", Colors.red);
//         }
//         // else{
//         //   print("_micUsersList: ${_micUsersList.length}");
//         //   //find existing item per link criteria
//         //           var existingItem = _micUsersList.firstWhere((itemToCheck) => itemToCheck.userId == PreferencesServices.getString(ID_KEY), orElse: () => null);
//         //           if(existingItem != null){
//         //             // user already holds mic before
//         //             print(existingItem.micNumber);
//         //             print(existingItem.userName);
//         //             print("take other mic");
//         //             showDialog(context: context,
//         //                 builder: (BuildContext context){
//         //                   return MicClickDialog(takeMicFunction: (){
//         //                     print("clicked take");
//         //                     print("clicked index: $index");
//         //                     // leave old mic
//         //                     existingItem.id = null;
//         //                     existingItem.userName = null;
//         //                     existingItem.userId = null;
//         //                     existingItem.micNumber = existingItem.micNumber;
//         //                     existingItem.micStatus = false;
//         //                     _updateMicsToFirebase(existingItem.micNumber, existingItem);
//         //                     print("existname: ${existingItem.userName}");
//         //                     print("existuserId: ${existingItem.userId}");
//         //                     print("existmicNumber: ${existingItem.micNumber}");
//         //                     print("existid: ${existingItem.micNumber}");
//         //                     print("existmicStatus: ${existingItem.micStatus}");
//         //
//         //                     // go to new mic
//         //                     micModel.id = index.toString();
//         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
//         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
//         //                     micModel.micNumber = index;
//         //                     micModel.micStatus = true;
//         //                     print("name: ${micModel.userName}");
//         //                     print("userId: ${micModel.userId}");
//         //                     print("micNumber: ${micModel.micNumber}");
//         //                     print("id: ${micModel.micNumber}");
//         //                     print("micStatus: ${micModel.micStatus}");
//         //                     finish(context);
//         //                     _updateMicsToFirebase(index, micModel);
//         //                   }, leaveMicFunction: (){
//         //                     print("leave index: $index");
//         //                     finish(context);
//         //                   });
//         //                 }
//         //             );
//         //           } else{
//         //             print("not take other mic");
//         //             showDialog(context: context,
//         //                 builder: (BuildContext context){
//         //                   return MicClickDialog(takeMicFunction: (){
//         //                     print("clicked take");
//         //                     print("clicked index: $index");
//         //                     micModel.id = "$index";
//         //                     micModel.userName = PreferencesServices.getString(Name_KEY);
//         //                     micModel.userId = PreferencesServices.getString(ID_KEY);
//         //                     micModel.micNumber = index;
//         //                     micModel.micStatus = true;
//         //                     print("name: ${micModel.userName}");
//         //                     print("userId: ${micModel.userId}");
//         //                     print("micNumber: ${micModel.micNumber}");
//         //                     print("id: ${micModel.micNumber}");
//         //                     print("micStatus: ${micModel.micStatus}");
//         //                     finish(context);
//         //                     _updateMicsToFirebase(index, micModel);
//         //
//         //                   }, leaveMicFunction: (){
//         //                     print("leave index: $index");
//         //                     finish(context);
//         //                   });
//         //                 }
//         //             );
//         //           }
//         // }
//       }),
//     );
//   }

//   void onSendMessage(String content, int type) {
//     // type: 0 = text, 1 = image, 2 = sticker
//     if (content.trim() != '') {
//       _messageController.clear();

//       var documentReference = FirebaseFirestore.instance
//           .collection('messages')
//           .doc(groupChatId)
//           .collection(groupChatId)
//           .doc(DateTime.now().millisecondsSinceEpoch.toString());

//       FirebaseFirestore.instance.runTransaction((transaction) async {
//         transaction.set(
//           documentReference,
//           {
//             'idFrom': id,
//             'idTo': widget.roomId,
//             'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
//             'content': content,
//             'type': type
//           },
//         );
//       });
//       listScrollController.animateTo(0.0,
//           duration: Duration(milliseconds: 300), curve: Curves.easeOut);
//     } else {
//       CommonFunctions.showToast('Nothing to send', Colors.red);
//     }
//   }

//   void onFocusChange() {
//     if (focusNode.hasFocus) {
//       // Hide sticker when keyboard appear
//       setState(() {
//         isShowSticker = false;
//       });
//     }
//   }

//   readLocal() async {
//     id = PreferencesServices.getString(ID_KEY);
//     if (id.hashCode <= widget.roomId.hashCode) {
//       setState(() {
//         groupChatId = '${widget.roomId}';
//         roomID = widget.roomId;
//       });
//     } else {
//       setState(() {
//         groupChatId = '${widget.roomId}';
//         roomID = widget.roomId;
//       });
//     }
//   }

//   Widget buildListMessage(Size size) {
//     return Flexible(
//       child: groupChatId.isNotEmpty
//           ? StreamBuilder<QuerySnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('messages')
//                   .doc(groupChatId)
//                   .collection(groupChatId)
//                   .orderBy('timestamp', descending: true)
//                   .limit(limit)
//                   .snapshots(),
//               builder: (BuildContext context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 print("messaegs: ${snapshot.toString()}");
//                 if (snapshot.hasData) {
//                   listMessage.addAll(snapshot.data.docs);
//                   return ListView.builder(
//                     padding: EdgeInsets.all(10.0),
//                     itemBuilder: (context, index) =>
//                         buildItem(index, snapshot.data?.docs[index], size),
//                     itemCount: snapshot.data?.docs.length,
//                     reverse: true,
//                     controller: listScrollController,
//                   );
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
//                     ),
//                   );
//                 }
//               },
//             )
//           : Center(
//               child: CircularProgressIndicator(
//                 valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
//               ),
//             ),
//     );
//   }

//   Widget buildItem(int index, DocumentSnapshot document, Size size) {
//     if (document != null) {
//       // Right (my message)
//       return document.get('type') == 0
//           // Text
//           ? Container(
//               width: size.width * 0.7,
//               padding: const EdgeInsets.all(6.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: 36,
//                     height: 36,
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                       child: Image.asset(
//                         kDefaultProfileImage,
//                         width: 36,
//                         height: 36,
//                       ),
//                     ),
//                   ),
//                   10.width,
//                   Expanded(
//                     child: Container(
//                       child: Text(
//                         document.get('content'),
//                         style: secondaryTextStyle(color: Colors.white),
//                         maxLines: 2,
//                         textAlign: TextAlign.start,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                       color: Colors.transparent,
//                       // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
//                       // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : document.get('type') == 1
//               // Image
//               ? Container(
//                   child: OutlinedButton(
//                     child: Material(
//                       child: Image.network(
//                         document.get("content"),
//                         loadingBuilder: (BuildContext context, Widget child,
//                             ImageChunkEvent loadingProgress) {
//                           if (loadingProgress == null) return child;
//                           return Container(
//                             decoration: BoxDecoration(
//                               color: Colors.grey.shade600,
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8.0),
//                               ),
//                             ),
//                             width: 200.0,
//                             height: 200.0,
//                             child: Center(
//                               child: CircularProgressIndicator(
//                                 value: loadingProgress.expectedTotalBytes !=
//                                             null &&
//                                         loadingProgress.expectedTotalBytes !=
//                                             null
//                                     ? loadingProgress.cumulativeBytesLoaded /
//                                         loadingProgress.expectedTotalBytes
//                                     : null,
//                               ),
//                             ),
//                           );
//                         },
//                         errorBuilder: (context, object, stackTrace) {
//                           return Material(
//                             child: Image.asset(
//                               'images/img_not_available.jpeg',
//                               width: 200.0,
//                               height: 200.0,
//                               fit: BoxFit.cover,
//                             ),
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(8.0),
//                             ),
//                             clipBehavior: Clip.hardEdge,
//                           );
//                         },
//                         width: 200.0,
//                         height: 200.0,
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
//                       clipBehavior: Clip.hardEdge,
//                     ),
//                     onPressed: () {},
//                     style: ButtonStyle(
//                         padding: MaterialStateProperty.all<EdgeInsets>(
//                             EdgeInsets.all(0))),
//                   ),
//                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//                 )
//               // Sticker
//               : Container(
//                   child: Image.asset(
//                     'images/${document.get('content')}.gif',
//                     width: 100.0,
//                     height: 100.0,
//                     fit: BoxFit.cover,
//                   ),
//                   // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
//                 );
//     } else {
//       return SizedBox.shrink();
//     }
//   }

//   Future getRoomUsers() async {
//     _isLoadingMics = true;
//     var collection = FirebaseFirestore.instance.collection('roomUsers');
//     var docSnapshot = await collection.doc(roomID).collection(roomID).get();
//     // Map<String, dynamic> data = docSnapshot.docs;
//     // QuerySnapshot querySnapshot = await _firestoreInstance.collection('roomUsers').doc(roomID).get().;
//     // // // Get data from docs and convert map to List
//     if (collection != null && docSnapshot != null) {
//       // docSnapshot.docs.length > 0 ? _addMicsToFirebase() : null;
//       roomUsersList = docSnapshot.docs;
//       setState(() {
//         _isLoadingMics = false;
//       });
//     }
//     // // roomUsersList = querySnapshot.docs.map((doc) => doc.data()).toList();
//     // setState(() {
//     //   _usersCount = roomUsersList.length;
//     // });
//     // print(roomUsersList.toString());
//     // print("userslst: ${roomUsersList.length}");
//     // roomUsersList.forEach((querySnapshot) {
//     //   Map<String, dynamic> jsonData = querySnapshot.data();
//     //   UserMicModel userMicModel = UserMicModel.fromJson(jsonData);
//     //   print(userMicModel.userId);
//     //   print("users: ${userMicModel.userName}");
//     //   print("users: ${querySnapshot.data()['userName']}");
//     // });
//     // _firestore.collection('favorites').where('user_id', isEqualTo: uid).getDocuments()
//     //     .then((querySnap) {
//     //   querySnap.documents.forEach((document) {
//     //     print(document.data);
//     //
//     //     Map<String, dynamic> json = document.data; //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
//     //     Album album = new Album.fromJson(json['favorite_albums'][0]); //Throws the type exception
//     //   });
//     // })
//     //     .catchError((error) {
//     //   print(error);
//     // });
//   }

//   Widget _roomMicsLayout() {
//     Stream<List<UserMicModel>> _stream = _firestoreInstance
//         .collection('roomUsers')
//         .doc(widget.roomId)
//         .collection(widget.roomId)
//         .snapshots()
//         .transform(transformer((json) => UserMicModel.fromJson(json)));
//     return StreamBuilder<List<UserMicModel>>(
//         stream: _stream,
//         builder:
//             (BuildContext context, AsyncSnapshot<List<UserMicModel>> snapshot) {
//           if (snapshot.hasData && snapshot.data.length > 0) {
//             print(":has data");
//             _micUsersList = snapshot.data;
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3.0),
//               child: Column(children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(5, (index) {
//                     // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
//                     return _personInRoom(
//                       index,
//                       snapshot.data[index],
//                     );
//                   }).toList(),
//                   // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(5, (index) {
//                     // index = 5;
//                     // snapshot.data[index].userId!=null?_roomUsersCount++:print("userNull: $_roomUsersCount");
//                     return _personInRoom(
//                       index + 5,
//                       snapshot.data[index + 5],
//                     );
//                   }).toList(),
//                   // children: snapshot.data.map((item) => _personInRoom(snapshot.data.indexOf(item), item)).toList(),
//                 ),
//               ]),
//               // child: Container(
//               //   height: 100,
//               //   child: ListView.builder(
//               //       scrollDirection: Axis.horizontal,
//               //       // shrinkWrap: true,
//               //       itemCount: 5,
//               //       itemBuilder: (BuildContext context, int index){
//               //     return _personInRoom(index, snapshot.data[index],);
//               //   }),
//               // ),
//             );
//           } else {
//             print("not has data");
//             List<UserMicModel> _micsList = [];

//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 0,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 1,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 2,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 3,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 4,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 5,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 6,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 7,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 8,
//                 micStatus: false,
//                 isLocked: false));
//             _micsList.add(UserMicModel(
//                 id: null,
//                 userId: null,
//                 userName: null,
//                 micNumber: 9,
//                 micStatus: false,
//                 isLocked: false));
//             //  _micsList.add(UserMicModel(
//             // id: null,
//             // userId: null,
//             // userName: null,
//             // micNumber: 8,
//             // micStatus: false,
//             // isLocked: false));
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: Row(
//                 children: [
//                   _personInRoom(
//                     0,
//                     _micsList[0],
//                   ),
//                   _personInRoom(
//                     1,
//                     _micsList[1],
//                   ),
//                   _personInRoom(
//                     2,
//                     _micsList[2],
//                   ),
//                   _personInRoom(
//                     3,
//                     _micsList[3],
//                   ),
//                   _personInRoom(
//                     4,
//                     _micsList[4],
//                   ),
//                   _personInRoom(
//                     5,
//                     _micsList[5],
//                   ),
//                   _personInRoom(
//                     6,
//                     _micsList[6],
//                   ),
//                   _personInRoom(
//                     7,
//                     _micsList[7],
//                   ),
//                   _personInRoom(
//                     8,
//                     _micsList[8],
//                   ),
//                   _personInRoom(
//                     9,
//                     _micsList[9],
//                   ),
//                 ],
//               ),
//             );
//           }
//           return ListView.builder(
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             physics: NeverScrollableScrollPhysics(),
//             padding: EdgeInsets.all(5.0),
//             // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(mainAxisSpacing: 6.0, crossAxisSpacing: 6.0, crossAxisCount: 5),
//             itemBuilder: (context, index) {
//               bool _isThisMic;
//               for (var map in roomUsersList) {
//                 _micUsersList.add(UserMicModel.fromJson(map));
//                 // if (roomUsersList[index].data().containsKey("micNumber")) {
//                 //     if (roomUsersList[index].data()["micNumber"] == "${index +1}") {
//                 //       // your list of map contains key "id" which has value 3
//                 //       // CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
//                 //       // print("id: ${map.data()["userId"]}");
//                 //       setState(() {
//                 //         _isThisMic = true;
//                 //       });
//                 //     }
//                 //   }
//               }
//               return Container(
//                 child: Column(
//                   children: [
//                     Container(
//                       padding: const EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                           color: Colors.grey,
//                           shape: BoxShape.circle,
//                           border: Border.all(width: 1, color: kPrimaryColor)),
//                       child: Icon(
//                         Icons.mic,
//                         color: Colors.white,
//                         size: 28,
//                       ),
//                     ),
//                     2.height,
//                     Text(
//                       roomUsersList[index].data() != null
//                           ? "${roomUsersList[index].data()["userName"]}"
//                           : "${index + 1}",
//                       style: secondaryTextStyle(color: Colors.white, size: 16),
//                     ),
//                   ],
//                 ),
//               ).onTap(() {
//                 print("changeRole: to broadCast");
//                 // for (var map in roomUsersList) {
//                 //   if (map.data().containsKey("micNumber")) {
//                 //     if (map.data()["micNumber"] == "${index +1}") {
//                 //       // your list of map contains key "id" which has value 3
//                 //       CommonFunctions.showToast("لقد قمت بآخذ المايك مسبقا", Colors.red);
//                 //       print("id: ${map.data()["userId"]}");
//                 //       return;
//                 //     }
//                 //   }
//                 // }
//                 _firestoreInstance
//                     .collection('roomUsers')
//                     .doc(roomID)
//                     .collection(roomID)
//                     .add({
//                   'micNumber': "${index + 1}",
//                   'userId': PreferencesServices.getString(ID_KEY),
//                   "userName": PreferencesServices.getString(Name_KEY)
//                 }).then((value) {
//                   setState(() {
//                     // _isMicHold = true;
//                     _roomUsersCount++;
//                     _engine
//                         .setClientRole(
//                           ClientRole.Broadcaster,
//                         )
//                         .then(
//                           (value) {},
//                         );
//                   });
//                 });
//               });
//             },
//             itemCount: 5,
//             controller: listScrollController,
//           );
//         });
//   }

//   void _updateMicsToFirebase(int index, UserMicModel micModel) async {
//     print("inUpdate doc: $index");
//     print("name: ${micModel.userName}");
//     print("id: ${micModel.userId}");
//     CollectionReference _collectionRef = FirebaseFirestore.instance
//         .collection('roomUsers')
//         .doc(roomID)
//         .collection(roomID);
//     await _collectionRef.doc("$index").update({
//       "id": micModel.id,
//       "userId": micModel.userId,
//       "userName": micModel.userName,
//       "micNumber": micModel.micNumber,
//       "micStatus": micModel.micStatus,
//       "isLocked": micModel.isLocked
//     }).catchError((e) {
//       print(e);
//       return;
//     });
//     // setState(() {
//     //   micModel.micStatus
//     //       ? _engine
//     //           .setClientRole(
//     //           ClientRole.Broadcaster,
//     //         )
//     //           .then(
//     //           (value) {
//     //             print("Broadcaster user");
//     //           },
//     //         )
//     //       : _engine
//     //           .setClientRole(
//     //           ClientRole.Audience,
//     //         )
//     //           .then(
//     //           (value) {
//     //             print("Audience user");
//     //           },
//     //         );
//     // });
//   }

//   static StreamTransformer transformer<T>(
//           T Function(Map<String, dynamic> json) fromJson) =>
//       StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
//         handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
//           final snaps = data.docs.map((doc) => doc.data()).toList();
//           final users = snaps.map((json) => fromJson(json)).toList();

//           sink.add(users);
//         },
//       );

//   Future<Widget> _userMicItem() async {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(16.0),
//             decoration: BoxDecoration(
//                 color: Colors.grey,
//                 shape: BoxShape.circle,
//                 border: Border.all(width: 2, color: kPrimaryColor)),
//             child: Icon(
//               Icons.mic,
//               color: Colors.white,
//               size: 28,
//             ),
//           ),
//           2.height,
//           Text(
//             "userName",
//             style: secondaryTextStyle(
//               color: Colors.white,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Future<bool> _closeRoom() async {
//     await CommonFunctions.showAlertWithTwoActions(
//         widget.roomId, context, "خروج", "هل تريد الخروج من الغرفة؟", () async {
//       // check if this user hold mic or not first
//       // var existingItem = _micUsersList.firstWhere(
//       //     (itemToCheck) =>
//       //         itemToCheck.userId == PreferencesServices.getString(ID_KEY),
//       //     orElse: () => null);
//       // if (existingItem != null) {
//       //   // user already holds mic before
//       //   print(existingItem.micNumber);
//       //   print(existingItem.userName);
//       //   // leave mic
//       //   existingItem.userName = null;
//       //   existingItem.userId = null;
//       //   existingItem.micNumber = existingItem.micNumber;
//       //   existingItem.micStatus = false;
//       //   finish(context);
//       //   // _updateMicsToFirebase(existingItem.micNumber, existingItem);
//       // } else {
//       {
//         finish(context);
//       }

//       finish(
//         context,
//       );
//     });
//     return true;
//   }

//   void _addMicsToFirebase(String roomID) async {
//     // await _firestoreInstance.collection('roomUsers')
//     //     .doc(roomID).collection(roomID).doc().delete();
//     List<UserMicModel> _micsList = [];

//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 0,
//         micStatus: false,
//         isLocked: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 1,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 2,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 3,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 4,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 5,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 6,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 7,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 8,
//         isLocked: false,
//         micStatus: false));
//     _micsList.add(UserMicModel(
//         id: null,
//         userId: null,
//         userName: null,
//         micNumber: 9,
//         isLocked: false,
//         micStatus: false));
//     CollectionReference _collectionRef = FirebaseFirestore.instance
//         .collection('roomUsers')
//         .doc(roomID)
//         .collection(roomID);
//     await _collectionRef
//         .doc(_micsList[0].micNumber.toString())
//         .set(_micsList[0].toJson());
//     await _collectionRef
//         .doc(_micsList[1].micNumber.toString())
//         .set(_micsList[1].toJson());
//     await _collectionRef
//         .doc(_micsList[2].micNumber.toString())
//         .set(_micsList[2].toJson());
//     await _collectionRef
//         .doc(_micsList[3].micNumber.toString())
//         .set(_micsList[3].toJson());
//     await _collectionRef
//         .doc(_micsList[4].micNumber.toString())
//         .set(_micsList[4].toJson());
//     _micsList.forEach((element) async {
//       await _collectionRef
//           .doc("${_micsList.indexOf(element)}")
//           .set(element.toJson());
//     });
//   }
// }
