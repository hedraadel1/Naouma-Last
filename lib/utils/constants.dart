import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:project/network/cache_helper.dart';
import 'package:project/view/login/login_view.dart';
import 'package:project/view/login/logincubit.dart';

bool notfication;
String showgift;
String token = '';
String showintres = '';
String senderId = '';
String username = '';
String userid = '';
bool otp = false;
String apiid;
String userstateInroom;
String specialId;
String nameOFPackage;
String packageColor;
String packagebadge;
bool hasSpecialID;
File imageFile;
String imagename;
int allUserFollowRoom;
bool iFollow;
String base64;
bool ismuted;
String hasFrame;
String image = '';
String frameImage = "";
bool pressGeoON = false;
String fcm_token;
String fimage = "";
double totalWalletAmount;
String giftID;
bool haveIntes = false;
String level = "";
String permColor;
bool hasperm;
String expNum = "";
List inroomList = [];
bool isfriendfirebase;

/// Colors*
const kPrimaryColor = Color(0xFFe10deb);
const kPrimaryColorDark = Color(0xFF56E0D3);
const kPrimaryLightColor = Color(0xFF56E0D3);
const KbuttonColor = Color.fromARGB(255, 153, 243, 234);
const kinput = Color(0xFFE8E8E8);
const apparColor = Color(0xFFe10deb);

const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kGreyColor = Colors.grey;
const KstorebuttonColor = Color(0xFFFFD700);

const kAnimationDuration = Duration(milliseconds: 150);

final headingStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);
// const number for per page request
const int kPerPageNumber = 20;
const double kBorderRadius = 16;
const double kDefaultPadding = 20;

/// keys ***/
const String USER_DATA_KEY = '/user-data-key';
const String IS_LOGIN = '/is_login-key';
const String ID_KEY = '/ID_KEY';
const String Email_KEY = '/Email_KEY';
const String Name_KEY = '/Name_KEY';

// Agora utils
const String AppId = "45f4567598af4f32afca701cccd0cf2d";
const String AppCertificate = "4518ca6edb7d41e1b3d1e4580678a5e2";
const String agoratoken =
    "00698657cf49a914ad68d30cb93f0d1f578IABEhHTkG4WidHJ5ZNQ7KEqLzJlVatW9BMlFOtpvXE+68ZtRn3IAAAAAEACLgpZhVpcrYQEAAQBXlyth";

/// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNameNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

void sginOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      Navigator.pushAndRemoveUntil<void>(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => LoginView()),
        ModalRoute.withName('/'),
      );
    }
  });
}
