/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:convert';
import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/common_functions.dart';
import 'package:project/dioHelper.dart';
import 'package:project/home.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:http/http.dart' as http;

import 'package:project/models/gift_model.dart';
import 'package:project/models/notification_model.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/room_data_model.dart';
import 'package:project/models/send_gift_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/details/users_Inroom.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

class GiftScreen extends StatefulWidget {
  String roomID;
  String userID;
  String username;
  bool check;

  GiftScreen({Key key, this.roomID, this.userID, this.username, this.check})
      : super(key: key);
  String type;
  String giftID;
  final GlobalKey _menuKey = GlobalKey();

  @override
  State<GiftScreen> createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  // String dropdownvalue = 'sendToAllUser';
  var items = [
    'sendToAllUser',
    'sendToRoom',
    'sendToUser',
  ];

  // String selectedName;
  // List data = [];
  // Future getallnames({@required id}) async {
  //   var response = await http.get(
  //       Uri.parse('http://naouma.link/admin/public/api/rooms/$id/users'),
  //       headers: {
  //         'Authorization': 'Bearer $token',
  //         'Content-Type': 'application/json'
  //       });
  //   var jsonBody = response.body;
  //   var jsonData = json.decode(jsonBody);
  //   setState(() {
  //     data = jsonData;
  //   });
  //   print(jsonData);
  // }

  // void intState() {
  //   super.initState();
  //   getallnames(id: widget.roomID);
  // }

