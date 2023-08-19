/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:ui';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/store_screen.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/wallet_screen.dart';

import 'models/specialRoomID_model.dart';

class PrivteId_screen extends StatefulWidget {
  const PrivteId_screen({Key key}) : super(key: key);

  @override
  State<PrivteId_screen> createState() => _PrivteId_screenState();
}

class _PrivteId_screenState extends State<PrivteId_screen> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        //  ShopCubit.get(context).specialRoomID();
        ShopCubit.get(context).getWalletAmount();

        return BlocConsumer<ShopCubit, ShopIntresStates>(
          listener: (context, state) {
            if (state is PersonalPurchaseIDSuccessStates) {
              ShopCubit.get(context).specialRoomID();
              ShopCubit.get(context).getWalletAmount();
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: ShopCubit.get(context).specialRoomIDModel != null,
              builder: (context) => getIDItem(
                  ShopCubit.get(context).specialRoomIDModel,
                  ShopCubit.get(context).getWalletModel),
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Widget build(BuildContext context) {
  //   return BlocProvider(
  //     create: (context) => ShopCubit()..specialRoomID(),
  //     child: BlocConsumer<ShopCubit, ShopIntresStates>(
  //       listener: (context, state) {},
  //       builder: (context, state) {
  //         return ConditionalBuilder(
  //           condition: ShopCubit.get(context).specialRoomIDModel != null,
  //           builder: (context) =>
  //               getIDItem(ShopCubit.get(context).specialRoomIDModel),
  //           fallback: (context) => Container(
  //             color: Colors.white,
  //             child: Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget getIDItem(SpecialRoomIDModel model, GetWalletModel model1) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100.0),
          child: AppBar(
            // leading: IconButton(
            //   onPressed: () {
            //     Get.to(PrivteId_screen());
            //   },
            //   icon: Icon(Icons.arrow_back_ios),
            // ),
            backgroundColor: Colors.white,
            title: Text("أي دي غرفة مميز"),
            centerTitle: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "ابحث عن ايديات غرفة مميزة",
                            contentPadding: EdgeInsets.all(5.0),
                            fillColor: kinput),
                      ),
                    )),
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Text(
                        "آي دي غرفتي",
                        style: TextStyle(color: Colors.grey),
                      )),
                    ),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        child: Text(
                      "1261121254",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                    SizedBox(
                      width: 20,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        // Container(
                        //   child: TabBar(
                        //     labelColor: Colors.black,
                        //     unselectedLabelColor: Colors.grey,
                        //     indicatorColor: kPrimaryColor,
                        //     tabs: [
                        //       Text(
                        //         "شائع",
                        //       ),
                        //       Text(
                        //         "خماسي ",
                        //       ),
                        //       Text(
                        //         "مزدوج",
                        //       ),
                        //       Text(
                        //         "مكرر",
                        //       ),
                        //       Text(
                        //         "متواسط",
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        Container(
                          height: 508, //height of TabBarView
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        width: 120,
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor.withOpacity(0.2),
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10),
                                          ),

                                          // shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                            child: Text(
                                          "أفضل آيديات مميزة",
                                          style: TextStyle(
                                              color: kPrimaryColor,
                                              fontSize: 14),
                                        ))),
                                  )
                                ],
                              ),
                              Container(
                                  child: Expanded(
                                child: GridView.count(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 1.0,
                                    crossAxisSpacing: 1.0,
                                    childAspectRatio: 1 / 0.5,
                                    children: List.generate(model.data.length,
                                        (index) => items(model.data[index]))),
                              )),
                            ],
                          ),
                        )
                      ]),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                  icon:
                      Icon(Icons.monetization_on_rounded, color: Colors.orange),
                  onPressed: () {}),
              Text(
                model1.data.walletAmount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletScreen()),
                      );
                    },
                    child: Text(
                      "< الشحن",
                      style: TextStyle(color: kPrimaryColor),
                    )),
              )
            ],
          ),
        ),
      );

  Widget items(SpecialRoomIDModelData model) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),

              // shape: BoxShape.circle,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 30,
                      decoration: BoxDecoration(color: Colors.amber),
                      child: Image.asset("assets/icons/id.png"),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.value.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.pink),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.monetization_on_rounded, color: Colors.orange),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        model.price.toString(),
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => Directionality(
                textDirection: TextDirection.rtl,
                child: AlertDialog(
                  title: Center(child: const Text('هل تريد شراء  ID ')),

                  // content: const Text('AlertDialog description'),
                  actions: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .purchaseRoomlID(id: model.id);
                            ShopCubit.get(context).getWalletAmount();
                            Navigator.pop(context, 'yes');

                            CommonFunctions.showToast(
                                'تم شراء ID مميز للغرفة', Colors.green);

                            // Navigator.of(context).push(new MaterialPageRoute(
                            //     builder: (context) => PrivteId_screen()));
                          },
                          child: const Text('نعم'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'no'),
                          child: const Text('لا'),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
}

