/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/common_functions.dart';
import 'package:project/gift_screen.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/room_index.dart';
import 'package:project/oneTo_one_screen.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

import '../../models/show_friends_model.dart';
import '../../test.dart';

class UsersInroom extends StatefulWidget {
  String roomID;
  String type;
  String giftId;
  String controller;

  UsersInroom({this.roomID, this.type, this.giftId, this.controller});

  @override
  State<UsersInroom> createState() => _UsersInroomState();
}

class _UsersInroomState extends State<UsersInroom> {
  String textt = 'bbbb';

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocProvider(
      create: ((context) => HomeCubit()..getroomuser(id: widget.roomID)),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddSupervsorSuccessStates) {
            // CommonFunctions.showToast('تم تعين مشرف', Colors.green);
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }
          if (state is SendGiftSuccessStates) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }

          // if (state is AddBlockListSuccessStates) {
          //   CommonFunctions.showToast('تم حظر العظو', Colors.green);
          // }
        },
        builder: (context, state) {
          var model = HomeCubit.get(context).roomUserModel;
          return Container(
              height: MediaQuery.of(context).size.height * 0.80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    ':المتواجدون',
                    style: TextStyle(color: Colors.black),
                  ),
                  centerTitle: true,
                  actions: [
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.refresh_rounded,
                          ),
                          onPressed: () {
                            setState(() {
                              textt = 'aaa';
                            });
                          },
                        ))
                  ],
                ),
                body: ConditionalBuilder(
                  condition: HomeCubit.get(context).roomUserModel != null,
                  // HomeCubit.get(context).showFriendsModel != null,
                  builder: (context) {
                    return ListView.separated(
                        itemBuilder: (context, index) => builditem(
                            HomeCubit.get(context).roomUserModel.data[index],
                            textt,
                            widget.roomID,
                            // HomeCubit.get(context).showFriendsModel.data[index],
                            context),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount:
                            HomeCubit.get(context).roomUserModel.data.length);
                  },
                  fallback: (context) => Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  // builder: (BuildContext context, AsyncSnapshot snapshot) {
                  //   if (HomeCubit.get(context).categoriesModel.data == null) {
                  //     return CircularProgressIndicator();
                  //   } else {
                  //     return ListView.builder(
                  //         itemBuilder: (context, index) => buildCatItem(
                  //             HomeCubit.get(context).categoriesModel.data[index]),
                  //         itemCount:
                  //             HomeCubit.get(context).categoriesModel.data.length);
                  //   }
                  // },
                ),
              ));
        },
      ),
    );
  }
}

// class UsersInroom extends StatelessWidget {
//   String roomID;
//   String type;
//   String giftId;
//   String controller;
//   UsersInroom({this.roomID, this.type, this.giftId, this.controller});

//   @override
//   Widget build(BuildContext context) {
//     var model;
//     return BlocProvider(
//       create: ((context) => HomeCubit()..getroomuser(id: roomID)),
//       child: BlocConsumer<HomeCubit, HomeStates>(
//         listener: (context, state) {
//           if (state is AddSupervsorSuccessStates) {
//             // CommonFunctions.showToast('تم تعين مشرف', Colors.green);
//             print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
//           }
//           if (state is SendGiftSuccessStates) {
//             print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
//           }
//         },
//         builder: (context, state) {
//           var model = HomeCubit.get(context).roomUserModel;
//           return Container(
//               height: MediaQuery.of(context).size.height * 0.80,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.0),
//                   topRight: Radius.circular(30.0),
//                 ),
//               ),
//               child: Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: Colors.white,
//                   title: Text(
//                     ':المتواجدون',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   centerTitle: true,
//                   actions: [
//                     Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.refresh_rounded,
//                           ),
//                           onPressed: () {},
//                         ))
//                   ],
//                 ),
//                 body: ConditionalBuilder(
//                   condition: HomeCubit.get(context).roomUserModel != null,
//                   // HomeCubit.get(context).showFriendsModel != null,
//                   builder: (context) {
//                     return ListView.separated(
//                         itemBuilder: (context, index) => builditem(
//                             HomeCubit.get(context).roomUserModel.data[index],
//                             // HomeCubit.get(context).showFriendsModel.data[index],
//                             context),
//                         separatorBuilder: (context, index) => Divider(),
//                         itemCount:
//                             HomeCubit.get(context).roomUserModel.data.length);
//                   },
//                   fallback: (context) => Container(
//                     color: Colors.white,
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                   // builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   //   if (HomeCubit.get(context).categoriesModel.data == null) {
//                   //     return CircularProgressIndicator();
//                   //   } else {
//                   //     return ListView.builder(
//                   //         itemBuilder: (context, index) => buildCatItem(
//                   //             HomeCubit.get(context).categoriesModel.data[index]),
//                   //         itemCount:
//                   //             HomeCubit.get(context).categoriesModel.data.length);
//                   //   }
//                   // },
//                 ),
//               ));
//         },
//       ),
//     );
//   }

