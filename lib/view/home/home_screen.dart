/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:project/controller/home_controller.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';
import 'package:project/view/search/room_search.dart';

import '../../shopCubit.dart';
import '../../shopStates.dart';
import 'app_bar_item.dart';
import 'components/drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => HomeCubit()
        ..patchfcmtoken(fcmtoken: fcm_token)
        // ..showfriends()
        ..getmyroom(),
      // ..myroomcheckroom(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: GetBuilder<HomeController>(
              init: HomeController(),
              builder: (controller) => Scaffold(
                key: controller.scaffoldKey,
                drawer: HomeDrawer(controller.scaffoldKey),
                appBar: AppBar(
                  leading: GestureDetector(
                    onTap: () =>
                        controller.scaffoldKey.currentState.openDrawer(),
                    child: hasFrame != null
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                  width: 60,
                                  child: Image.network(
                                    hasFrame,
                                  )), // Back image
                              Container(
                                width: 40,
                                child: Image.asset(
                                  "assets/images/Profile Image.png",
                                  fit: BoxFit.cover,
                                ),
                              ) // Front image
                            ],
                          )
                        : Container(
                            width: 40,
                            child: Image.asset(
                              "assets/images/Profile Image.png",
                              fit: BoxFit.cover,
                            ),
                          ),

                    // Fro

                    // Container(
                    //     margin: const EdgeInsets.all(5.0),
                    // child: Image.asset(
                    //   "assets/images/Profile Image.png",
                    //   fit: BoxFit.cover,
                    // )
                    // ),
                  ),
                  title: controller.currentIndex == 0
                      ? _homeTabAppBarTitle(controller)
                      : controller.currentIndex == 1
                          ? _momentsTabAppBarTitle(controller)
                          : _messageTabAppBarTitle(controller),
                  centerTitle: true,
                  actions: [
                    controller.showSearchIcon
                        ? IconButton(
                            icon: Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: () {
                              Get.to(SearchRoom());
                            })
                        : Container(),
                    // controller.showPublishIcon
                    // ? Container(
                    //     margin: const EdgeInsets.symmetric(horizontal: 24),
                    //     width: 36,
                    //     height: 36,
                    //     decoration: BoxDecoration(
                    //       color: Colors.orangeAccent,
                    //       shape: BoxShape.circle,
                    //     ),
                    //     // child: Center(
                    //     //   child: IconButton(
                    //     //       icon: Icon(
                    //     //         Icons.send,
                    //     //         color: Colors.white,
                    //     //       ),
                    //     //       onPressed: () {
                    //     //         print("publish button clicked");
                    //     //       }),
                    //     // ),
                    //   )
                    // : Container(),
                  ],
                ),
                body: controller.children[controller.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: "الغرف"),
                    // BottomNavigationBarItem(
                    //     icon: Icon(Icons.access_alarms_rounded),
                    //     label: "اللحظات"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.message), label: "الرسائل"),
                  ],
                  currentIndex: controller.currentIndex,
                  elevation: 5.0,
                  selectedItemColor: kPrimaryColor,
                  unselectedItemColor: kGreyColor,
                  type: BottomNavigationBarType.fixed,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  onTap: (value) {
                    controller.changeCurrentScreen(value);
                  },
                ),

                // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget homeFrame() {}

  Widget _homeTabAppBarTitle(final controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(0);
            },
            child: AppBarItem(
              title: "غرفتى",
              textColor: controller.appBarCurrentItem == 0
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(1);
            },
            child: AppBarItem(
              title: "الكل",
              textColor: controller.appBarCurrentItem == 1
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     controller.changeAppBarSelectedItem(2);
          //   },
          //   child: AppBarItem(
          //     title: "اكتشاف",
          //     textColor: controller.appBarCurrentItem == 2
          //         ? Colors.white
          //         : kGreyColor.shade600,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _momentsTabAppBarTitle(final controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(0);
            },
            child: AppBarItem(
              title: "الرسائل",
              textColor: controller.appBarCurrentItem == 0
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(1);
            },
            child: AppBarItem(
              title: "الاصدقاء",
              textColor: controller.appBarCurrentItem == 1
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _messageTabAppBarTitle(final controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(0);
            },
            child: AppBarItem(
              title: "الرسائل",
              textColor: controller.appBarCurrentItem == 0
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
          GestureDetector(
            onTap: () {
              controller.changeAppBarSelectedItem(1);
            },
            child: AppBarItem(
              title: "الاصدقاء",
              textColor: controller.appBarCurrentItem == 1
                  ? Colors.white
                  : kGreyColor.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
