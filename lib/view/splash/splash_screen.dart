import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/animation/fade_animation.dart';
import 'package:project/controller/splash_controller.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/images.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/home/states.dart';
import 'package:project/view/login/login_view.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final controller = Get.put(SplashController());
  // int _totalNotifications;

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // _totalNotifications = 0;
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: PreferencesServices.getBool(
                      IS_LOGIN,
                    )
                        ? HomeScreen()
                        : LoginView(),
                  ));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //     _notificationInfo = notification;
    //     _totalNotifications++;
    //   });
    final size = MediaQuery.of(context).size;

    return Scaffold(
      // body: AnimatedSplashScreen(
      //   splash: Container(
      //       child: Image.asset(kSplashLogo, width: 200, height: 300, fit: BoxFit.contain,)),
      //   nextScreen: PreferencesServices.getBool(IS_LOGIN,)?HomeScreen() : LoginView(),
      //   splashTransition: SplashTransition.scaleTransition,
      //   pageTransitionType: PageTransitionType.leftToRightWithFade,
      //   duration: 4000,
      // ),
      // body: Center(child: Container(child: Image.asset(kSplashLogo,),),)
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                    3,
                    Image.asset(
                      kSplashLogo,
                      width: size.width * 0.7,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // FadeAnimation(1.5, Text("We promise that you'll have the most \nfuss-free time with us ever.",
                  // style: TextStyle(color: Colors.black.withOpacity(.7), height: 1.4, fontSize: 20),)),
                  SizedBox(
                    height: 100,
                  ),
                  FadeAnimation(
                      2,
                      AnimatedBuilder(
                        animation: _scaleController,
                        builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Center(
                              child: AnimatedBuilder(
                                animation: _widthController,
                                builder: (context, child) => Container(
                                  width: _widthAnimation.value,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.blue.withOpacity(.4)),
                                  child: InkWell(
                                    onTap: () {
                                      _scaleController.forward();
                                    },
                                    child: Stack(children: <Widget>[
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) =>
                                                Transform.scale(
                                                    scale:
                                                        _scale2Animation.value,
                                                    child: Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.blue),
                                                      child: hideIcon == false
                                                          ? Icon(
                                                              Icons
                                                                  .arrow_forward,
                                                              color:
                                                                  Colors.white,
                                                            )
                                                          : Container(),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ]),
                                  ),
                                ),
                              ),
                            )),
                      )),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// FirebaseMessaging _messaging;
// void registerNotification() async {
//   // 1. Initialize the Firebase app
//   await Firebase.initializeApp();

//   // 2. Instantiate Firebase Messaging
//   _messaging = FirebaseMessaging.instance;

//   // 3. On iOS, this helps to take the user permissions
//   NotificationSettings settings = await _messaging.requestPermission(
//     alert: true,
//     badge: true,
//     provisional: false,
//     sound: true,
//   );

//   if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//     print('User granted permission');
//     // TODO: handle the received notifications
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       // Parse the message received
//       PushNotification notification = PushNotification(
//         title: message.notification?.title,
//         body: message.notification?.body,
//       );
//     });
//   } else {
//     print('User declined or has not accepted permission');
//   }
// }

// class NotificationBadge extends StatelessWidget {
//   final int totalNotifications;

//   const NotificationBadge({@required this.totalNotifications});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 40.0,
//       height: 40.0,
//       decoration: new BoxDecoration(
//         color: Colors.red,
//         shape: BoxShape.circle,
//       ),
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             '$totalNotifications',
//             style: TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class PushNotification {
//   PushNotification({
//     this.title,
//     this.body,
//   });
//   String title;
//   String body;
// }
