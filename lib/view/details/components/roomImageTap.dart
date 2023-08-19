import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/common_functions.dart';
import 'package:project/frames_screen.dart';
import 'package:project/gift_screen.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/room_index.dart';
import 'package:project/oneTo_one_screen.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

import '../../../models/users_following_room_model.dart';
import '../../home/home_tab_pages/myroom/room_setting.dart';

class RoomImageTap extends StatefulWidget {
  String roomID;
  String roomname;

  String roomDesc;
  String roomimage;
  String controller;
  String totalNum;

  int currentlevel;

  RoomImageTap(
      {this.roomID,
      this.roomname,
      this.roomimage,
      this.controller,
      this.totalNum,
      this.roomDesc,
      this.currentlevel});
  @override
  State<RoomImageTap> createState() => _RoomImageTapState();
}

class _RoomImageTapState extends State<RoomImageTap> {
  String textt = 'bbbb';

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocProvider(
      create: ((context) => HomeCubit()
        ..getroomuser(id: widget.roomID)
        ..usersfollowingroom(id: widget.roomID)),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // if (state is FollowSuccessStates) {
          //    CommonFunctions.showToast('تم تعين مشرف', Colors.green);
          //   print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          // }
          if (state is SendGiftSuccessStates) {
            print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>');
          }

          // if (state is AddBlockListSuccessStates) {
          //   CommonFunctions.showToast('تم حظر العظو', Colors.green);
          // }
        },
        builder: (context, state) {
          var model = HomeCubit.get(context).userFollowingRoomModel;
          return FractionallySizedBox(
            heightFactor: 0.85,
            child: Stack(children: [
              Column(
                children: [
                  // new Container(
                  //   height: 10,
                  //   color: Colors.transparent.withOpacity(0.0),
                  // ),
                  Container(
                    // height: 300,
                    height: MediaQuery.of(context).size.height * 0.80,
                    decoration: BoxDecoration(
                      // color: Colors.white,

                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: DefaultTabController(
                        length: 4,
                        child: Scaffold(
                          appBar: PreferredSize(
                            preferredSize: Size.fromHeight(70.0),
                            child: AppBar(
                              flexibleSpace: Container(
                                  decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.only(
                                      //     topLeft: Radius.circular(20),
                                      //     topRight: Radius.circular(20)),
                                      gradient: userstateInroom == 'owner'
                                          ? LinearGradient(
                                              colors: [Colors.red, Colors.pink],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter)
                                          : LinearGradient(
                                              colors: [
                                                  Colors.blue,
                                                  Colors.blue.shade500
                                                ],
                                              begin: Alignment.bottomCenter,
                                              end: Alignment.topCenter))),
                              backgroundColor: Colors.white,
                              bottom: TabBar(
                                indicatorColor: kPrimaryLightColor,
                                tabs: [
                                  Tab(
                                    text: 'البيانات',
                                  ),
                                  Tab(
                                    text: 'عضو',
                                  ),
                                  Tab(
                                    text: 'نشاطات',
                                  ),
                                  Tab(
                                    text: 'اللحظات',
                                  ),
                                ],
                              ),
                              title: Text(
                                '${widget.roomname.toString()}',
                                style: TextStyle(
                                    color: Colors.grey.shade200,
                                    fontWeight: FontWeight.bold),
                              ),
                              centerTitle: true,
                            ),
                          ),
                          body: TabBarView(
                            children: [
                              ListView(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 30,
                                  ),

                                  userstateInroom == 'owner'
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: 150,
                                            ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                // color: Colors.black,
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  widget.roomimage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Spacer(),

                                            // SizedBox(
                                            //   width: 100,
                                            // ),
                                            InkWell(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10),
                                                    child: Icon(Icons.settings),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: Text('الاعدادات'),
                                                  )
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RoomSettings(
                                                              roomName: widget
                                                                  .roomname,
                                                              type: widget
                                                                  .roomDesc,
                                                              roomID:
                                                                  widget.roomID,
                                                              roomImage: widget
                                                                  .roomimage,
                                                            )));
                                              },
                                            )
                                          ],
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            // Container(
                                            //   width: 100,
                                            // ),
                                            Align(
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                // color: Colors.black,
                                                height: 100,
                                                width: 100,
                                                child: Image.network(
                                                  widget.roomimage,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Center(
                                    child: Container(
                                      child: Text(
                                        widget.roomname,
                                        style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Text(
                                          'ID :${widget.roomID}',
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.document_scanner_rounded,
                                        size: 15,
                                        color: Colors.grey.shade700,
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: userstateInroom == 'owner'
                                          ? Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    // Text(
                                                    //   'المستوي:',
                                                    //   style: TextStyle(
                                                    //       color: Colors.grey.shade800),
                                                    // ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              'المستوي:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade600),
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'LV.${widget.currentlevel}',
                                                              style: TextStyle(
                                                                  color:
                                                                      kPrimaryLightColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Container(
                                                          height: 4,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                kPrimaryLightColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          30.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30.0),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 0.5,
                                                        ),
                                                        Container(
                                                          height: 4,
                                                          width: 130,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors
                                                                .grey.shade400,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      30.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      30.0),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .report_gmailerrorred_sharp,
                                                              color: Colors.grey
                                                                  .shade800,
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              'LV.${widget.currentlevel + 1}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .grey
                                                                      .shade500,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Container()),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 350,
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'عضو :',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              allUserFollowRoom.toString(),
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 350,
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      )
                                    ],
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'البلد :',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "مصر",
                                              style: TextStyle(
                                                  color: Colors.grey.shade700,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 350,
                                        height: 1,
                                        color: Colors.grey.shade300,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'التصنيف :',
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text(
                                        //       allUserFollowRoom.toString(),
                                        //       style: TextStyle(
                                        //           color: Colors.grey.shade700,
                                        //           fontWeight: FontWeight.bold),
                                        //     )
                                        //   ],
                                        // )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  userstateInroom != 'owner'
                                      ? Container(
                                          height: 70,
                                          decoration: BoxDecoration(
                                              color: Colors.grey.shade300,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20),
                                              )),
                                          child: iFollow == false
                                              ? InkWell(
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person_outlined,
                                                          color:
                                                              kPrimaryLightColor,
                                                          size: 28,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'انضمام',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15))),
                                                          title: Center(
                                                            child: const Text(
                                                                'هل تريد الانضمام الغرفة'),
                                                          ),
                                                          // content: const Text('AlertDialog description'),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    HomeCubit.get(
                                                                            context)
                                                                        .followroom(
                                                                            id: widget.roomID);
                                                                    Navigator.pop(
                                                                        context,
                                                                        'yes');
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
                                                  },
                                                )
                                              : InkWell(
                                                  child: Container(
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.person_outlined,
                                                          color:
                                                              kPrimaryLightColor,
                                                          size: 28,
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          'ترك الغرفة',
                                                          style: TextStyle(
                                                              fontSize: 22,
                                                              color: Colors.grey
                                                                  .shade600,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    showDialog<String>(
                                                      context: context,
                                                      builder: (BuildContext
                                                              context) =>
                                                          Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          15))),
                                                          title: Center(
                                                            child: const Text(
                                                                'هل تريد ترك الغرفة'),
                                                          ),
                                                          // content: const Text('AlertDialog description'),
                                                          actions: <Widget>[
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    HomeCubit.get(context).postUnfollowser(
                                                                        idUser:
                                                                            apiid,
                                                                        idRoom:
                                                                            widget.roomID);
                                                                    Navigator.pop(
                                                                        context,
                                                                        'yes');
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
                                                  },
                                                ),
                                        )
                                      : Container()
                                ],
                              ),
                              Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text(
                                        'عضو :40000 /${allUserFollowRoom.toString()}',
                                        style: TextStyle(
                                            color: Colors.grey.shade800),
                                      ),
                                      Spacer(),
                                      Icon(Icons.person,
                                          color: Colors.grey.shade700),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Icon(Icons.report_gmailerrorred_sharp,
                                          color: Colors.grey.shade700),
                                      SizedBox(
                                        width: 25,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 30,
                                      child: TextFormField(
                                          // controller: roomsearchtext,
                                          validator: (String value) {
                                            if (value.isEmpty) {
                                              return 'enter text to search';
                                            }
                                            return null;
                                          },
                                          onFieldSubmitted: (String text) {
                                            // SearchScreenCubit.get(context)
                                            //     .search(roomId: text);
                                          },
                                          decoration: InputDecoration(
                                              suffixIcon: Icon(Icons.search),
                                              // Icon: Icon(Icons.search),

                                              hintText:
                                                  "البحث عن اسم المستخدم أو ID",
                                              contentPadding: EdgeInsets.only(
                                                  top: 5, right: 10),
                                              border: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.black),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20.0)),
                                                borderSide: BorderSide(
                                                    color: Colors.grey),
                                              ))),
                                    ),
                                  ),
                                  ConditionalBuilder(
                                    condition: HomeCubit.get(context)
                                            .userFollowingRoomModel !=
                                        null,
                                    builder: (context) {
                                      return ListView.builder(
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              builditem(
                                                  HomeCubit.get(context)
                                                      .userFollowingRoomModel
                                                      .data
                                                      .first
                                                      .followers[index],
                                                  context),
                                          // separatorBuilder: (context, index) =>
                                          //     Divider(),
                                          itemCount: HomeCubit.get(context)
                                              .userFollowingRoomModel
                                              .data
                                              .first
                                              .followers
                                              .length);
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
                                ],
                              ),
                              Icon(Icons.directions_bike),
                              Icon(Icons.directions_bike),
                            ],
                          ),

                          // bottomNavigationBar:  userstateInroom != 'owner'? BottomAppBar(
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.person_outline,
                          //         color: kPrimaryLightColor,
                          //       ),
                          //       TextButton(
                          //         onPressed: () {},
                          //         child: Text(
                          //           "انضمام",
                          //           // style: TextStyle(
                          //           //     color: Colors.grey.shade600,
                          //           //     fontWeight: FontWeight.bold),
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ):
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ]),
          );
        },
      ),
    );
  }

  Widget builditem(
    Followers model,
    BuildContext context,
  ) =>
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
                model.name,
              ),
              Spacer(),

              // IconButton(
              //     onPressed: () {
              //       // HomeCubit.get(context).deleteSupervsorroom(id: model.id);
              //     },
              //     icon: Icon(Icons.remove_circle_outline_rounded))
            ],
          ),
        ),
      );
}
