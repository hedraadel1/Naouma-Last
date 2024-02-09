/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/models/getMyroom_model.dart';
import 'package:project/models/myroomCheck_model.dart';

import 'package:project/models/room_data_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/images.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/details/details_screen.dart';
import 'package:project/view/details/newPage.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';
import 'package:project/view/login/logincubit.dart';

import 'home_tab/common_rooms_view.dart';
import 'myroom/create_room_screen.dart';
import 'myroom/my_rooms_view.dart';

class MyRoomTab extends StatefulWidget {
  @override
  _MyRoomTabState createState() => _MyRoomTabState();
}

class _MyRoomTabState extends State<MyRoomTab> {
  final _firestoreInstance = FirebaseFirestore.instance;

  bool _haveARoom = false;
  bool _loadingRoom = true;
  List<RoomDataModel> _myRooms = [];

  @override
  void initState() {
    // TODO: implement initState
    //getmyroom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>["منضم اليها", "متابعة"];
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    var model = HomeCubit.get(context).getMyRoomModel;
    // return BlocProvider(
    //   create: (context) => HomeCubit(),
    //   child: BlocConsumer<HomeCubit, HomeStates>(
    //       builder: (context, state) {
    //         return DefaultTabController(
    //           length: _tabs.length,
    //           child: Scaffold(
    //             body: NestedScrollView(
    //               headerSliverBuilder:
    //                   (BuildContext context, bool innerBoxIsScrolled) {
    //                 return <Widget>[
    //                   SliverOverlapAbsorber(
    //                     handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
    //                         context),
    //                     sliver: SliverAppBar(
    //                       expandedHeight: size.height * 0.22,
    //                       floating: true,
    //                       pinned: true,
    //                       snap: false,
    //                       backgroundColor: Colors.grey.shade300,
    //                       forceElevated: innerBoxIsScrolled,
    //                       flexibleSpace: Stack(
    //                         children: [
    //                           Container(
    //                             margin: const EdgeInsets.only(
    //                                 left: 2.0,
    //                                 right: 2.0,
    //                                 top: 2.0,
    //                                 bottom: 50),
    //                             decoration: BoxDecoration(
    //                               color: kPrimaryColor,
    //                               // image: DecorationImage(
    //                               //   image: NetworkImage(
    //                               //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
    //                               //   //your image
    //                               //   fit: BoxFit.cover,
    //                               // ),
    //                               borderRadius: BorderRadius.only(
    //                                 bottomLeft: Radius.circular(50),
    //                                 bottomRight: Radius.circular(50),
    //                               ),
    //                             ),
    //                             // child: HomeSlide(),
    //                           ),
    //                           Align(
    //                             alignment: Alignment.center,
    //                             // child: _loadingRoom?Center(child: Container(width: 24, height:24,child: CircularProgressIndicator()),):_haveARoom?_myRoom(roomId, roomName, roomDesc):_createRoomSlide(theme),
    //                             // child: StreamBuilder<QuerySnapshot>(
    //                             //   stream: _firestoreInstance
    //                             //       .collection('rooms')
    //                             //       .where("roomOwnerId",
    //                             //           isEqualTo:
    //                             //               PreferencesServices.getString(ID_KEY))
    //                             //       .snapshots(),
    //                             //   builder: (BuildContext context,
    //                             //       AsyncSnapshot<QuerySnapshot> snapshot) {
    //                             //     if (snapshot.hasData &&
    //                             //         snapshot.data.docs.length > 0) {
    //                             //       return _myRoom(
    //                             //           snapshot.data.docs[0].id,
    //                             //           snapshot.data.docs[0]['roomName'],
    //                             //           snapshot.data.docs[0]['roomDesc']);
    //                             //     } else {
    //                             //       return _createRoomSlide(theme);
    //                             //     }
    //                             //   },
    //                             // ),

    //                             child: ConditionalBuilder(
    //                               condition: true,
    //                               builder: (context) => _myRoom(
    //                                 HomeCubit.get(context)
    //                                     .myroomCheckModel
    //                                     .data,
    //                               ),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       bottom: AppBar(
    //                         toolbarHeight: 50,
    //                         backgroundColor: Colors.white,
    //                         elevation: 4.0,
    //                         title: TabBar(
    //                           indicatorSize: TabBarIndicatorSize.label,
    //                           indicatorColor: kPrimaryColor,
    //                           indicatorWeight: 4.0,
    //                           labelStyle: TextStyle(
    //                               fontSize: 18.0, fontWeight: FontWeight.w700),
    //                           //For Selected tab
    //                           tabs: _tabs
    //                               .map((String name) => Tab(text: name))
    //                               .toList(),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ];
    //               },
    //               body: TabBarView(children: [
    //                 MyRoomsView(),
    //                 CommonRoomsView(),
    //               ]),
    //             ),
    //           ),
    //         );
    //       },
    //       listener: (context, state) {}),
    // );

    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getmyroom();
      return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          // return Scaffold(
          //     body: Column(
          //   children: [
          //     SliverOverlapAbsorber(
          //       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          //       sliver: SliverAppBar(
          //         expandedHeight: size.height * 0.22,
          //         floating: true,
          //         pinned: true,
          //         snap: false,
          //         backgroundColor: Colors.grey.shade300,
          //         // forceElevated: innerBoxIsScrolled,
          //         flexibleSpace: Stack(
          //           children: [
          //             Container(
          //               margin: const EdgeInsets.only(
          //                   left: 2.0, right: 2.0, top: 2.0, bottom: 50),
          //               decoration: BoxDecoration(
          //                 color: kPrimaryColor,
          //                 // image: DecorationImage(
          //                 //   image: NetworkImage(
          //                 //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
          //                 //   //your image
          //                 //   fit: BoxFit.cover,
          //                 // ),
          //                 borderRadius: BorderRadius.only(
          //                   bottomLeft: Radius.circular(50),
          //                   bottomRight: Radius.circular(50),
          //                 ),
          //               ),
          //               // child: HomeSlide(),
          //             ),
          //             Align(
          //               alignment: Alignment.center,
          //               child: ConditionalBuilder(
          //                 condition:
          //                     HomeCubit.get(context).getMyRoomModel != null,
          //                 builder: (context) {
          //                   return _myRoom(
          //                       HomeCubit.get(context).getMyRoomModel.data);
          //                 },
          //                 fallback: (context) => _createRoomSlide(theme),
          //               ),
          //               // child: _loadingRoom?Center(child: Container(width: 24, height:24,child: CircularProgressIndicator()),):_haveARoom?_myRoom(roomId, roomName, roomDesc):_createRoomSlide(theme),
          //               // child: StreamBuilder<QuerySnapshot>(
          //               //   stream: _firestoreInstance
          //               //       .collection('rooms')
          //               //       .where("roomOwnerId",
          //               //           isEqualTo:
          //               //               PreferencesServices.getString(ID_KEY))
          //               //       .snapshots(),
          //               //   builder: (BuildContext context,
          //               //       AsyncSnapshot<QuerySnapshot> snapshot) {
          //               //     if (snapshot.hasData &&
          //               //         snapshot.data.docs.length > 0) {
          //               //       return _myRoom(
          //               //           snapshot.data.docs[0].id,
          //               //           snapshot.data.docs[0]['roomName'],
          //               //           snapshot.data.docs[0]['roomDesc']);
          //               //     } else {
          //               //       return _createRoomSlide(theme);
          //               //     }
          //               //   },
          //               // ),
          //             ),
          //           ],
          //         ),
          //         // bottom: AppBar(
          //         //   toolbarHeight: 50,
          //         //   backgroundColor: Colors.white,
          //         //   elevation: 4.0,
          //         //   title: TabBar(
          //         //     indicatorSize: TabBarIndicatorSize.label,
          //         //     indicatorColor: kPrimaryColor,
          //         //     indicatorWeight: 4.0,
          //         //     labelStyle: TextStyle(
          //         //         fontSize: 18.0, fontWeight: FontWeight.w700),
          //         //     //For Selected tab
          //         //     tabs: _tabs
          //         //         .map((String name) => Tab(text: name))
          //         //         .toList(),
          //         //   ),
          //         // ),
          //       ),
          //     ),

          //     // CommonRoomsView(),
          //   ],
          // ));

          return DefaultTabController(
            length: _tabs.length,
            child: Scaffold(
              body: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                        expandedHeight: size.height * 0.22,
                        floating: true,
                        pinned: true,
                        snap: false,
                        backgroundColor: Colors.transparent,
                        forceElevated: innerBoxIsScrolled,
                        flexibleSpace: Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(
                                  left: 2.0, right: 2.0, top: 2.0, bottom: 50),
                              decoration: BoxDecoration(
                                color: kPrimaryColor,
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
                                  //your image
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                              ),
                              // child: HomeSlide(),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: ConditionalBuilder(
                                condition:
                                    HomeCubit.get(context).getMyRoomModel !=
                                        null,
                                builder: (context) {
                                  return _myRoom(HomeCubit.get(context)
                                      .getMyRoomModel
                                      .data);
                                },
                                fallback: (context) => _createRoomSlide(theme),
                              ),
                              // child: _loadingRoom?Center(child: Container(width: 24, height:24,child: CircularProgressIndicator()),):_haveARoom?_myRoom(roomId, roomName, roomDesc):_createRoomSlide(theme),
                              // child: StreamBuilder<QuerySnapshot>(
                              //   stream: _firestoreInstance
                              //       .collection('rooms')
                              //       .where("roomOwnerId",
                              //           isEqualTo:
                              //               PreferencesServices.getString(ID_KEY))
                              //       .snapshots(),
                              //   builder: (BuildContext context,
                              //       AsyncSnapshot<QuerySnapshot> snapshot) {
                              //     if (snapshot.hasData &&
                              //         snapshot.data.docs.length > 0) {
                              //       return _myRoom(
                              //           snapshot.data.docs[0].id,
                              //           snapshot.data.docs[0]['roomName'],
                              //           snapshot.data.docs[0]['roomDesc']);
                              //     } else {
                              //       return _createRoomSlide(theme);
                              //     }
                              //   },
                              // ),
                            ),
                          ],
                        ),
                        // bottom: AppBar(
                        //   toolbarHeight: 50,
                        //   backgroundColor: Colors.white,
                        //   elevation: 4.0,
                        //   title: TabBar(
                        //     indicatorSize: TabBarIndicatorSize.label,
                        //     indicatorColor: kPrimaryColor,
                        //     indicatorWeight: 4.0,
                        //     labelStyle: TextStyle(
                        //         fontSize: 18.0, fontWeight: FontWeight.w700),
                        //     //For Selected tab
                        //     tabs: _tabs
                        //         .map((String name) => Tab(text: name))
                        //         .toList(),
                        //   ),
                        // ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(children: [
                  MyRoomsView(),
                  CommonRoomsView(),
                ]),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _createRoomSlide(var theme) {
    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          print("create room clicked");
          Get.to(CreateRoomScreen());
        },
        child: Container(
          width: 300,
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 52),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
                radius: 30,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "إنشاء غرفة",
                      style: theme.textTheme.bodyText1.copyWith(fontSize: 16.0),
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "ابدأ رحلتك فى نعومة !",
                      style: theme.textTheme.bodyText2.copyWith(fontSize: 15.0),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.flag,
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void getMyRoom() async {
  //   QuerySnapshot querySnapshot = await _firestoreInstance
  //       .collection('rooms')
  //       .where("roomOwnerId", isEqualTo: PreferencesServices.getString(ID_KEY))
  //       .get();
  //   print(querySnapshot.docs.length);
  //   if (querySnapshot.docs.length > 0) {
  //     print("_haveARoom: $_haveARoom");
  //     print("in it...");
  //     // querySnapshot.docs.forEach((document) {
  //     //     print(document.data);
  //     //     // Map<String, dynamic> json = document.data(); //casts, but if you put breaklines through this its that _InternalLinkedHashMap<dynamic, dynamic> type
  //     //     RoomDataModel myRoomDataModel = new RoomDataModel.fromJson(document.data());
  //     //     _myRooms.add(myRoomDataModel);
  //     //   });

  //     setState(() {
  //       roomId = querySnapshot.docs[0].id;
  //       roomName = querySnapshot.docs[0]['roomName'];
  //       roomDesc = querySnapshot.docs[0]['roomDesc'];
  //       _haveARoom = true;
  //       _loadingRoom = false;
  //     });
  //   } else {
  //     setState(() {
  //       _haveARoom = false;
  //       _loadingRoom = false;
  //     });
  //     print("_haveARoom: $_haveARoom");
  //   }
  // }

  Widget _myRoom(GetMyRoomModelData model) {
    return GestureDetector(
      onTap: () {
        print("roomDetails");
        Get.to(DetailsScreen(
          roomId: model.id.toString(),
          roomName: model.roomName,
          roomDesc: model.roomDesc,
          roomOwnerId: PreferencesServices.getString(ID_KEY),
        ));
      },
      child: SingleChildScrollView(
        child: Container(
          width: 300,
          margin:
              const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 52),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: kPrimaryColor,
                child: Image.asset(kDefaultProfileImage),
                radius: 35,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      model.roomName,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      model.roomDesc,
                      style: TextStyle(color: Colors.black, fontSize: 15.0),
                      textAlign: TextAlign.start,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