  var _controller = TextEditingController();
  int counter = 1;
  int selectedCard = -1;
  String dropDownValue = 'One';
  String senduserId;
  @override
  var fromkey = GlobalKey<FormState>();
  int index = 0;
  String newValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print("useridis___: ${widget.user}");
  }

  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeCubit()
          ..getWalletAmount()
          ..getGift()
          ..getroomuser(id: widget.roomID),
        // HomeCubit.get(context).getWalletAmount();
        // HomeCubit.get(context).getGift();

        child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            // if (state is SendGiftSuccessStates) {
            //   var model = HomeCubit.get(context).sendgiftModel;
            //   FirebaseMessaging.onMessage.listen((event) {
            //     print(event.data.toString());
            //     SendgiftModel sendgiftModel;
            //     sendgiftModel = SendgiftModel.fromJson(event.data);
            //     // isHaveFrame = null;
            //     // if (model.data.user.entry == 'ther is no entry') {
            //     // } else {
            //     new Future.delayed(Duration.zero, () {
            //       showDialog(
            //           context: context,
            //           builder: (BuildContext context) {
            //             Future.delayed(Duration(seconds: 5), () {
            //               Navigator.of(context).pop(true);
            //             });
            //             return Dialog(
            //               backgroundColor: Colors.transparent,
            //               child: new Container(
            //                   alignment: FractionalOffset.center,
            //                   // height: 80.0,
            //                   // padding: const EdgeInsets.all(20.0),
            //                   child: new Image.network(
            //                     fit: BoxFit.cover,
            //                   )),
            //             );
            //           });
            //     });
            //     // }

            //     // new Future.delayed(Duration.zero, () {
            //     //   showDialog(
            //     //       context: context,
            //     //       builder: (BuildContext context) {
            //     //         // Future.delayed(Duration(seconds: 5), () {
            //     //         //   Navigator.of(context).pop(true);
            //     //         // });
            //     //         return Theme(
            //     //           data: ThemeData(
            //     //               // dialogBackgroundColor: Colors.transparent,
            //     //               ),
            //     //           child: AlertDialog(
            //     //             content: Image.network(
            //     //               "https://newidea.link/nauma-v2/public/uploads/images/shop/Ip6PRJUaTQveUvU93zlZdOlA9aU7WWcCCXETAKpn.gif",
            //     //             ),
            //     //           ),
            //     //         );
            //     //       });
            //     // });
            //   });
            // }
          },
          builder: (context, state) {
            _controller.text = counter.toString();

            return ConditionalBuilder(
              condition: HomeCubit.get(context).getWalletModel != null &&
                  HomeCubit.get(context).giftModel != null &&
                  HomeCubit.get(context).roomUserModel != null,
              builder: (context) => getIntresItem(
                  HomeCubit.get(context).giftModel,
                  context,
                  HomeCubit.get(context).getWalletModel.data,
                  HomeCubit.get(context).roomUserModel.data[index],
                  HomeCubit.get(context).roomUserModel,
                  index,
                  newValue,
                  dropDownValue),
              fallback: (context) => Container(
                height: MediaQuery.of(context).size.height * 0.40,
                color: Colors.black.withOpacity(0.7),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        )

        // create: (context) => HomeCubit()
        //   ..getGift()
        //   ..getWalletAmount(),

        );
  }

  Widget getIntresItem(
    GiftModel model,
    BuildContext context,
    GetWalletData model1,
    InRoomUserModelModelData model2,
    InRoomUserModelModel model3,
    int index,
    String newValue,
    String dropDownValue,
  ) =>
      // Scaffold(
      //   //  backgroundColor: Colors.transparent,
      //   //           extendBodyBehindAppBar: true,
      //   // extendBodyBehindAppBar: true,
      //   // backgroundColor: Colors.red,
      //    backgroundColor: Colors.grey,

      Container(
        // color: Colors.grey.withOpacity(0.0),
        height: MediaQuery.of(context).size.height * 0.40,
        child: Column(
          children: <Widget>[
            Row(children: [
              Expanded(
                child: Container(
                  height: 30,

                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.monetization_on_rounded,
                        color: Colors.orange,
                        size: 18,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        model1.walletAmount.toString(),
                        style: secondaryTextStyle(color: Colors.white),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  // padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
                  color: Colors.black.withOpacity(0.3),
                  // decoration: BoxDecoration(color: Colors.grey.shade600, borderRadius: BorderRadius.circular(8.0)),
                  // margin: EdgeInsets.only(bottom: isLastMessageRight(index) ? 20.0 : 10.0, right: 10.0),
                ),
              ),
            ]),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: GridView.count(
                        crossAxisCount: 4,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1 / 1.3,
                        children: List.generate(
                            model.data.length,
                            (index) =>
                                buildGridleProduct(model.data[index], index)))),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  // width: 120,
                  // height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      // side: BorderSide(
                      //     width: 1.0,
                      //     style: BorderStyle.solid,
                      //     color: kPrimaryLightColor),
                      borderRadius: BorderRadius.all(Radius.circular(27.0)),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      DropdownButtonHideUnderline(
                        child: Theme(
                            data: Theme.of(context).copyWith(
                              canvasColor: Colors.grey.shade300,
                            ),
                            child: StatefulBuilder(
                              builder: (context, setState) {
                                return DropdownButton<String>(
                                    hint: Text(
                                      'اختر عضو',
                                      style: TextStyle(
                                          color: kPrimaryLightColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.grey,
                                    ),
                                    value: widget.check == true
                                        ? widget.username
                                        : newValue,
                                    items: List.generate(
                                        model3.data.length + 1,
                                        (index) => DropdownMenuItem(
                                            value: index < model3.data.length
                                                ? model3.data[index].name
                                                    .toString()
                                                : '-1',
                                            child: Center(
                                                child: Text(
                                              index < model3.data.length
                                                  ? model3.data[index].name
                                                  : 'اختيار الكل',
                                              style: TextStyle(
                                                  // fontSize: 10,
                                                  color: Colors.blue),
                                            )))),
                                    onChanged: (String value) {
                                      // newValue = newValue;
                                      print(value);
                                      setState(() {
                                        newValue = value;
                                        senduserId = model3.data[index].userId
                                            .toString();
                                        // String userid =
                                        // _getCitiesList();
                                        print(
                                            '________________________$newValue');
                                        print(senduserId);
                                        widget.check = false;
                                        // print(model2.userId.toString());
                                      });

                                      // HomeCubit.get(context).sendgift(
                                      //     id: widget.roomID,
                                      //     type: 'user',
                                      //     giftid: giftID,
                                      //     received: model2.userId,
                                      //     count: _controller.text);
                                      // CommonFunctions.showToast(
                                      //     "$newValueتم إرسال هديه الي",
                                      //     Colors.green);
                                    });
                              },
                            )
                            // DropdownButton<String>(
                            //   value: newValue,
                            //   iconSize: 30,
                            //   icon: (null),
                            //   style: TextStyle(
                            //     color: Colors.black54,
                            //     fontSize: 16,
                            //   ),
                            //   hint: Text('إرسال هدية'),
                            //   onChanged: (String value) {
                            //   setState(() {
                            //     newValue = value;
                            //     // _getCitiesList();
                            //     print(newValue);
                            //     // print(model2.userId.toString());
                            //   });

                            //   HomeCubit.get(context).sendgift(
                            //       id: widget.roomID,
                            //       type: 'user',
                            //       giftid: giftID,
                            //       received: model2.userId,
                            //       count: _controller.text);
                            //   // CommonFunctions.showToast(
                            //   //     "$newValueتم إرسال هديه الي", Colors.green);
                            // },
                            //   items: model3.data.map((value) {
                            //     // var units = <DropdownMenuItem>[];
                            //     for (int i = 0; i < model3.data.length; i++) {
                            //       DropdownMenuItem<String>(
                            //         value: value.userId.toString(),
                            //         child: Text(model3.data[i].name),
                            //       );
                            //     }
                            //     // return DropdownMenuItem<String>(
                            //     //   value: value.userId.toString(),
                            //     //   child: Text(model3.data[0].name),
                            //     // );
                            //   }).toList(),

                            //   //  items:
                            //   // model3.data.map((value) {
                            //   //   return DropdownMenuItem<String>(
                            //   //     value: value.userId.toString(),
                            //   //     child: Text(model3.data[0].name),
                            //   //   );
                            //   //  }).toList(),
                            // ),
                            ),
                      ),
                    ],
                  ),

                  // child: DropdownButtonHideUnderline(
                  //   child: DropdownButton<String>(
                  //     // hint: Padding(
                  //     //   padding: const EdgeInsets.only(left: 40.0),
                  //     //   child: Text(
                  //     //     'اختر عضو',
                  //     //     // style: TextStyle(fontSize: 12),
                  //     //   ),
                  //     // ),
                  //     items: model3.data.map((value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value.name,
                  //         child: Text(model3.data[index].name),
                  //       );
                  //     }).toList(),
                  //     onChanged: ( String value) {
                  //       setState(() {
                  //         value.name=value;
                  //       });
                  //     },
                  //   ),
                ),
                //   child: Container(
                //   child: DropdownButton<String>(
                //     items: model3.data.map((value) {
                //       return DropdownMenuItem<String>(
                //         value: value.name,
                //         child: Text(model2.name),
                //       );
                //     }).toList(),
                //     onChanged: (_) {},
                //   ),
                //   ),
                // ),

                // DropdownButton<String>(
                //   value: 've',
                //   icon: const Icon(Icons.arrow_downward),
                //   elevation: 16,
                //   style: const TextStyle(color: Colors.deepPurple),
                //   underline: Container(
                //     height: 2,
                //     color: Colors.deepPurpleAccent,
                //   ),
                //   onChanged: (String newValue) {
                //     setState(() {
                //       dropDownValue = newValue;
                //     });
                //   },
                //   items: inroomList.map<DropdownMenuItem<String>>((value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                // ),
                // UserSend(
                //   roomid: widget.roomID.toString(),
                // )
                // DropdownButtonHideUnderline(
                //     child: ButtonTheme(
                //   alignedDropdown: true,
                //   child: DropdownButton<String>(
                //     value: _mystate,
                //     iconSize: 30,
                //     icon: (null),
                //     style: TextStyle(color: Colors.black54, fontSize: 16),
                //     hint: Text("الجميع علي المايك"),
                //     onChanged: (String newvalue) {
                //       setState(() {
                //         _mystate = newvalue;

                //       });
                //     },
                //   ),
                // ))
                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: OutlinedButton(
                //       onPressed: () {
                //         widget.type = 'user';
                //         showModalBottomSheet(
                //             context: context,
                //             isScrollControlled: true,
                //             builder: (builder) {
                //               return UsersInroom(
                //                   roomID: widget.roomID.toString(),
                //                   type: widget.type,
                //                   giftId: giftID,
                //                   controller: _controller.text);
                //             });
                //       },
                //       style: ButtonStyle(
                //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30.0))),
                //       ),
                //       child: const Text(
                //         "ارسال للاعضاء",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     )),
                Spacer(),
                Container(
                  height: 40,
                  width: 60,
                  // color: Colors.blue,
                  child: InkWell(
                    child: new Container(
                      decoration: new BoxDecoration(
                        color: kPrimaryLightColor,
                        borderRadius: new BorderRadius.only(
                          bottomLeft: const Radius.circular(40.0),
                          topLeft: const Radius.circular(40.0),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        "إرسال",
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    onTap: () {
                      if (senduserId == null) {
                        senduserId = widget.userID.toString();
                      }
                      // print('userID is${widget.userID}');
                      // print('userID is${widget.check}');
                      print('userID is$senduserId');
                      print('giftID is$giftID');
                      print('roomId is${widget.roomID}');
                      print(_controller.text);
                      HomeCubit.get(context).sendgift(
                          id: widget.roomID,
                          type: 'user',
                          giftid: giftID,
                          received: senduserId.toInt(),
                          count: _controller.text);
                      giftID = '0';
                    },
                  ),
                ),

                Theme(
                  data: Theme.of(context)
                      .copyWith(splashColor: Colors.transparent),
                  child: Container(
                    width: 130,
                    height: 40,
                    child: TextFormField(
                      controller: _controller,
                      autofocus: false,
                      style:
                          TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        prefixIcon: IconButton(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            if (counter > 1) {
                              counter--;
                              _controller.text = counter.toString();
                              print(_controller.text);
                            }
                          },
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              counter++;
                              _controller.text = counter.toString();
                              print(_controller.text);
                            });
                          },
                        ),
                        // hintText: 'Username',
                        // contentPadding: const EdgeInsets.only(
                        //     left: 8.0, bottom: 8.0, top: 8.0),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: BorderSide(color: KstorebuttonColor),
                        //   borderRadius: BorderRadius.circular(25.7),
                        // ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: KstorebuttonColor),
                          borderRadius: new BorderRadius.only(
                            bottomRight: const Radius.circular(40.0),
                            topRight: const Radius.circular(40.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),

                /////////////////////////////////////////////////////////////////////////////
                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: OutlinedButton(
                //       onPressed: () {
                //         widget.type = 'room';
                //         print(widget.roomID);
                //         HomeCubit().sendgift(
                //           id: widget.roomID,
                //           type: widget.type,
                //           received: widget.roomID,
                //           count: _controller.text,
                //           giftid: giftID,
                //         );
                //       },
                //       style: ButtonStyle(
                //         shape: MaterialStateProperty.all(RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(30.0))),
                //       ),
                //       child: const Text(
                //         "ارسال للجميع",
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     )),
              ],
            )
          ],
        ),
      );

  // body: Padding(
  //   padding: const EdgeInsets.all(8.0),
  //   child: Container(
  //       child: Expanded(
  //     child: GridView.count(
  //         crossAxisCount: 6,
  //         mainAxisSpacing: 1.0,
  //         crossAxisSpacing: 1.0,
  //         childAspectRatio: 1 / 1.3,
  //         children: List.generate(model.data.length,
  //             (index) => buildGridleProduct(model.data[index]))),
  //   )),
  // ),
  // );

  Widget buildGridleProduct(GiftData model, int index) => Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                // ontap of each card, set the defined int to the grid view index
                selectedCard = index;

                giftID = model.id.toString();

                print(giftID);
              });
            },
            child: SizedBox(
              width: 90.0,
              height: 100.0,
              child: Container(
                  decoration: BoxDecoration(
                    color: selectedCard == index ? Colors.blue : Colors.white,
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8.0),
                        left: Radius.circular(8.0)),
                  ),
                  // check if the index is equal to the selected Card integer

                  child: Column(
                    children: [
                      Container(
                          height: 60,
                          // width: 200,
                          child: Column(
                            children: [
                              Image.network(
                                model.url,
                                width: 60,
                                height: 60,
                                // fit: BoxFit.fill,
                              ),
                            ],
                          )),
                      Spacer(),
                      Container(
                          height: 35,
                          decoration: BoxDecoration(
                            color: KstorebuttonColor,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                          ),
                          child: Center(child: Text(model.price.toString()))),
                    ],
                  )),
            ),
          ),

          // !pressGeoON
          //     ? InkWell(
          //         child: Container(
          //           width: 180,
          //           color: KstorebuttonColor,
          //           child: Center(
          //             child: Text(
          //               "شراء",
          //               style: TextStyle(color: Colors.white),
          //             ),
          //           ),
          //         ),
          //         onTap: () {
          //           setState(() {
          //             fimage = model.url;
          //             pressGeoON = !pressGeoON;
          //             // CacheHelper.saveData(key: 'frameimage', value: model.url);
          //           });
          //         },
          //       )
          //     : Container(
          //         width: 180,
          //         color: KstorebuttonColor,
          //         child: Center(
          //           child: Text(
          //             "done",
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       )
        ],
      );
}

