/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/view/home/homeCubit.dart';

import 'package:project/view/home/home_tab_pages/discovery_tab.dart';
import 'package:project/view/home/home_tab_pages/home_tab/home_tab_all.dart';
import 'package:project/view/home/home_tab_pages/my_room_tab.dart';
import 'package:project/view/home/moments_tab_pages/subjects_view.dart';
import 'package:project/view/home/moments_tab_pages/suggested_view.dart';
import 'package:project/view/home/pages/home_tab.dart';
import 'package:project/view/home/pages/messages_tab.dart';
import 'package:project/view/home/pages/moments_tab.dart';

class HomeController extends GetxController {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  // Widget _appBarTitle;
  // dynamic get appBarTitle => _appBarTitle;

  // to check selected app bar item
  int _appBarCurrentItem = 0;

  int get appBarCurrentItem => _appBarCurrentItem;

  // to show or hide appbar actions
  bool _showSearchIcon = true;

  bool get showSearchIcon => _showSearchIcon;

  // to show or hide publish appbar actions
  bool _showPublishIcon = false;

  bool get showPublishIcon => _showPublishIcon;

  // Widget _currentScreen = HomeTab();
  final List<Widget> _children = [
    HomeTab(),
    MomentsTab(),
    // MessagesTab(),
  ];

  List<Widget> get children => _children;

  // Widget home tab views...
  final List<Widget> _homeTabChildren = [
    MyRoomTab(),
    HomeTabAll(),
    DiscoveryTab(),
  ];

  List<Widget> get homeTabChildren => _homeTabChildren;

// for moments tab views...
  final List<Widget> _momentsTabChildren = [
    // FollowedView(),
    SuggestedView(),
    SubjectsView(),
  ];

  List<Widget> get momentsTabChildren => _momentsTabChildren;

  // Widget get currentScreen => _currentScreen;
  changeCurrentScreen(int curIndex) {
    _currentIndex = curIndex;
    if (_currentIndex == 0) {}

    switch (curIndex) {
      case 0:
        {
          // _appBarTitle = _homeTabAppBarTitle();
          // _appBarTitle = 'Jobs';
          _showSearchIcon = true;
          _showPublishIcon = false;
          _appBarCurrentItem = 0;
        }
        break;
      case 1:
        {
          _showSearchIcon = false;
          _showPublishIcon = true;
          _appBarCurrentItem = 0;
        }
        break;
      case 2:
        {
          _showSearchIcon = false;
          _showPublishIcon = false;
          _appBarCurrentItem = 0;
          HomeCubit()..showfriends();
        }
        break;
    }
    update();
  }

  // change app bar selected item
  changeAppBarSelectedItem(int selectedIndex) {
    _appBarCurrentItem = selectedIndex;
    update();
  }
}
