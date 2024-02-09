import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> fomrkey = GlobalKey();
  final _storage = const FlutterSecureStorage();

  // Member variables
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();

    // Set default values
    phoneController.text = '0121212';
    passwordController.text = '12345678';

    // Read credentials
    _storage.read(key: 'phone').then((phone) {
      if (phone != null) {
        phoneController.text = phone;
      }
    });

    _storage.read(key: 'password').then((password) {
      if (password != null) {
        passwordController.text = password;
        rememberMe = true;
      }
    });
  }

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
// Remember me checkbox
                        Directionality(
                          textDirection: TextDirection.rtl,
                          child: Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (value) async {
                                  setState(() {
                                    rememberMe = value;
                                  });

                                  if (rememberMe) {
                                    // Save credentials
                                    await _storage.write(
                                        key: 'phone',
                                        value: phoneController.text);
                                    await _storage.write(
                                        key: 'password',
                                        value: passwordController.text);
                                  }
                                },
                              ),
                              Text('حفظ البيانات'),
                            ],
                          ),
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => CommonFunctions()
                              .nbAppButtonWidget(context, 'تسجيل دخول', () {
                            if (fomrkey.currentState.validate()) {
                              LoginScreenCubit.get(context).userlogin(
                                  name: phoneController.text,
                                  password: passwordController.text);
                            }
                          }),
                          fallback: (context) => Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),

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

Widget _sizedBox({double width, double height}) {
  return SizedBox(
    width: width,
    height: height,
  );
}