// class GiftScreen extends StatelessWidget {
//   String roomID;
//   GiftScreen({this.roomID});
//   String dropDownValue = 'One';
//   String type;
//   String giftID;
//   final GlobalKey _menuKey = GlobalKey();
//   TextEditingController _controller;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..getGift(),
//       child: BlocConsumer<HomeCubit, HomeStates>(
//         listener: (context, state) {},
//         builder: (context, state) {
//           return ConditionalBuilder(
//             condition: HomeCubit.get(context).giftModel != null,
//             builder: (context) =>
//                 getIntresItem(HomeCubit.get(context).giftModel, context),
//             fallback: (context) => Container(
//               color: Colors.black.withOpacity(0.7),
//               child: Center(
//                 child: CircularProgressIndicator(),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget getIntresItem(GiftModel model, BuildContext context) => Scaffold(
//         backgroundColor: Colors.black.withOpacity(0.7),
//         body: Column(
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     child: GridView.count(
//                         crossAxisCount: 6,
//                         mainAxisSpacing: 1.0,
//                         crossAxisSpacing: 1.0,
//                         childAspectRatio: 1 / 1.3,
//                         children: List.generate(model.data.length,
//                             (index) => buildGridleProduct(model.data[index])))),
//               ),
//             ),
//             Row(
//               children: [
//                 Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         type = 'user';
//                         showModalBottomSheet(
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (builder) {
//                               return UsersInroom(
//                                   roomID: roomID.toString(),
//                                   type: type,
//                                   giftId: giftID);
//                             });
//                       },
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0))),
//                       ),
//                       child: const Text(
//                         "ارسال للاعضاء",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )),
//                 Theme(
//                   data: Theme.of(context)
//                       .copyWith(splashColor: Colors.transparent),
//                   child: Expanded(
//                     child: TextFormField(
//                       controller: _controller,
//                       autofocus: false,
//                       style:
//                           TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: white,
//                         prefixIcon: IconButton(
//                           icon: Icon(Icons.remove),
//                           onPressed: () {},
//                         ),
//                         suffixIcon: IconButton(
//                           icon: Icon(Icons.add),
//                           onPressed: () {
//                             _controller.text = '1'.toString();
//                           },
//                         ),
//                         // hintText: 'Username',
//                         contentPadding: const EdgeInsets.only(
//                             left: 14.0, bottom: 8.0, top: 8.0),
//                         focusedBorder: OutlineInputBorder(
//                           borderSide: BorderSide(color: KstorebuttonColor),
//                           borderRadius: BorderRadius.circular(25.7),
//                         ),
//                         enabledBorder: UnderlineInputBorder(
//                           borderSide: BorderSide(color: KstorebuttonColor),
//                           borderRadius: BorderRadius.circular(25.7),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: OutlinedButton(
//                       onPressed: () {
//                         type = 'room';
//                         print(roomID);
//                         HomeCubit()
//                             .sendgift(id: giftID, type: type, received: roomID);
//                       },
//                       style: ButtonStyle(
//                         shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30.0))),
//                       ),
//                       child: const Text(
//                         "ارسال للجميع",
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     )),
//               ],
//             )
//           ],
//         ),
//         // body: Padding(
//         //   padding: const EdgeInsets.all(8.0),
//         //   child: Container(
//         //       child: Expanded(
//         //     child: GridView.count(
//         //         crossAxisCount: 6,
//         //         mainAxisSpacing: 1.0,
//         //         crossAxisSpacing: 1.0,
//         //         childAspectRatio: 1 / 1.3,
//         //         children: List.generate(model.data.length,
//         //             (index) => buildGridleProduct(model.data[index]))),
//         //   )),
//         // ),
//       );

