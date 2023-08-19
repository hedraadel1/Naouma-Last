import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:project/view/login/login_view.dart';

class SplashController extends GetxController {
  Timer _timer;
  Timer get timer => _timer;
  FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;
  FlutterLogoStyle get logoStyle => _logoStyle;

  FadeIn() {
    _timer = new Timer(const Duration(seconds: 2), () {
      _logoStyle = FlutterLogoStyle.horizontal;
      update();
    });
  }

  @override
  void onInit() {
    // initPrefs();
    super.onInit();

    // startTimer();
  }

  void startTimer() async {
    Timer(Duration(milliseconds: 4100), () {
      Get.off(
          () => PreferencesServices.getBool(
                IS_LOGIN,
              )
                  ? HomeScreen()
                  : LoginView(),
          transition: Transition.leftToRightWithFade);
      // Navigator.push(context, PageTransition(type: PageTransitionType.topToBottom, child: DetailScreen()));
    });
  }

  void initPrefs() async {
    await PreferencesServices.init();
  }
}