//  return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(100.0),
//           child: AppBar(
//             backgroundColor: Colors.white,
//             title: Text("أي دي غرفة مميز"),
//             centerTitle: true,
//             bottom: PreferredSize(
//               preferredSize: Size.fromHeight(30.0),
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                     height: 30,
//                     alignment: Alignment.center,
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     child: Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: TextField(
//                         decoration: InputDecoration(
//                             prefixIcon: Icon(Icons.search),
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(10.0),
//                             ),
//                             filled: true,
//                             hintStyle: TextStyle(color: Colors.grey[800]),
//                             hintText: "ابحث عن ايديات غرفة مميزة",
//                             contentPadding: EdgeInsets.all(5.0),
//                             fillColor: kinput),
//                       ),
//                     )),
//               ),
//             ),
//           ),
//         ),
//         body: ListView(
//           children: [
//             Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                           child: Text(
//                         "آي دي غرفتي",
//                         style: TextStyle(color: Colors.grey),
//                       )),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     )
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                         child: Text(
//                       "1261121254",
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20),
//                     )),
//                     SizedBox(
//                       width: 20,
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Directionality(
//                   textDirection: TextDirection.rtl,
//                   child: DefaultTabController(
//                       length: 5, // length of tabs
//                       initialIndex: 0,
//                       child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: <Widget>[
//                             Container(
//                               child: TabBar(
//                                 labelColor: Colors.black,
//                                 unselectedLabelColor: Colors.grey,
//                                 indicatorColor: kPrimaryColor,
//                                 tabs: [
//                                   Text(
//                                     "شائع",
//                                   ),
//                                   Text(
//                                     "خماسي ",
//                                   ),
//                                   Text(
//                                     "مزدوج",
//                                   ),
//                                   Text(
//                                     "مكرر",
//                                   ),
//                                   Text(
//                                     "متواسط",
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                                 height: 508, //height of TabBarView
//                                 decoration: BoxDecoration(
//                                     border: Border(
//                                         top: BorderSide(
//                                             color: Colors.grey, width: 0.5))),
//                                 child: TabBarView(children: <Widget>[
//                                   Column(
//                                     children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(
//                                         children: [
//                                           Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Container(
//                                                 width: 120,
//                                                 decoration: BoxDecoration(
//                                                   color: kPrimaryColor
//                                                       .withOpacity(0.2),
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                     topRight:
//                                                         Radius.circular(10),
//                                                     bottomRight:
//                                                         Radius.circular(10),
//                                                     bottomLeft:
//                                                         Radius.circular(10),
//                                                     topLeft:
//                                                         Radius.circular(10),
//                                                   ),

//                                                   // shape: BoxShape.circle,
//                                                 ),
//                                                 child: Center(
//                                                     child: Text(
//                                                   "أفضل آيديات مميزة",
//                                                   style: TextStyle(
//                                                       color: kPrimaryColor,
//                                                       fontSize: 14),
//                                                 ))),
//                                           )
//                                         ],
//                                       ),
//                                       Container(
//                                           child: Expanded(
//                                         child: GridView.count(
//                                             crossAxisCount: 2,
//                                             mainAxisSpacing: 1.0,
//                                             crossAxisSpacing: 1.0,
//                                             childAspectRatio: 1 / 0.5,
//                                             children: List.generate(
//                                                 10,
//                                                 (index) => Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Container(
//                                                         decoration:
//                                                             BoxDecoration(
//                                                           color: Colors.amber,
//                                                           borderRadius:
//                                                               BorderRadius.only(
//                                                             topRight:
//                                                                 Radius.circular(
//                                                                     10),
//                                                             bottomRight:
//                                                                 Radius.circular(
//                                                                     10),
//                                                             bottomLeft:
//                                                                 Radius.circular(
//                                                                     10),
//                                                             topLeft:
//                                                                 Radius.circular(
//                                                                     10),
//                                                           ),

//                                                           // shape: BoxShape.circle,
//                                                         ),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               mainAxisAlignment:
//                                                                   MainAxisAlignment
//                                                                       .center,
//                                                               children: [
//                                                                 Container(
//                                                                   height: 40,
//                                                                   width: 30,
//                                                                   decoration:
//                                                                       BoxDecoration(
//                                                                           color:
//                                                                               Colors.amber),
//                                                                   child: Image
//                                                                       .asset(
//                                                                           "assets/icons/id.png"),
//                                                                 ),
//                                                                 SizedBox(
//                                                                   width: 5,
//                                                                 ),
//                                                                 Text(
//                                                                   "2222222",
//                                                                   style: TextStyle(
//                                                                       fontSize:
//                                                                           18,
//                                                                       color: Colors
//                                                                           .pink),
//                                                                 ),
//                                                               ],
//                                                             ),
//                                                             Spacer(),
//                                                             Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .center,
//                                                                 children: [
//                                                                   Icon(
//                                                                       Icons
//                                                                           .monetization_on_rounded,
//                                                                       color: Colors
//                                                                           .orange),
//                                                                   SizedBox(
//                                                                     width: 5,
//                                                                   ),
//                                                                   Text(
//                                                                     "1000,000",
//                                                                     style: TextStyle(
//                                                                         fontSize:
//                                                                             12,
//                                                                         color: Colors
//                                                                             .black),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ))),
//                                       )),
//                                     ],
//                                   ),
//                                   Container(
//                                     child: Center(
//                                       child: Text('Display Tab 2',
//                                           style: TextStyle(
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Center(
//                                       child: Text('Display Tab 3',
//                                           style: TextStyle(
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Center(
//                                       child: Text('Display Tab 4',
//                                           style: TextStyle(
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                   ),
//                                   Container(
//                                     child: Center(
//                                       child: Text('Display Tab 4',
//                                           style: TextStyle(
//                                               fontSize: 22,
//                                               fontWeight: FontWeight.bold)),
//                                     ),
//                                   ),
//                                 ]))
//                           ])),
//                 ),
//               ],
//             ),
//           ],
//         ));