//   Widget buildGridleProduct(GiftData model) => Column(
//         children: [
//           InkWell(
//             child: ClipRRect(
//               borderRadius:
//                   BorderRadius.horizontal(right: Radius.circular(8.0)),
//               child: Image.network(
//                 model.url,
//                 height: 20,
//                 width: double.infinity,
//                 fit: BoxFit.fill,
//               ),
//             ),
//             onTap: () {
//               print(model.id);
//               giftID = model.id.toString();
//             },
//           ),
//           Container(child: Center(child: Text(model.price.toString()))),

//           // !pressGeoON
//           //     ? InkWell(
//           //         child: Container(
//           //           width: 180,
//           //           color: KstorebuttonColor,
//           //           child: Center(
//           //             child: Text(
//           //               "شراء",
//           //               style: TextStyle(color: Colors.white),
//           //             ),
//           //           ),
//           //         ),
//           //         onTap: () {
//           //           setState(() {
//           //             fimage = model.url;
//           //             pressGeoON = !pressGeoON;
//           //             // CacheHelper.saveData(key: 'frameimage', value: model.url);
//           //           });
//           //         },
//           //       )
//           //     : Container(
//           //         width: 180,
//           //         color: KstorebuttonColor,
//           //         child: Center(
//           //           child: Text(
//           //             "done",
//           //             style: TextStyle(color: Colors.white),
//           //           ),
//           //         ),
//           //       )
//         ],
//       );
// }

