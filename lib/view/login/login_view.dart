/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;

import 'package:nb_utils/nb_utils.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'package:project/common_functions.dart';
import 'package:project/network/cache_helper.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/login/logincubit.dart';
import 'package:project/view/login/loginstates.dart';
import 'package:project/view/login/register_view.dart';

import 'package:project/utils/constants.dart';
import 'package:project/view/login/user.dart';

class LoginView extends StatelessWidget {
  GlobalKey<FormState> fomrkey = GlobalKey();

  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  String _countryCode = "+2";
  Auth.FirebaseAuth auth = Auth.FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    // final transformConfig = Matrix4.rotationZ(-8 * pi / 180);
    // transformConfig.translate(-10.0);
    return BlocProvider(
      create: (BuildContext context) => LoginScreenCubit(),
      child: BlocConsumer<LoginScreenCubit, LoginAppStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessStates) {
            CacheHelper.saveData(
                    key: 'token', value: state.authModel.accessToken)
                .then((value) {
              token = state.authModel.accessToken;
              senderId = state.authModel.user.userId;
              hasFrame = state.authModel.user.frame;
              // print(username);
              // Get.to(HomeScreen());
            });
            CacheHelper.saveData(
                    key: 'username', value: state.authModel.user.name)
                .then((value) {
              username = state.authModel.user.name;
              print(username);
            });
            //  User Special id if he have
            CacheHelper.saveData(
                    key: 'user_id', value: state.authModel.user.userId)
                .then((value) {
              userid = state.authModel.user.userId;
            });
            CacheHelper.saveData(key: 'id', value: state.authModel.user.id)
                .then((value) {
              apiid = state.authModel.user.id.toString();

              CommonFunctions.showToast('تم تسجيل الدخول', Colors.green);
              Get.to(HomeScreen());
            });
          } else {
            if (state is ShopLoginErrorStates) {
              CommonFunctions.showToast('لن نتمكن من تسجيل الدخول', Colors.red);
            }
          }
        },
        builder: (context, state) {
          String phone = phoneController.text;
          // String name = nameController.text;
          return Scaffold(
            body: Form(
              key: fomrkey,
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    // height: size.height,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _sizedBox(height: 80),
                        // Text('Welcome to\n Na3oma',
                        //     style: boldTextStyle(size: 30)),

                        Center(
                          child: Container(
                            height: 80,
                            child: Image.asset(
                                "assets/images/Profile Image.png",
                                fit: BoxFit.fill),
                          ),
                        ),
                        _sizedBox(height: 20),
                        Center(
                          child: Text(' نعومة', style: boldTextStyle(size: 30)),
                        ),

                        _sizedBox(height: 50),

                        // Container(
                        //   // color: Colors.grey,
                        //   child: Row(
                        //     children: [
                        //       Container(
                        //         width: 100,
                        //         height: 50,
                        //         child: DropdownButtonFormField<String>(
                        //             isExpanded: true,
                        //             decoration: InputDecoration(
                        //               contentPadding: EdgeInsets.only(
                        //                   left: 16,
                        //                   right: 16,
                        //                   top: 8,
                        //                   bottom: 8),
                        //               filled: true,
                        //               fillColor: grey.withOpacity(0.1),
                        //               labelText: "",
                        //               labelStyle: TextStyle(
                        //                   fontSize: 8,
                        //                   color: Colors.transparent),
                        //               // hintStyle: secondaryTextStyle(),
                        //               errorStyle: TextStyle(
                        //                 fontFamily: "Cairo",
                        //                 color: Colors.red,
                        //                 fontSize: 14,
                        //               ),
                        //               border: OutlineInputBorder(
                        //                   borderRadius:
                        //                       BorderRadius.circular(16),
                        //                   borderSide: BorderSide.none),
                        //             ),
                        //             // decoration: InputDecoration(
                        //             //   ),
                        //             value: _countryCode,
                        //             onChanged: (String newValue) {
                        //               _countryCode = newValue ?? "+2";
                        //             },
                        //             items: [
                        //               DropdownMenuItem<String>(
                        //                 value: "+961",
                        //                 child: Text("+961"),
                        //               ),
                        //               DropdownMenuItem<String>(
                        //                 value: "+2",
                        //                 child: Text("+2"),
                        //               ),
                        //               DropdownMenuItem<String>(
                        //                 value: "+1",
                        //                 child: Text("+1"),
                        //               ),
                        //             ]),
                        //         // color: Colors.red,
                        //       ),
                        //       SizedBox(
                        //         width: 20,
                        //       ),
                        //       Container(
                        //         // color: Colors.amber,
                        //         width: 240,
                        //         height: 50,
                        //         child: TextFormField(
                        //           controller: phoneController,
                        //           keyboardType: TextInputType.phone,
                        //           decoration: InputDecoration(
                        //             contentPadding: EdgeInsets.only(
                        //                 left: 16, right: 16, top: 8, bottom: 8),
                        //             filled: true,
                        //             fillColor: grey.withOpacity(0.1),
                        //             hintText:
                        //                 '                                  ادخل رقم الموبايل',
                        //             hintStyle: secondaryTextStyle(),
                        //             errorStyle: TextStyle(
                        //               fontFamily: "Cairo",
                        //               color: Colors.red,
                        //               fontSize: 14,
                        //             ),
                        //             border: OutlineInputBorder(
                        //                 borderRadius: BorderRadius.circular(16),
                        //                 borderSide: BorderSide.none),
                        //           ),
                        //           validator: (value) {
                        //             String pattern =
                        //                 r'(^(?:[+0]9)?[0-9]{8,12}$)';
                        //             RegExp regExp = new RegExp(pattern);

                        //             if (value.isEmpty) {
                        //               return "برجاء ادخال رقم الموباليل";
                        //             }
                        //             if (!regExp.hasMatch(value)) {
                        //               return "رقم الموباليل ليس صحيح";
                        //             }

                        //             return null;
                        //           },
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),

                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: CommonFunctions().nbAppTextFieldWidget(
                            phoneController,
                            'phone',
                            "ادخل  اسم المستخدم",
                            'برجاء ادخال رقم الموباليل',
                            TextFieldType.NAME,
                          ),
                        ),
                        _sizedBox(height: 20),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: CommonFunctions().nbAppTextFieldWidget(
                            passwordController,
                            'Password',
                            "ادخل كلمة المرور",
                            'برجاء ادخال كلمه المرور',
                            TextFieldType.PASSWORD,
                          ),
                        ),
                        _sizedBox(height: 28),
                        // ConditionalBuilder(
                        //   condition: state is! ShopLoginLoadingState,
                        // builder: (context) =>
                        // CommonFunctions()
                        //     .nbAppButtonWidget(context, 'تسجيل دخول', () {
                        //   if (fomrkey.currentState.validate()) {
                        //     LoginScreenCubit.get(context).userlogin(
                        //         mobile: phoneController.text,
                        //         password: passwordController.text);
                        //   }

                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => CommonFunctions()
                              .nbAppButtonWidget(context, 'تسجيل دخول', () {
                            if (fomrkey.currentState.validate()) {
                              LoginScreenCubit.get(context).userlogin(
                                  name: phoneController.text,
                                  password: passwordController.text);
                            }
                            // controller.loginFormKey.currentState.save();
                            // // No any error in validation
                            // controller.loginEmail =
                            //     controller.phoneNumberController.text;
                            // controller.password =
                            //     controller.passwordController.text;

                            // controller.login();
                          }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                        // controller.loginFormKey.currentState.save();
                        // // No any error in validation
                        // controller.loginEmail =
                        //     controller.phoneNumberController.text;
                        // controller.password =
                        //     controller.passwordController.text;

                        // controller.login();

                        /////////////////////////////////////////////////////////////
                        // if (fomrkey.currentState.validate()) {
                        //   if (otp == false) {
                        //     Auth.FirebaseAuth.instance.verifyPhoneNumber(
                        //       phoneNumber: _countryCode + phone,
                        //       timeout: Duration(seconds: 120),
                        //       verificationCompleted:
                        //           (Auth.PhoneAuthCredential credential) {
                        //         print("it's valid");
                        //       },
                        //       verificationFailed:
                        //           (Auth.FirebaseAuthException e) {
                        //         print("failed");

                        //         ScaffoldMessenger.of(context).showSnackBar(
                        //             SnackBar(content: Text(e.toString())));
                        //       },
                        //       codeSent: (String verificationId,
                        //           int resendToken) async {
                        //         showDialog(
                        //             barrierDismissible: true,
                        //             context: context,
                        //             builder: (BuildContext context) {
                        //               return SMSCodeDialog(
                        //                   phoneNumber: _countryCode + phone,
                        //                   resendToken: resendToken,
                        //                   onSMSCodeEntered:
                        //                       (smsCode, dialogContext) async {
                        //                     try {
                        //                       Auth.PhoneAuthCredential
                        //                           credential =
                        //                           Auth.PhoneAuthProvider
                        //                               .credential(
                        //                                   verificationId:
                        //                                       verificationId,
                        //                                   smsCode: smsCode);
                        //                       Auth.UserCredential userCre =
                        //                           await auth
                        //                               .signInWithCredential(
                        //                                   credential);

                        //                       Auth.User firebaseUser =
                        //                           userCre.user;

                        //                       // User user =
                        //                       //     User(name, firebaseUser.phoneNumber, firebaseToken: firebaseUser.uid);
                        //                       // Cache.saveUser(user);
                        //                       // widget.onRegister(user);
                        //                       Navigator.of(dialogContext)
                        //                           .pop();
                        //                     } catch (e) {
                        //                       print(e);
                        //                       ScaffoldMessenger.of(context)
                        //                           .showSnackBar(SnackBar(
                        //                               content:
                        //                                   Text("Wrong sms "
                        //                                       "code")));
                        //                     }
                        //                   });
                        //             });
                        //       },
                        //       codeAutoRetrievalTimeout:
                        //           (String verificationId) {
                        //         print("timeout");
                        //       },
                        //     );
                        //   } else {
                        //     if (otp == true) {
                        //       LoginScreenCubit.get(context).userlogin(
                        //           mobile: phoneController.text,
                        //           password: passwordController.text);
                        //     }
                        // }

                        // if (fomrkey.currentState.validate()) {
                        //   LoginScreenCubit.get(context).userlogin(
                        //       mobile: phoneController.text,
                        //       password: passwordController.text);
                        // }
                        // controller.loginFormKey.currentState.save();
                        // // No any error in validation
                        // controller.loginEmail =
                        //     controller.phoneNumberController.text;
                        // controller.password =
                        //     controller.passwordController.text;

                        // controller.login();
                        // }),
                        // fallback: (context) => Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        // }
                        // }),

                        _sizedBox(height: 30),
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('ليس لديك حساب ؟',
                                  style: primaryTextStyle()),
                              Text('إنشاء حساب',
                                      style: boldTextStyle(color: Colors.blue))
                                  .onTap(() {
                                Get.to(RegisterView());
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // demo of some additional parameters
          );
        },
      ),
    );
  }
}