// Widget build(BuildContext context) {
//   return Builder(
//     builder: (BuildContext context) {
//       HomeCubit.get(context).getroomuser(id: roomID);
//       return BlocConsumer<HomeCubit, HomeStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           var model = HomeCubit.get(context).roomUserModel;

//           return Container(
//               height: MediaQuery.of(context).size.height * 0.80,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(30.0),
//                   topRight: Radius.circular(30.0),
//                 ),
//               ),
//               child: Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: Colors.white,
//                   title: Text(
//                     ':المتواجدون',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   centerTitle: true,
//                   actions: [
//                     Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.refresh_rounded,
//                           ),
//                           onPressed: () {},
//                         ))
//                   ],
//                 ),
//                 body: ConditionalBuilder(
//                   condition: HomeCubit.get(context).roomUserModel != null,
//                   builder: (context) {
//                     return ListView.separated(
//                         itemBuilder: (context, index) => builditem(
//                             HomeCubit.get(context).roomUserModel.data[index],
//                             context),
//                         separatorBuilder: (context, index) => Divider(),
//                         itemCount:
//                             HomeCubit.get(context).roomUserModel.data.length);
//                   },
//                   fallback: (context) => Container(
//                     color: Colors.white,
//                     child: Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   ),
//                   // builder: (BuildContext context, AsyncSnapshot snapshot) {
//                   //   if (HomeCubit.get(context).categoriesModel.data == null) {
//                   //     return CircularProgressIndicator();
//                   //   } else {
//                   //     return ListView.builder(
//                   //         itemBuilder: (context, index) => buildCatItem(
//                   //             HomeCubit.get(context).categoriesModel.data[index]),
//                   //         itemCount:
//                   //             HomeCubit.get(context).categoriesModel.data.length);
//                   //   }
//                   // },
//                 ),
//               ));
//         },
//       );
//     },
//   );
// }

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