// return Scaffold(
//   appBar: PreferredSize(
//     preferredSize:
//         Size.fromHeight(40.0),
//     child: AppBar(
//       leadingWidth: double.infinity,
//       backgroundColor: Colors.black
//           .withOpacity(0.7),
//       leading: Padding(
//         padding:
//             const EdgeInsets.all(
//                 8.0),
//         child: Row(
//           children: [
//             Icon(
//               Icons
//                   .monetization_on_rounded,
//               size: 14,
//               color: Colors.blue,
//             ),
//             SizedBox(
//               width: 5,
//             ),
//             Text(
//               "17 ",
//               style: TextStyle(
//                   color:
//                       Colors.blue),
//             ),
//             Text(
//               "كسب كريستال ",
//               style: TextStyle(
//                   color:
//                       Colors.blue),
//             ),
//             // Icon(Icons.arrow_forward)
//           ],
//         ),
//       ),
//     ),
//   ),
//   body: Container(
//     width: double.infinity,
//     height: 400.0,
//     // color: Colors.black.withOpacity(0.7),
//     child: DefaultTabController(
//       length: 1,
//       child: Scaffold(
//         appBar: PreferredSize(
//             preferredSize:
//                 Size.fromHeight(
//                     30.0),
//             child: AppBar(
//               backgroundColor:
//                   Colors.black
//                       .withOpacity(
//                           0.7),
//               bottom: TabBar(
//                 tabs: [
//                   Text(
//                     "",
//                     style: TextStyle(
//                         color: Colors
//                             .white),
//                   ),
//                   // Text(
//                   //   "بريميم",
//                   //   style: TextStyle(
//                   //       color:
//                   //           Colors.white),
//                   // ),
//                   // Text(
//                   //   "vip",
//                   //   style: TextStyle(
//                   //       color:
//                   //           Colors.white),
//                   // ),
//                 ],
//               ),
//             )),
//         body: TabBarView(
//           children: [
//             GiftScreen(),
//             // Icon(
//             //     Icons.directions_transit),
//             // Icon(Icons.directions_bike),
//           ],
//         ),
//       ),
//     ),
//   ),
// );

