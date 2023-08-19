/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common_functions.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/login/registercubit.dart';
import 'package:project/view/login/registerstates.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';

import 'package:project/view/login/login_view.dart';

class RegisterView extends StatelessWidget {
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController signPasswordController = TextEditingController();

  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> fomrkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.instance.getToken().then((value) {
      String fcmtoken = value;

      print(fcmtoken);
    });
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final style = TextStyle(fontFamily: 'Almarai', fontSize: 16.0);

    return BlocProvider(
      create: (BuildContext context) => RegisterScreenCubit(),
      child: BlocConsumer<RegisterScreenCubit, RegisterAppStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessStates) {
            CommonFunctions.showToast('تم انشاء حساب', Colors.green);

            Get.to(() => LoginView());
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    finish(context);
                  }),
              elevation: 0,
              backgroundColor: white,
            ),
            body: Form(
              key: fomrkey,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sizedBox(height: 60),
                      // Text('Create new\naccount',
                      //     style: boldTextStyle(size: 30)),
                      Center(
                        child: Container(
                          height: 80,
                          child: Image.asset("assets/images/Profile Image.png",
                              fit: BoxFit.fill),
                        ),
                      ),
                      _sizedBox(height: 50),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: CommonFunctions().nbAppTextFieldWidget(
                          nameController,
                          'Name',
                          "ادخل اسمك هنا",
                          'برجاء ادخال الاسم',
                          TextFieldType.NAME,
                        ),
                      ),
                      _sizedBox(height: 16),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: CommonFunctions().nbAppTextFieldWidget(
                          phoneNumberController,
                          'phone',
                          "ادخل رقم الموبايل",
                          'برجاء ادخال رقم الموبايل',
                          TextFieldType.PHONE,
                        ),
                      ),
                      16.height,
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: CommonFunctions().nbAppTextFieldWidget(
                          signPasswordController,
                          'Password',
                          "ادخل كلمة مرور",
                          'برجاء ادخال كلمه المرور',
                          TextFieldType.PASSWORD,
                        ),
                      ),
                      16.height,
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: CommonFunctions().nbAppTextFieldWidget(
                          confirmpasswordController,
                          'Confirm Password',
                          "تاكيد كلمة الرور",
                          'برجاء ادخال كلمه المرور',
                          TextFieldType.PASSWORD,
                        ),
                      ),
                      36.height,
                      ConditionalBuilder(
                        condition: state is! ShopRegisterLoadingState,
                        builder: (context) => CommonFunctions()
                            .nbAppButtonWidget(context, 'إنشاء حساب', () {
                          if (fomrkey.currentState.validate()) {
                            RegisterScreenCubit.get(context).userRegister(
                              phone: phoneNumberController.text,
                              password: signPasswordController.text,
                              name: nameController.text,
                              confirmpassword: confirmpasswordController.text,
                              // fcmtoken: fcmtoken,
                            );
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
                      // CommonFunctions().nbAppButtonWidget(
                      //     context, 'Create Account', () {
                      //   if (controller.signFormKey.currentState
                      //       .validate()) {
                      //     RegisterScreenCubit.get(context).userlogin(
                      //       phone: phoneNumberController.text,
                      //       password:
                      //           signPasswordController.text,
                      //       name:nameController.text,
                      //       confirmpassword:
                      //           confirmpasswordController.text,
                      //     );

                      //     // controller.signFormKey.currentState.save();
                      //     // // No any error in validation
                      //     // controller.name =
                      //     //     controller.nameController.text;
                      //     // controller.registerEmail =
                      //     //     controller.signEmailController.text;
                      //     // controller.password =
                      //     //     controller.signPasswordController.text;
                      //     // controller.signUp();
                      //   }
                      // }),
                      30.height,
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('هل لديك حساب؟', style: primaryTextStyle()),
                            Text('تسجيل دخول',
                                    style: boldTextStyle(color: kPrimaryColor))
                                .onTap(() {
                              finish(context);
                            }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
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
