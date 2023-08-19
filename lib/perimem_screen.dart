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
import 'package:project/common_functions.dart';
import 'package:project/models/permeim_model.dart';
import 'package:project/network/cache_helper.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';

class PerimemScreen extends StatefulWidget {
  const PerimemScreen({Key key}) : super(key: key);

  @override
  State<PerimemScreen> createState() => _PerimemScreenState();
}

class _PerimemScreenState extends State<PerimemScreen> {
  int shahm;
  String num = '2100';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopIntresStates>(
      listener: (context, state) {
        if (state is PermemSuccessStates) {
          CacheHelper.saveData(
                  key: 'color', value: state.permiemModel.data.first.color)
              .then((value) {
            permColor = state.permiemModel.data.first.color;
            hasperm = true;

            // print(username);
            // Get.to(HomeScreen());
          });
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).permiemModel != null,
          builder: (context) =>
              getIntresItem(ShopCubit.get(context).permiemModel),
          fallback: (context) => Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );

    // return Scaffold(
    //   backgroundColor: Colors.grey.shade300,
    //   appBar: AppBar(
    //     centerTitle: true,
    //     title: Text("يلا بريميم", style: TextStyle(color: Colors.white)),
    //   ),
    //   body: Column(
    //     children: [
    //       Container(
    //           color: Colors.white,
    //           width: double.infinity,
    //           height: 60,
    //           child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   children: [
    //                     Container(
    //                       width: 30,
    //                       child: CircleAvatar(
    //                         radius: 30.0,
    //                         backgroundImage: NetworkImage(
    //                             "https://images.unsplash.com/photo-1547665979-bb809517610d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=675&q=80"),
    //                         backgroundColor: Colors.transparent,
    //                       ),
    //                     ),
    //                     // Container(
    //                     //   width: 40,
    //                     //   child: Image.asset(
    //                     //     "assets/images/Profile Image.png",
    //                     //     fit: BoxFit.cover,
    //                     //   ),
    //                     // ),
    //                     SizedBox(
    //                       width: 20,
    //                     ),
    //                     Text(".انت لست عضو في يلا بريميم حتي الان",
    //                         style: TextStyle(color: Colors.grey))
    //                   ] // Front image],
    //                   ))),
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Container(
    //         width: double.infinity,
    //         height: 482.5,
    //         // color: Colors.black.withOpacity(0.7),
    //         child: DefaultTabController(
    //           length: 2,
    //           child: Scaffold(
    //               appBar: PreferredSize(
    //                   preferredSize: Size.fromHeight(28.0),
    //                   child: AppBar(
    //                     backgroundColor: Colors.white,
    //                     bottom: TabBar(
    //                       indicator: BoxDecoration(
    //                         color: KstorebuttonColor,
    //                         borderRadius: BorderRadius.all(
    //                           Radius.circular(5),
    //                         ),
    //                       ),
    //                       // indicatorWeight: 5,
    //                       // indicatorPadding: EdgeInsets.only(top: 40),
    //                       tabs: [
    //                         InkWell(
    //                           child: Container(
    //                             child: Text(
    //                               "الشهم",
    //                               style: TextStyle(color: Colors.grey),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             setState(() {
    //                               num = '2100';
    //                             });
    //                           },
    //                         ),
    //                         InkWell(
    //                           child: Container(
    //                             child: Text(
    //                               "الفارس",
    //                               style: TextStyle(color: Colors.grey),
    //                             ),
    //                           ),
    //                           onTap: () {
    //                             setState(() {
    //                               num = '4500';
    //                             });
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                   )),
    //               body: TabBarView(
    //                 children: [
    //                   // Icon(Icons.directions_transit),
    //                   ListView(children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(20.0),
    //                       child: Column(children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               width: 100,
    //                               child: Image.asset(
    //                                 "assets/icons/prem.png",
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                         Container(
    //                           child: Text(
    //                             "الشهم",
    //                             style: TextStyle(fontSize: 16),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                         GridView.count(
    //                           physics: NeverScrollableScrollPhysics(),
    //                           shrinkWrap: true,
    //                           primary: false,
    //                           padding: const EdgeInsets.all(20),
    //                           crossAxisSpacing: 10,
    //                           mainAxisSpacing: 10,
    //                           crossAxisCount: 2,
    //                           children: <Widget>[
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.card_giftcard,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "شارة بريميم",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "شارة الشهم الحصرية",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.record_voice_over,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "دخول بالمؤثرات",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "ادخل الغرفه مع تاثيرات مبهرة",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )
    //                                 // color: Colors.teal[200],
    //                                 ),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.chat_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "اسم ملوّن",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "اسم ملوّن عند إرسال الرسائل",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 ),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "في الغرف",
    //                                         style:
    //                                             TextStyle(color: Colors.grey),
    //                                       ),
    //                                     ]),
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.send_and_archive,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "ارسال الصور",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "ارسال الصور في الغرفة",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.border_outer_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "مفاجأه الترتيب",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "الصف الامامي لقائمه المستخدمين ",
    //                                         style: TextStyle(
    //                                             color: Colors.grey,
    //                                             fontSize: 12),
    //                                       ),
    //                                     ]),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         " المتواجدين في الغرفة",
    //                                         style: TextStyle(
    //                                             color: Colors.grey,
    //                                             fontSize: 12),
    //                                       ),
    //                                     ]),
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.post_add_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "تفعيل / تجديد المنشور",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "منشور النظام للتفعيل / التجديد",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.wallet_giftcard,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "هدايا حصرية",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "هدايا حصريه لاعضاء يلا بريميم",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.margin,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "القبعات الحصرية",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "قبعات حصريه لأعضاء يلا بريميم",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "موضوع الغرفة المخصص",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "قم بتعين موضوع للغرفه ",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "المخصص لاظهار اسلوبك",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركه",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "خاصة بالمايك",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركة خاصة",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "بالمايك عندما تتحدث",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: Colors.grey,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركه حصرية",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600,
    //                                           fontSize: 13),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: Colors.grey,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "سقف الاصدقاء",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600,
    //                                       fontSize: 13),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: Colors.grey,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "سقف المتابعة",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600,
    //                                       fontSize: 13),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                           ],
    //                         ),
    //                       ]),
    //                     ),
    //                   ]),