// Widget build(BuildContext context) {
//   GlobalKey<FormState> fomrkey = GlobalKey();
//   var phoneController = TextEditingController();
//   var passwordController = TextEditingController();
//   FocusNode emailFocus = FocusNode();
//   FocusNode passwordFocus = FocusNode();

//   return BlocProvider(
//     create: (BuildContext context) => LoginScreenCubit(),
//     child: BlocConsumer<LoginScreenCubit, LoginAppStates>(
//       listener: (context, state) {
//         if (state is ShopLoginSuccessStates) {
//           CacheHelper.saveData(key: 'token', value: state.authModel.accessToken)
//               .then((value) {
//             token = state.authModel.accessToken;
//             print(token);
//             Navigator.pushReplacementNamed(context, "/home");
//           });
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           body: Form(
//             key: fomrkey,
//             child: SingleChildScrollView(
//               child: Center(
//                 child: Container(
//                   // height: size.height,
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       _sizedBox(height: 100),
//                       Text('Welcome to\n Na3oma',
//                           style: boldTextStyle(size: 30)),
//                       _sizedBox(height: 60),
//                       CommonFunctions().nbAppTextFieldWidget(
//                         phoneController,
//                         'phone',
//                         "Enter your phone",
//                         'Email is required',
//                         TextFieldType.PHONE,
//                       ),
//                       _sizedBox(height: 20),
//                       CommonFunctions().nbAppTextFieldWidget(
//                         passwordController,
//                         'Password',
//                         "Enter your password",
//                         'Password is required',
//                         TextFieldType.PASSWORD,
//                       ),
//                       _sizedBox(height: 28),
//                       ConditionalBuilder(
//                         condition: state is! ShopLoginLoadingState,
//                         builder: (context) => CommonFunctions()
//                             .nbAppButtonWidget(context, 'Sign In', () {
//                           if (fomrkey.currentState.validate()) {
//                             LoginScreenCubit.get(context).userlogin(
//                                 phone: phoneController.text,
//                                 password: passwordController.text);
//                           }
//                           // controller.loginFormKey.currentState.save();
//                           // // No any error in validation
//                           // controller.loginEmail =
//                           //     controller.phoneNumberController.text;
//                           // controller.password =
//                           //     controller.passwordController.text;

//                           // controller.login();
//                         }),
//                         fallback: (context) => Center(
//                           child: CircularProgressIndicator(),
//                         ),
//                       ),
//                       _sizedBox(height: 30),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Text('Don\'t have an account?',
//                               style: primaryTextStyle()),
//                           Text(' Sign Up',
//                                   style: boldTextStyle(color: kPrimaryColor))
//                               .onTap(() {
//                             Get.to(RegisterView());
//                           }),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // demo of some additional parameters
//         );
//       },
//     ),
//   );

//   // return BlocProvider(
//   //     create: (BuildContext context) => LoginScreenCubit(),
//   //     child: BlocConsumer<LoginScreenCubit, LoginAppStates>(
//   //       listener: (context, state) {
//   //         if (state is ShopLoginSuccessStates) {
//   //           CacheHelper.saveData(
//   //                   key: 'token', value: state.authModel.accessToken)
//   //               .then((value) {
//   //             Get.to(HomeScreen());
//   //           });
//   //         }
//   //       },
//   //       builder: (context, state) {
//   //         return Scaffold(
//   //           body: GetBuilder<AuthController>(
//   //             init: AuthController(),
//   //             builder: (controller) => ModalProgressHUD(
//   //                 child: Form(
//   //                   key: controller.loginFormKey,
//   //                   child: SingleChildScrollView(
//   //                     child: Center(
//   //                       child: Container(
//   //                         // height: size.height,
//   //                         padding: const EdgeInsets.all(16),
//   //                         child: Column(
//   //                           crossAxisAlignment: CrossAxisAlignment.start,
//   //                           mainAxisAlignment: MainAxisAlignment.center,
//   //                           children: [
//   //                             _sizedBox(height: 100),
//   //                             Text('Welcome to\n Na3oma',
//   //                                 style: boldTextStyle(size: 30)),
//   //                             _sizedBox(height: 60),
//   //                             CommonFunctions().nbAppTextFieldWidget(
//   //                               controller.phoneNumberController,
//   //                               'Email',
//   //                               "Enter your phone",
//   //                               'Email is required',
//   //                               TextFieldType.PHONE,
//   //                             ),
//   //                             _sizedBox(height: 20),
//   //                             CommonFunctions().nbAppTextFieldWidget(
//   //                               controller.passwordController,
//   //                               'Password',
//   //                               "Enter your password",
//   //                               'Password is required',
//   //                               TextFieldType.PASSWORD,
//   //                             ),
//   //                             _sizedBox(height: 28),
//   //                             CommonFunctions()
//   //                                 .nbAppButtonWidget(context, 'Sign In', () {
//   //                               if (controller.loginFormKey.currentState
//   //                                   .validate()) {
//   //                                 LoginScreenCubit.get(context).userlogin(
//   //                                     phone: controller
//   //                                         .phoneNumberController.text,
//   //                                     password:
//   //                                         controller.passwordController.text);
//   //                               }
//   //                               // controller.loginFormKey.currentState.save();
//   //                               // // No any error in validation
//   //                               // controller.loginEmail =
//   //                               //     controller.phoneNumberController.text;
//   //                               // controller.password =
//   //                               //     controller.passwordController.text;

//   //                               // controller.login();
//   //                             }),
//   //                             _sizedBox(height: 30),
//   //                             Row(
//   //                               mainAxisAlignment: MainAxisAlignment.center,
//   //                               children: [
//   //                                 Text('Don\'t have an account?',
//   //                                     style: primaryTextStyle()),
//   //                                 Text(' Sign Up',
//   //                                         style: boldTextStyle(
//   //                                             color: kPrimaryColor))
//   //                                     .onTap(() {
//   //                                   Get.to(RegisterView());
//   //                                 }),
//   //                               ],
//   //                             ),
//   //                           ],
//   //                         ),
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ),
//   //                 inAsyncCall: controller.isLoading,
//   //                 // demo of some additional parameters
//   //                 opacity: 0.5,
//   //                 progressIndicator:
//   //                     Center(child: CircularProgressIndicator())),
//   //           ),
//   //         );
//   //       },
//   //     ));
// }

Widget _sizedBox({double width, double height}) {
  return SizedBox(
    width: width,
    height: height,
  );
}
