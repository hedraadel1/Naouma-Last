/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/endpoint.dart';
import 'package:project/oneTo_one_screen.dart';
import 'package:project/personalID_screen.dart';
import 'package:project/privateID_screen.dart';

import 'package:project/shop_background_gift.dart';
import 'package:project/shop_intres_screen.dart';
import 'package:project/shop_lock_room.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/details/newPage.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/profile/profile_screen.dart';

import 'frames_screen.dart';

class StoreScreen extends StatefulWidget {
  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> _tabs = <String>["منضم اليها", "متابعة"];
    final size = MediaQuery
        .of(context)
        .size;
    final theme = Theme.of(context);
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: KstorebuttonColor,
      appBar: AppBar(
        backgroundColor: KstorebuttonColor,
        // leading: IconButton(
        //   onPressed: () {

        //   },
        //   icon: Icon(Icons.arrow_back_ios),
        // ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: const EdgeInsets.only(
                    left: .0, right: .0, top: 2.0, bottom: 0),
                decoration: BoxDecoration(
                  // color: KstorebuttonColor,
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
                  //   //your image
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                // child: HomeSlide(),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  // image: DecorationImage(
                  //   image: NetworkImage(
                  //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
                  //   //your image
                  //   fit: BoxFit.cover,
                  // ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('الغرف'),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/lock.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('قفل الغرفه'),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              // Get.to(ShopLockRoom());
                            },
                          ),
                          // InkWell(
                          //   child: Container(
                          //       child: Column(
                          //     children: [
                          //       ClipRRect(
                          //         borderRadius: BorderRadius.horizontal(
                          //             right: Radius.circular(8.0)),
                          //         child: Image.asset(
                          //           "assets/icons/arrow.png",
                          //           height: 80,
                          //           width: 80,
                          //           fit: BoxFit.fill,
                          //         ),
                          //       ),
                          //       Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Text('التثبيت في الاعلي'),
                          //       ),
                          //     ],
                          //   )),
                          //   onTap: () {},
                          // ),
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/mark.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('الموضوعات'),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              Get.to(() => ShopbackgroundGift());
                            },
                          ),
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/vippers.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(' أي دي غرفه مميز'),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              // Get.to(PrivteId_screen());
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('المستخدم'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/vippers.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('أي دي شخصي  '),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              Get.to(PersonalID_screen());
                            },
                          ),
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/suprice.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(' البطاقه السحريه '),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              Get.to(framesScreen());
                            },
                          ),
                          InkWell(
                            child: Container(
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.horizontal(
                                          right: Radius.circular(8.0)),
                                      child: Image.asset(
                                        "assets/icons/car.png",
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text('المركبات'),
                                    ),
                                  ],
                                )),
                            onTap: () {
                              Get.to(ShopIntresScreen());
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // body: NestedScrollView(
      //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
      //     return <Widget>[
      //       SliverOverlapAbsorber(
      //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      //         sliver: SliverAppBar(
      //           expandedHeight: size.height * 0.22,
      //           floating: true,
      //           pinned: true,
      //           snap: false,
      //           backgroundColor: Colors.grey.shade300,
      //           forceElevated: innerBoxIsScrolled,
      //           flexibleSpace: Stack(
      //             children: [
      //               Container(
      //                 margin: const EdgeInsets.only(
      //                     left: 2.0, right: 2.0, top: 0.0, bottom: 0),
      //                 decoration: BoxDecoration(
      //                   color: kPrimaryColor,
      //                   // image: DecorationImage(
      //                   //   image: NetworkImage(
      //                   //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
      //                   //   //your image
      //                   //   fit: BoxFit.cover,
      //                   // ),
      //                   borderRadius: BorderRadius.only(
      //                     bottomLeft: Radius.circular(0),
      //                     bottomRight: Radius.circular(0),
      //                   ),
      //                 ),
      //                 // child: HomeSlide(),
      //               ),

      //               // Align(
      //               //   alignment: Alignment.center,
      //               //   // child: _loadingRoom?Center(child: Container(width: 24, height:24,child: CircularProgressIndicator()),):_haveARoom?_myRoom(roomId, roomName, roomDesc):_createRoomSlide(theme),
      //               //   child: StreamBuilder<QuerySnapshot>(
      //               //     stream: _firestoreInstance
      //               //         .collection('rooms')
      //               //         .where("roomOwnerId",
      //               //             isEqualTo:
      //               //                 PreferencesServices.getString(ID_KEY))
      //               //         .snapshots(),
      //               //     builder: (BuildContext context,
      //               //         AsyncSnapshot<QuerySnapshot> snapshot) {
      //               //       if (snapshot.hasData &&
      //               //           snapshot.data.docs.length > 0) {
      //               //         return _myRoom(
      //               //             snapshot.data.docs[0].id,
      //               //             snapshot.data.docs[0]['roomName'],
      //               //             snapshot.data.docs[0]['roomDesc']);
      //               //       } else {
      //               //         return _createRoomSlide(theme);
      //               //       }
      //               //     },
      //               //   ),
      //               // ),
      //             ],
      //           ),

      //           // bottom: AppBar(
      //           //   toolbarHeight: 50,
      //           //   backgroundColor: Colors.white,
      //           //   elevation: 4.0,
      //           //   title: TabBar(
      //           //     indicatorSize: TabBarIndicatorSize.label,
      //           //     indicatorColor: kPrimaryColor,
      //           //     indicatorWeight: 4.0,
      //           //     labelStyle: TextStyle(
      //           //         fontSize: 18.0, fontWeight: FontWeight.w700),
      //           //     //For Selected tab
      //           //     tabs:
      //           //         _tabs.map((String name) => Tab(text: name)).toList(),
      //           //   ),
      //           // ),
      //         ),
      //       ),
      //     ];
      //   },
      //   body: Row(
      //     children: [
      //       Expanded(
      //           flex: 1,
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.spaceAround,
      //             children: [
      //               Container(
      //                 color: Colors.green,
      //                 child: Text('aaaa'),
      //               ),
      //             ],
      //           )),
      //       Expanded(
      //         flex: 1,
      //         child: Container(
      //           color: Colors.black,
      //           child: Text('aaaa'),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: Container(
      //           color: Colors.red,
      //           child: Text('aaaa'),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: Container(
      //           color: Colors.green,
      //           child: Text('aaaa'),
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
