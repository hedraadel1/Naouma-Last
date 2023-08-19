// import 'dart:io';
// import 'dart:async';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:http/http.dart';
// import 'constants.dart';

// class CommonFunctions {
//   static Future<bool> getNetworkStatus({Duration duration}) async {
//     await Future.delayed(duration ?? Duration(milliseconds: 300));
//     try {
//       final result = await InternetAddress.lookup('google.com')
//           .timeout(Duration(seconds: 1), onTimeout: () {
//         throw SocketException("No internet");
//       });
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       } else {
//         return false;
//       }
//     } on SocketException catch (_) {
//       return false;
//     }
//   }

//   static bool successResponse(int statusCode) {
//     int r = (statusCode ~/ 100);
//     return r == 2;
//   }

//   static Size getSize(text, textStyle, context) {
//     Size size = (TextPainter(
//             text: TextSpan(text: text, style: textStyle),
//             maxLines: 1,
//             textScaleFactor: MediaQuery.of(context).textScaleFactor,
//             textDirection: TextDirection.rtl)
//           ..layout())
//         .size;
//     return size;
//   }

//   static Future<bool> showToast(String msg, Color bgColor) {
//     return Fluttertoast.showToast(
//         msg: msg,
//         toastLength: Toast.LENGTH_SHORT,
//         gravity: ToastGravity.BOTTOM,
//         timeInSecForIosWeb: 1,
//         backgroundColor: bgColor,
//         textColor: Colors.white,
//         fontSize: 16.0);
//   }

//   static Color hexToColor(String code) {
//     return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
//   }

//   static launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       showToast('Could not launch $url', Colors.grey.shade500);
//       throw 'Could not launch $url';
//     }
//   }

//   static showAlertDialog(BuildContext context, String title, String message,
//       String btnText, Function function) {
//     // set up the button
//     Widget okButton = TextButton(
//       child: Text(btnText),
//       onPressed: function,
//     );

//     // set up the AlertDialog
//     AlertDialog alert = AlertDialog(
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         okButton,
//       ],
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   static showAlertWithTwoActions(
//       BuildContext context, String title, String message, Function function) {
//     // set up the buttons
//     Widget cancelButton = TextButton(
//       child: Text("الغاء"),
//       onPressed: () {
//         finish(context);
//       },
//     );
//     Widget continueButton = TextButton(
//       child: Text("موافق"),
//       onPressed: function,
//     );
//     // set up the AlertDialog
//     CupertinoAlertDialog alert = CupertinoAlertDialog(
//       title: Text(title),
//       content: Text(message),
//       actions: [
//         cancelButton,
//         continueButton,
//       ],
//     );
//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   static Future<File> pickImage(ImageSource source) async {
//     var image = await ImagePicker().getImage(source: source);
//     if (image != null) {
//       File imageFile = File(image.path);
//       print(imageFile.path);
//       return imageFile;
//     }
//   }

//   static Future<File> imagePicker(BuildContext context, ThemeData themeData) {
//     showCupertinoModalPopup(
//         context: context,
//         builder: (BuildContext context) {
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: CupertinoActionSheet(
//               title: Text(
//                 'التقاط الصورة عبر',
//                 style: themeData.textTheme.subtitle,
//               ),
//               cancelButton: CupertinoButton(
//                 child: Text("اغلاق",
//                     style: themeData.textTheme.bodyText1.copyWith(
//                       color: kPrimaryColor,
//                     )),
//                 onPressed: () => Navigator.pop(context),
//               ),
//               actions: <Widget>[
//                 CupertinoButton(
//                     child: Row(
//                       children: <Widget>[
//                         Icon(
//                           CupertinoIcons.photo_camera_solid,
//                           color: themeData.primaryColor,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           "الكاميرا",
//                           style: themeData.textTheme.body1,
//                         ),
//                       ],
//                     ),
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       File imageFile = await pickImage(ImageSource.camera);
//                       return imageFile;
//                     }),
//                 CupertinoButton(
//                     child: Row(
//                       children: <Widget>[
//                         Icon(
//                           Icons.insert_photo,
//                           color: themeData.primaryColor,
//                         ),
//                         SizedBox(
//                           width: 20,
//                         ),
//                         Text(
//                           "الاستوديو",
//                           style: themeData.textTheme.body1,
//                         ),
//                       ],
//                     ),
//                     onPressed: () async {
//                       Navigator.pop(context);
//                       File imageFile = await pickImage(ImageSource.gallery);
//                       return imageFile;
//                     }),
//               ],
//             ),
//           );
//         });
//   }

//   static Future<Null> saveAndShare(BuildContext context) async {
//     final RenderBox box = context.findRenderObject();
//     // if (Platform.isAndroid) {
//     var url = "image Url";
//     var response = await get(Uri.parse(url));
//     final documentDirectory = (await getExternalStorageDirectory()).path;
//     File imgFile = new File('$documentDirectory/flutter.png');
//     imgFile.writeAsBytesSync(response.bodyBytes);

//     Share.shareFiles(['$documentDirectory/flutter.png'],
//         subject: 'World News',
//         text: Platform.isIOS
//             ? 'title \n'
//             // 'https://apps.apple.com/us/app/%D8%A7%D9%84%D9%83%D8%AA%D8%A7%D8%A8/id1509018977?ls=1'
//             : 'title \n' +
//                 'https://play.google.com/store/apps/details?id=com.gridsapps.worldnews',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     // }
//     // else {
//     //   Share.share('Hey! Checkout the Share Files repo',
//     //       subject: 'URL conversion + Share',
//     //       sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
//     // }
//   }

//   Widget nbAppTextFieldWidget(
//       TextEditingController controller,
//       String labelText,
//       String hintText,
//       String emptyText,
//       TextFieldType textFieldType) {
//     return AppTextField(
//       controller: controller,
//       textFieldType: textFieldType,
//       textStyle: primaryTextStyle(size: 14),
//       validator: (String val) {
//         if (val.isEmpty) {
//           return emptyText;
//         }
//       },
//       decoration: InputDecoration(
//         contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
//         filled: true,
//         fillColor: grey.withOpacity(0.1),
//         hintText: hintText,
//         hintStyle: secondaryTextStyle(),
//         errorStyle: TextStyle(
//           fontFamily: "Cairo",
//           color: Colors.red,
//           fontSize: 14,
//         ),
//         border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(16),
//             borderSide: BorderSide.none),
//       ),
//     );
//   }

//   Widget nbAppButtonWidget(BuildContext context, String text, Function onTap) {
//     return AppButton(
//       text: text,
//       textStyle: boldTextStyle(color: white),
//       color: kPrimaryColor,
//       onTap: onTap,
//       width: context.width(),
//     ).cornerRadiusWithClipRRect(20);
//   }

//   AppBar nbAppBarWidget(BuildContext context, {String title}) {
//     return AppBar(
//       leading: IconButton(
//           icon: Icon(Icons.arrow_back),
//           onPressed: () {
//             finish(context);
//           }),
//       title: Text('$title', style: boldTextStyle(color: black, size: 20)),
//       backgroundColor: white,
//       centerTitle: true,
//     );
//   }

//   InputDecoration nbInputDecoration(BuildContext context,
//       {String hintText, Widget prefixIcon}) {
//     return InputDecoration(
//       contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
//       filled: true,
//       fillColor: grey.withOpacity(0.1),
//       hintText: hintText,
//       hintStyle: secondaryTextStyle(),
//       border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
//       prefixIcon: prefixIcon,
//     );
//   }
// }
