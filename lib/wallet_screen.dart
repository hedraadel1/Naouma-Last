import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:project/models/get_wallet_model.dart';
import 'package:project/payment/waletPayment.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/home/pages/home_tab.dart';
import 'package:project/view/home/states.dart';

import 'models/room_data_model.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final _firestoreInstance = FirebaseFirestore.instance;

  bool _haveARoom = false;
  bool _loadingRoom = true;
  List<RoomDataModel> _myRooms = [];
  String roomId;
  String roomName;
  String roomDesc;
  String hundred = '100';
  String thusent = '1000';
  String fifth = '5000';
  String twelv = '12000';
  String ffteen = '50000';

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => HomeCubit()..getWalletAmount(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: HomeCubit.get(context).getWalletModel != null,
            builder: (context) =>
                mybackgroundItem(HomeCubit.get(context).getWalletModel.data),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );

          // return new Scaffold(
          //     appBar: new PreferredSize(
          //         preferredSize:
          //             new Size(MediaQuery.of(context).size.width, 200.0),
          //         child: new Stack(
          //           alignment: const FractionalOffset(0.98, 1.12),
          //           children: <Widget>[
          //             new Container(
          //                 color: KstorebuttonColor,
          //                 child: new Column(
          //                   children: <Widget>[
          //                     new Container(
          //                         margin: const EdgeInsets.fromLTRB(
          //                             0.0, 20.0, 0.0, 0.0),
          //                         child: new Column(children: <Widget>[
          //                           new Row(
          //                             mainAxisAlignment:
          //                                 MainAxisAlignment.spaceBetween,
          //                             children: <Widget>[
          //                               new Row(
          //                                 children: <Widget>[
          //                                   new IconButton(
          //                                       icon: new Icon(
          //                                         Icons.arrow_back,
          //                                         color: Colors.white,
          //                                       ),
          //                                       onPressed: () {
          //                                         Navigator.pop(context, false);
          //                                       }),
          //                                 ],
          //                               ),
          //                             ],
          //                           ),
          //                         ])),
          //                   ],
          //                 )),
          //             Column(
          //               mainAxisAlignment: MainAxisAlignment.end,
          //               children: [
          //                 Container(
          //                   child: Text(
          //                     HomeCubit.get(context)
          //                         .getWalletModel
          //                         .data
          //                         .walletAmount
          //                         .toString(),
          //                     style: TextStyle(
          //                         color: Colors.white,
          //                         fontSize: 22,
          //                         fontWeight: FontWeight.w700),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 25,
          //                 ),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     new FloatingActionButton(
          //                       onPressed: () {
          //                         print("floating button Tapped");
          //                       },
          //                       child: Icon(
          //                         Icons.monetization_on_rounded,
          //                         color: Colors.orange,
          //                         size: 50,
          //                       ),
          //                     ),
          //                   ],
          //                 )
          //               ],
          //             )
          //           ],
          //         )),
          //     body: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         InkWell(
          //           child: Container(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: IconButton(
          //                       iconSize: 30,
          //                       icon: Icon(Icons.monetization_on_rounded,
          //                           color: Colors.orange),
          //                       onPressed: () {}),
          //                 ),
          //                 Text("100"),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Container(
          //                     width: 130,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: KstorebuttonColor,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(16.0)),
          //                     ),
          //                     child: TextButton(
          //                         onPressed: () {},
          //                         child: Text(
          //                           "USD 0.99",
          //                           style: TextStyle(color: Colors.white),
          //                         )),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           onTap: () {
          //             WalletCubit.get(context).PostWallet(amount: 100);
          //             setState(() {
          //               HomeCubit.get(context)
          //                   .getWalletModel
          //                   .data
          //                   .walletAmount += 100;
          //               // walletamount = WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString();
          //               // print(WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString());
          //             });
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         InkWell(
          //           child: Container(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: IconButton(
          //                       iconSize: 30,
          //                       icon: Icon(Icons.monetization_on_rounded,
          //                           color: Colors.orange),
          //                       onPressed: () {}),
          //                 ),
          //                 Text("1,000"),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Container(
          //                     width: 130,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: KstorebuttonColor,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(16.0)),
          //                     ),
          //                     child: TextButton(
          //                         onPressed: () {},
          //                         child: Text(
          //                           "USD 8.99",
          //                           style: TextStyle(color: Colors.white),
          //                         )),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           onTap: () {
          //             WalletCubit.get(context).PostWallet(amount: 1000);
          //             setState(() {
          //               HomeCubit.get(context)
          //                   .getWalletModel
          //                   .data
          //                   .walletAmount += 1000;
          //               // walletamount = WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString();
          //               // print(WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString());
          //             });
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         InkWell(
          //           child: Container(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: IconButton(
          //                       iconSize: 30,
          //                       icon: Icon(Icons.monetization_on_rounded,
          //                           color: Colors.orange),
          //                       onPressed: () {}),
          //                 ),
          //                 Text("5,000"),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Container(
          //                     width: 130,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: KstorebuttonColor,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(16.0)),
          //                     ),
          //                     child: TextButton(
          //                         onPressed: () {},
          //                         child: Text(
          //                           "USD 43.99",
          //                           style: TextStyle(color: Colors.white),
          //                         )),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           onTap: () {
          //             WalletCubit.get(context).PostWallet(amount: 5000);
          //             setState(() {
          //               HomeCubit.get(context)
          //                   .getWalletModel
          //                   .data
          //                   .walletAmount += 5000;
          //               // walletamount = WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString();
          //               // print(WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString());
          //             });
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         InkWell(
          //           child: Container(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: IconButton(
          //                       iconSize: 30,
          //                       icon: Icon(Icons.monetization_on_rounded,
          //                           color: Colors.orange),
          //                       onPressed: () {}),
          //                 ),
          //                 Text("12,000"),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Container(
          //                     width: 130,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: KstorebuttonColor,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(16.0)),
          //                     ),
          //                     child: TextButton(
          //                         onPressed: () {},
          //                         child: Text(
          //                           "USD 99.99",
          //                           style: TextStyle(color: Colors.white),
          //                         )),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           onTap: () {
          //             WalletCubit.get(context).PostWallet(amount: 12000);
          //             setState(() {
          //               HomeCubit.get(context)
          //                   .getWalletModel
          //                   .data
          //                   .walletAmount += 12000;
          //               // walletamount = WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString();
          //               // print(WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString());
          //             });
          //           },
          //         ),
          //         SizedBox(
          //           height: 20,
          //         ),
          //         InkWell(
          //           child: Container(
          //             child: Row(
          //               children: [
          //                 Container(
          //                   child: IconButton(
          //                       iconSize: 30,
          //                       icon: Icon(Icons.monetization_on_rounded,
          //                           color: Colors.orange),
          //                       onPressed: () {}),
          //                 ),
          //                 Text("50,000"),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(10.0),
          //                   child: Container(
          //                     width: 130,
          //                     height: 35,
          //                     decoration: BoxDecoration(
          //                       color: KstorebuttonColor,
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(16.0)),
          //                     ),
          //                     child: TextButton(
          //                         onPressed: () {},
          //                         child: Text(
          //                           "USD 399.99",
          //                           style: TextStyle(color: Colors.white),
          //                         )),
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //           onTap: () {
          //             WalletCubit.get(context).PostWallet(amount: 50000);
          //             setState(() {
          //               HomeCubit.get(context)
          //                   .getWalletModel
          //                   .data
          //                   .walletAmount += 50000;
          //               // walletamount = WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString();
          //               // print(WalletCubit.get(context)
          //               //     .postWalletModel
          //               //     .walletAmount
          //               //     .toString());
          //             });
          //           },
          //         ),
          //       ],
          //     ));
        },
      ),
    );
  }

  Widget mybackgroundItem(GetWalletData model) {
    return new Scaffold(
        appBar: new PreferredSize(
            preferredSize: new Size(MediaQuery.of(context).size.width, 200.0),
            child: new Stack(
              alignment: const FractionalOffset(0.98, 1.12),
              children: <Widget>[
                new Container(
                    color: KstorebuttonColor,
                    child: new Column(
                      children: <Widget>[
                        new Container(
                            margin:
                                const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                            child: new Column(children: <Widget>[
                              new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  new Row(
                                    children: <Widget>[
                                      new IconButton(
                                          icon: new Icon(
                                            Icons.arrow_back,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Get.to(HomeScreen());
                                            // Navigator.pop(context, false);
                                          }),
                                    ],
                                  ),
                                ],
                              ),
                            ])),
                      ],
                    )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        model.walletAmount.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        new FloatingActionButton(
                          onPressed: () {
                            print("floating button Tapped");
                          },
                          child: Icon(
                            Icons.monetization_on_rounded,
                            color: Colors.orange,
                            size: 50,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            )),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.monetization_on_rounded,
                              color: Colors.orange),
                          onPressed: () {}),
                    ),
                    Text("100"),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          color: KstorebuttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "USD 0.99",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.to(WalletPayment(
                  coins: hundred,
                ));
                //  HomeCubit.get(context).postWallet(amount: 100);
                // setState(() {
                //   model.walletAmount += 100;
                //   //   // walletamount = HomeCubit.get(context)
                //   //   //     .postWalletModel
                //   //   //     .walletAmount
                //   //   //     .toString();
                //   //   // print(HomeCubit.get(context)
                //   //   //     .postWalletModel
                //   //   //     .walletAmount
                //   //   //     .toString());
                // });
                // totalWalletAmount = model.walletAmount.toDouble();
                print(totalWalletAmount);
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.monetization_on_rounded,
                              color: Colors.orange),
                          onPressed: () {}),
                    ),
                    Text("1,000"),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          color: KstorebuttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "USD 8.99",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.to(WalletPayment(
                  coins: thusent,
                ));
                // HomeCubit.get(context).postWallet(amount: 1000);
                // setState(() {
                //   model.walletAmount += 1000;
                //   // walletamount = WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString();
                //   // print(WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString());
                // });
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.monetization_on_rounded,
                              color: Colors.orange),
                          onPressed: () {}),
                    ),
                    Text("5,000"),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          color: KstorebuttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "USD 43.99",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.to(WalletPayment(
                  coins: fifth,
                ));
                // HomeCubit.get(context).postWallet(amount: 5000);
                // setState(() {
                //   model.walletAmount += 5000;
                //   // walletamount = WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString();
                //   // print(WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString());
                // });
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.monetization_on_rounded,
                              color: Colors.orange),
                          onPressed: () {}),
                    ),
                    Text("12,000"),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          color: KstorebuttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "USD 99.99",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.to(WalletPayment(
                  coins: twelv,
                ));
                // HomeCubit.get(context).postWallet(amount: 12000);
                // setState(() {
                //   model.walletAmount += 12000;
                //   // walletamount = WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString();
                //   // print(WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString());
                // });
              },
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              child: Container(
                child: Row(
                  children: [
                    Container(
                      child: IconButton(
                          iconSize: 30,
                          icon: Icon(Icons.monetization_on_rounded,
                              color: Colors.orange),
                          onPressed: () {}),
                    ),
                    Text("50,000"),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        width: 130,
                        height: 35,
                        decoration: BoxDecoration(
                          color: KstorebuttonColor,
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              "USD 399.99",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  ],
                ),
              ),
              onTap: () {
                Get.to(WalletPayment(
                  coins: ffteen,
                ));
                // HomeCubit.get(context).postWallet(amount: 50000);
                // setState(() {
                //   model.walletAmount += 50000;
                //   // walletamount = WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString();
                //   // print(WalletCubit.get(context)
                //   //     .postWalletModel
                //   //     .walletAmount
                //   //     .toString());
                // });
              },
            ),
          ],
        ));
  }
  // Widget _createRoomSlide(var theme) {
  //   return SingleChildScrollView(
  //     child: GestureDetector(
  //       onTap: () {
  //         print("create room clicked");
  //         // Get.to(CreateRoomScreen());
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         margin:
  //             const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 52),
  //         padding: const EdgeInsets.all(8.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //         ),
  //         child: Row(
  //           children: [
  //             CircleAvatar(
  //               backgroundColor: kPrimaryColor,
  //               child: Icon(
  //                 Icons.add,
  //                 color: Colors.white,
  //                 size: 28,
  //               ),
  //               radius: 30,
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     "إنشاء غرفة",
  //                     style: theme.textTheme.bodyText1.copyWith(fontSize: 16.0),
  //                     textAlign: TextAlign.start,
  //                   ),
  //                   Text(
  //                     "ابدأ رحلتك فى نعومة !",
  //                     style: theme.textTheme.bodyText2.copyWith(fontSize: 15.0),
  //                     textAlign: TextAlign.start,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Icon(
  //               Icons.flag,
  //               color: Colors.orange,
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

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

  // Widget _myRoom(String roomId, String roomName, String roomDesc) {
  //   return GestureDetector(
  //     onTap: () {
  //       print("roomDetails");
  //       Get.to(DetailsScreen(
  //         roomId: roomId,
  //         roomName: roomName,
  //         roomDesc: roomDesc,
  //         roomOwnerId: PreferencesServices.getString(ID_KEY),
  //       ));
  //     },
  //     child: SingleChildScrollView(
  //       child: Container(
  //         width: double.infinity,
  //         margin:
  //             const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 52),
  //         padding: const EdgeInsets.all(8.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
  //         ),
  //         child: Row(
  //           children: [
  //             CircleAvatar(
  //               backgroundColor: kPrimaryColor,
  //               child: Image.asset(kDefaultProfileImage),
  //               radius: 35,
  //             ),
  //             SizedBox(width: 10),
  //             Expanded(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Text(
  //                     roomName,
  //                     style: TextStyle(color: Colors.black, fontSize: 16.0),
  //                     textAlign: TextAlign.start,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                   Text(
  //                     roomDesc,
  //                     style: TextStyle(color: Colors.black, fontSize: 15.0),
  //                     textAlign: TextAlign.start,
  //                     maxLines: 1,
  //                     overflow: TextOverflow.ellipsis,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