    //                   ListView(children: [
    //                     Padding(
    //                       padding: const EdgeInsets.all(20.0),
    //                       child: Column(children: [
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           crossAxisAlignment: CrossAxisAlignment.start,
    //                           children: [
    //                             Container(
    //                               width: 100,
    //                               child: Image.asset(
    //                                 "assets/icons/prem1.png",
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                         Container(
    //                           child: Text(
    //                             "الفارس",
    //                             style: TextStyle(fontSize: 16),
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: 20,
    //                         ),
    //                         GridView.count(
    //                           physics: NeverScrollableScrollPhysics(),
    //                           shrinkWrap: true,
    //                           primary: false,
    //                           padding: const EdgeInsets.all(20),
    //                           crossAxisSpacing: 10,
    //                           mainAxisSpacing: 10,
    //                           crossAxisCount: 2,
    //                           children: <Widget>[
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.card_giftcard,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "شارة بريميم",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "شارة الشهم الحصرية",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.record_voice_over,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "دخول بالمؤثرات",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "ادخل الغرفه مع تاثيرات مبهرة",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )
    //                                 // color: Colors.teal[200],
    //                                 ),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.chat_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "اسم ملوّن",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "اسم ملوّن عند إرسال الرسائل",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 ),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "في الغرف",
    //                                         style:
    //                                             TextStyle(color: Colors.grey),
    //                                       ),
    //                                     ]),
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.send_and_archive,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "ارسال الصور",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Text(
    //                                   "ارسال الصور في الغرفة",
    //                                   style: TextStyle(color: Colors.grey),
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.border_outer_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "مفاجأه الترتيب",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         "الصف الامامي لقائمه المستخدمين ",
    //                                         style: TextStyle(
    //                                             color: Colors.grey,
    //                                             fontSize: 12),
    //                                       ),
    //                                     ]),
    //                                 Row(
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.center,
    //                                     children: [
    //                                       Text(
    //                                         " المتواجدين في الغرفة",
    //                                         style: TextStyle(
    //                                             color: Colors.grey,
    //                                             fontSize: 12),
    //                                       ),
    //                                     ]),
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.post_add_rounded,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "تفعيل / تجديد المنشور",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "منشور النظام للتفعيل / التجديد",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.wallet_giftcard,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "هدايا حصرية",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "هدايا حصريه لاعضاء يلا بريميم",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.margin,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "القبعات الحصرية",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "قبعات حصريه لأعضاء يلا بريميم",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "موضوع الغرفة المخصص",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "قم بتعين موضوع للغرفه ",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "المخصص لاظهار اسلوبك",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركه",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "خاصة بالمايك",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركة خاصة",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "بالمايك عندما تتحدث",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Row(
    //                                   children: [
    //                                     Text(
    //                                       "رموز تعبيرية متحركه حصرية",
    //                                       style: TextStyle(
    //                                           fontWeight: FontWeight.w600,
    //                                           fontSize: 13),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "سقف الاصدقاء",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600,
    //                                       fontSize: 13),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                             Container(
    //                                 child: Column(
    //                               mainAxisAlignment: MainAxisAlignment.start,
    //                               children: [
    //                                 Icon(
    //                                   Icons.queue_play_next,
    //                                   size: 40,
    //                                   color: kPrimaryColor,
    //                                 ),
    //                                 SizedBox(
    //                                   height: 10,
    //                                 ),
    //                                 Text(
    //                                   "سقف المتابعة",
    //                                   style: TextStyle(
    //                                       fontWeight: FontWeight.w600,
    //                                       fontSize: 13),
    //                                 ),
    //                                 Row(
    //                                   mainAxisAlignment:
    //                                       MainAxisAlignment.center,
    //                                   children: [
    //                                     Text(
    //                                       "متوفر فقط الفارس و ما فوق",
    //                                       style: TextStyle(
    //                                           color: Colors.grey, fontSize: 12),
    //                                     )
    //                                   ],
    //                                 )
    //                               ],
    //                             )),
    //                           ],
    //                         ),
    //                       ]),
    //                     ),
    //                   ]),
    //                 ],
    //               )),
    //         ),
    //       ),
    //       Container(
    //         height: 110,
    //         child: BottomAppBar(
    //           child: Padding(
    //             padding: const EdgeInsets.all(5.0),
    //             child: Column(
    //               children: [
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text("قطعه ذهبيه كل شهر",
    //                         style: TextStyle(color: Colors.grey)),
    //                     Text(
    //                       num,
    //                       style: TextStyle(
    //                         color: Colors.red,
    //                       ),
    //                     ),
    //                     Text(
    //                       "اشترك للحصول علي ",
    //                       style: TextStyle(color: Colors.grey),
    //                     ),
    //                   ],
    //                 ),
    //                 Container(
    //                   height: 25,
    //                   width: 280,
    //                   decoration: BoxDecoration(
    //                     color: KstorebuttonColor,
    //                     borderRadius: BorderRadius.only(
    //                       topLeft: Radius.circular(20),
    //                       topRight: Radius.circular(20),
    //                       bottomLeft: Radius.circular(20),
    //                       bottomRight: Radius.circular(20),
    //                     ),
    //                   ),
    //                   child: Center(
    //                       child: Text(
    //                     "شهر /USD19.99الاشتراك في",
    //                     style: TextStyle(
    //                         color: Colors.white, fontWeight: FontWeight.w700),
    //                   )),
    //                 ),
    //                 Container(
    //                     child: Text(
    //                   "استعاده المشتريات",
    //                   style: TextStyle(
    //                     fontSize: 12,
    //                     fontWeight: FontWeight.w600,
    //                     decoration: TextDecoration.underline,
    //                   ),
    //                 )),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Text(
    //                       "سياسه الخصوصيه",
    //                       style: TextStyle(
    //                           color: Colors.orangeAccent, fontSize: 12),
    //                     ),
    //                     Text(
    //                       "و",
    //                       style: TextStyle(fontSize: 12, color: Colors.grey),
    //                     ),
    //                     Text(
    //                       " شروط الخدمه",
    //                       style: TextStyle(
    //                           color: Colors.orangeAccent, fontSize: 12),
    //                     ),
    //                     Text("من خلال النقر علي الاشتراك فإنك توافق علي",
    //                         style: TextStyle(fontSize: 12, color: Colors.grey))
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget getIntresItem(PermiemModel model) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "الاستقراطية",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: ListView.separated(
                  itemBuilder: (context, index) => buildGridleProduct(
                        ShopCubit.get(context).permiemModel.data[index],
                      ),
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: ShopCubit.get(context).permiemModel.data.length)),
        ),
      );