// child: const Text('Show Dialog'),

// class UserSend extends StatefulWidget {
//   final String roomid;

//   UserSend({Key key, this.roomid});

//   @override
//   State<UserSend> createState() => _UserSendState();
// }

// class _UserSendState extends State<UserSend> {
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: <Widget>[
//         DropdownButtonHideUnderline(
//           child: ButtonTheme(
//             alignedDropdown: true,
//             child: DropdownButton<String>(
//               value: _myState,
//               iconSize: 30,
//               icon: (null),
//               style: TextStyle(
//                 color: Colors.black54,
//                 fontSize: 16,
//               ),
//               hint: Text('Select State'),
//               onChanged: (String newValue) {
//                 setState(() {
//                   _myState = newValue;
//                   _getStateList();
//                   print(_myState);
//                 });
//               },
//               items: statesList?.map((item) {
//                     return new DropdownMenuItem(
//                       child: new Text(item['name']),
//                       value: item['id'].toString(),
//                     );
//                   })?.toList() ??
//                   [],
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   List statesList;
//   String _myState;
//   InRoomUserModelModel roomUserModel;

//   Future<String> _getStateList() async {
//     await DioHelper.getdata(url: 'rooms/$id/users', token: token).then((value) {
//       var data = json.decode(value.data);
//       print(data);
//       setState(() {
//         statesList = data['state'];
//       });
//     });
// //     await http.post(stateInfoUrl, headers: {
// //       'Content-Type': 'application/x-www-form-urlencoded'
// //     }, body: {
// //       "api_key": '25d55ad283aa400af464c76d713c07ad',
// //     }).then((response) {
// //       var data = json.decode(response.body);

// // //      print(data);
// //       setState(() {
// //         statesList = data['state'];
// //       });
// //     });
//   }
// }

// List<InRoomUserModelModel> inroomList = [];

// void getroomuser({@required id}) {
//   emit(InroomLoadingStates());

//   DioHelper.getdata(url: 'rooms/$id/users', token: token).then((value) {
//     roomUserModel = InRoomUserModelModel.fromJson(value.data);
//     print(value.data);
//     // value.data.forEach((element) {
//     //   inroomList.add(InRoomUserModelModel.fromJson(element.data()));
//     // });

//     // print(notificationModel.fromuserid);
//     emit(InroomSuccessStates());
//   }).catchError((error) {
//     print(error.toString());
//     emit(InroomErrorState());
//   });
// }