Widget builditem(InRoomUserModelModelData model, String text, String roomID,
        BuildContext context) =>
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                "assets/images/Profile Image.png",
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              model.name.toString(),
            ),
            Spacer(),
            Text(
              'LV ${model.level.userCurrentLevel.toString()}',
              style:
                  TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
          ],
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
                                    "LV ${model.level.userCurrentLevel.toString()}",
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
                                            //     Get.to(StackDemo());
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
                                                                  HomeCubit.get(
                                                                          context)
                                                                      .addBlockList(
                                                                          id: model
                                                                              .userId);
                                                                  Navigator.pop(
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
                                                                    Navigator.pop(
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
                                                  // print(model.userId);
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

                                                                  Navigator.pop(
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
                                                                    Navigator.pop(
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

                                                  // FirebaseFirestore.instance
                                                  //     .collection('users')
                                                  //     .doc(model.spacialId)
                                                  //     .add(
                                                  //       model.toMap(),
                                                  //     );
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
                                                      onSelected(context, item,
                                                          model.userId, roomID),
                                                  itemBuilder: (context) => [
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
      ),
    );

void onSelected(BuildContext context, int item, int userID, String roomid) {
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

    case 4:
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => RoomSettings(
      //           roomName: widget.roomName,
      //           type: widget.roomDesc,
      //           roomID: widget.roomId,
      //         )));
      break;
    // case 1:
    //    Navigator.of(context).push(
    //        MaterialPageRoute(builder: (context) => ShopbackgroundGift()));
    //   break;
  }
}

// Widget userItem(
//   InRoomUserModelModelData model,
//   BuildContext context,
// ) =>
//     Padding(
//       padding: const EdgeInsets.all(20.0),
//       child: InkWell(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 20,
//               backgroundImage: AssetImage(
//                 "assets/images/Profile Image.png",
//               ),
//             ),
//             SizedBox(
//               width: 20.0,
//             ),
//             Text(model.name),
//             Spacer(),
//             Text(
//               'LV.39',
//               style:
//                   TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         onTap: () {
//           showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (context) {
//                 return FractionallySizedBox(
//                   heightFactor: 0.35,
//                   child: Container(
//                     decoration: new BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: new BorderRadius.only(
//                             topLeft: const Radius.circular(10.0),
//                             topRight: const Radius.circular(10.0))),
//                     child: Column(
//                       children: [
//                         Container(
//                           child: FloatingActionButton(
//                               child: CircleAvatar(
//                                 radius: 50,
//                                 backgroundImage: AssetImage(
//                                   "assets/images/Profile Image.png",
//                                 ),
//                               ),
//                               onPressed: () {}),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(model.name),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                   width: 50,
//                                   decoration: BoxDecoration(
//                                     color: kPrimaryColor,
//                                     borderRadius: BorderRadius.only(
//                                       topRight: Radius.circular(10),
//                                       bottomRight: Radius.circular(10),
//                                       bottomLeft: Radius.circular(10),
//                                       topLeft: Radius.circular(10),
//                                     ),
//                                     border: Border.all(
//                                       width: 1,
//                                       color: kPrimaryColor,
//                                       style: BorderStyle.solid,
//                                     ),
//                                     // shape: BoxShape.circle,
//                                   ),
//                                   child: Center(
//                                       child: Text(
//                                     "عضو",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 12),
//                                   ))),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               'ID:${model.userId}',
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                             SizedBox(
//                               width: 10,
//                             ),
//                             Text(
//                               'LV.39',
//                               style: TextStyle(
//                                   color: kPrimaryColor,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ],
//                         ),
//                         Spacer(),
//                         Padding(
//                           padding: const EdgeInsets.all(20.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Column(
//                                 children: [
//                                   MaterialButton(
//                                     onPressed: () {
//                                       //  HomeCubit.get(context).sendgift(id: roomID, type: type, received: received)
//                                     },
//                                     color: Colors.blueAccent,
//                                     textColor: Colors.white,
//                                     child: Icon(
//                                       Icons.card_giftcard,
//                                       size: 14,
//                                     ),
//                                     padding: EdgeInsets.all(16),
//                                     shape: CircleBorder(),
//                                   ),
//                                   Text(
//                                     'إرسال هديه',
//                                     style: TextStyle(color: Colors.grey),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 40,
//                               ),
//                               Column(
//                                 children: [
//                                   MaterialButton(
//                                     onPressed: () {},
//                                     color: Colors.pink,
//                                     textColor: Colors.white,
//                                     child: Icon(
//                                       Icons.star,
//                                       size: 14,
//                                     ),
//                                     padding: EdgeInsets.all(16),
//                                     shape: CircleBorder(),
//                                   ),
//                                   Text(
//                                     'البطاقات السحرية',
//                                     style: TextStyle(color: Colors.grey),
//                                   )
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 40,
//                               ),
//                               Column(
//                                 children: [
//                                   MaterialButton(
//                                     onPressed: () {},
//                                     color: Colors.yellow,
//                                     textColor: Colors.white,
//                                     child: Icon(
//                                       Icons.person_add,
//                                       size: 14,
//                                     ),
//                                     padding: EdgeInsets.all(16),
//                                     shape: CircleBorder(),
//                                   ),
//                                   Text(
//                                     'إضافه صديق',
//                                     style: TextStyle(color: Colors.grey),
//                                   )
//                                 ],
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 );
//               });
//         },
//       ),
//     );