  Widget buildGridleProduct(PermiemModelData model) => Column(
        children: [
          InkWell(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: ClipRRect(
                  borderRadius:
                      BorderRadius.horizontal(right: Radius.circular(8.0)),
                  child: Column(
                    children: [
                      Container(
                        child: Text(model.name),
                      ),
                      Image.network(
                        model.url + model.badge,
                        height: 80,
                        // fit: BoxFit.fill,
                      ),
                      Container(
                        child: Text(model.price.toString()),
                      ),
                    ],
                  )),
            ),
            onTap: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    title: const Text('هل تريد شراء استقراطيه'),
                    // content: const Text('AlertDialog description'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          ShopCubit.get(context).buyPermiemData(id: model.id);

                          Navigator.pop(context, 'yes');

                          // CommonFunctions.showToast(
                          //     ShopCubit.get(context)
                          //         .permiemPurchaseModel
                          //         .message,
                          //     Colors.green);
                        },
                        child: const Text('نعم'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'no'),
                        child: const Text('لا'),
                      ),
                    ],
                  ),
                ),
              );
              setState(() {
                // image = model.url;
                // CacheHelper.saveData(key: 'image', value: model.url);
              });
            },
          ),

          // Container(child: Center(child: Text(model.price.toString()))),
          // Container(
          //   width: 180,
          //   color: KstorebuttonColor,
          //   child: Center(
          //     child: Text(
          //       "شراء",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      );
}
// fares
//             ? Container(
//                 height: 110,
//                 child: BottomAppBar(
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("قطعه ذهبيه كل شهر",
//                                 style: TextStyle(color: Colors.grey)),
//                             Text(
//                               '2,100',
//                               style: TextStyle(
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Text(
//                               "اشترك للحصول علي ",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: 25,
//                           width: 280,
//                           decoration: BoxDecoration(
//                             color: KstorebuttonColor,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Center(
//                               child: Text(
//                             "شهر /USD19.99الاشتراك في",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                         ),
//                         Container(
//                             child: Text(
//                           "استعاده المشتريات",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         )),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "سياسه الخصوصيه",
//                               style: TextStyle(
//                                   color: Colors.orangeAccent, fontSize: 12),
//                             ),
//                             Text(
//                               "و",
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.grey),
//                             ),
//                             Text(
//                               " شروط الخدمه",
//                               style: TextStyle(
//                                   color: Colors.orangeAccent, fontSize: 12),
//                             ),
//                             Text("من خلال النقر علي الاشتراك فإنك توافق علي",
//                                 style:
//                                     TextStyle(fontSize: 12, color: Colors.grey))
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
//             : Container(
//                 height: 110,
//                 child: BottomAppBar(
//                   child: Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("قطعه ذهبيه كل شهر",
//                                 style: TextStyle(color: Colors.grey)),
//                             Text(
//                               '5,100',
//                               style: TextStyle(
//                                 color: Colors.red,
//                               ),
//                             ),
//                             Text(
//                               "اشترك للحصول علي ",
//                               style: TextStyle(color: Colors.grey),
//                             ),
//                           ],
//                         ),
//                         Container(
//                           height: 25,
//                           width: 280,
//                           decoration: BoxDecoration(
//                             color: KstorebuttonColor,
//                             borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(20),
//                               topRight: Radius.circular(20),
//                               bottomLeft: Radius.circular(20),
//                               bottomRight: Radius.circular(20),
//                             ),
//                           ),
//                           child: Center(
//                               child: Text(
//                             "شهر /USD19.99الاشتراك في",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w700),
//                           )),
//                         ),
//                         Container(
//                             child: Text(
//                           "استعاده المشتريات",
//                           style: TextStyle(
//                             fontSize: 12,
//                             fontWeight: FontWeight.w600,
//                             decoration: TextDecoration.underline,
//                           ),
//                         )),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               "سياسه الخصوصيه",
//                               style: TextStyle(
//                                   color: Colors.orangeAccent, fontSize: 12),
//                             ),
//                             Text(
//                               "و",
//                               style:
//                                   TextStyle(fontSize: 12, color: Colors.grey),
//                             ),
//                             Text(
//                               " شروط الخدمه",
//                               style: TextStyle(
//                                   color: Colors.orangeAccent, fontSize: 12),
//                             ),
//                             Text("من خلال النقر علي الاشتراك فإنك توافق علي",
//                                 style:
//                                     TextStyle(fontSize: 12, color: Colors.grey))
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               )
// class TrianglePainter extends CustomPainter {
//   final Color strokeColor;
//   final PaintingStyle paintingStyle;
//   final double strokeWidth;

//   TrianglePainter(
//       {this.strokeColor = Colors.black,
//       this.strokeWidth = 3,
//       this.paintingStyle = PaintingStyle.stroke});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = strokeColor
//       ..strokeWidth = strokeWidth
//       ..style = paintingStyle;

//     canvas.drawPath(getTrianglePath(size.width, size.height), paint);
//   }

//   Path getTrianglePath(double x, double y) {
//     return Path()
//       ..moveTo(0, y)
//       ..lineTo(x / 2, 0)
//       ..lineTo(x, y)
//       ..lineTo(0, y);
//   }

//   @override
//   bool shouldRepaint(TrianglePainter oldDelegate) {
//     return oldDelegate.strokeColor != strokeColor ||
//         oldDelegate.paintingStyle != paintingStyle ||
//         oldDelegate.strokeWidth != strokeWidth;
//   }
// }
