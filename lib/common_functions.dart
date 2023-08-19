/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mime/mime.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/utils/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// import 'package:mime_type/mime_type.dart';

class CommonFunctions {
  static Future<File> pickImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      imageFile = File(image.path);

      imagename = imageFile.path.split("/").last;
      base64 = base64Encode(imageFile.readAsBytesSync());
      //  imageFile.path.split("/").last;

      print(imageFile.path);

      return imageFile;
    }
  }

  static Future<File> imagePicker(BuildContext context, ThemeData themeData) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: CupertinoActionSheet(
              title: Text(
                'التقاط الصورة عبر',
                // style: themeData.textTheme.subtitle,
              ),
              cancelButton: CupertinoButton(
                child: Text("اغلاق",
                    style: themeData.textTheme.bodyText1.copyWith(
                      color: kPrimaryColor,
                    )),
                onPressed: () => Navigator.pop(context),
              ),
              actions: <Widget>[
                CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          CupertinoIcons.photo_camera_solid,
                          color: themeData.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "الكاميرا",
                          //  style: themeData.textTheme.body1,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      File imageFile = await pickImage(ImageSource.camera);
                      return imageFile;
                    }),
                CupertinoButton(
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.insert_photo,
                          color: themeData.primaryColor,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "الاستوديو",
                          // style: themeData.textTheme.body1,
                        ),
                      ],
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                      File imageFile = await pickImage(ImageSource.gallery);
                      return imageFile;
                    }),
              ],
            ),
          );
        });
  }

  static showAlertWithTwoActions(
    String roomID,
    BuildContext context,
    String title,
    String message,
    Function function,
  ) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("الغاء"),
      onPressed: () {
        finish(context);
        // HomeCubit.get(context).logoutUserRoom(id: roomID);
      },
    );
    Widget continueButton = TextButton(child: Text("موافق"), onPressed: function

        //  HomeCubit.get(context).logoutUserRoom(id: roomID);

        );
    // set up the AlertDialog
    CupertinoAlertDialog alert = CupertinoAlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  static Future<bool> showToast(String msg, Color bgColor) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bgColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget nbAppTextFieldWidget(
      TextEditingController controller,
      String labelText,
      String hintText,
      String emptyText,
      TextFieldType textFieldType) {
    return AppTextField(
      controller: controller,
      textFieldType: textFieldType,
      textStyle: primaryTextStyle(size: 14),
      validator: (String val) {
        if (val.isEmpty) {
          return emptyText;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        filled: true,
        fillColor: grey.withOpacity(0.1),
        hintText: hintText,
        hintStyle: secondaryTextStyle(),
        errorStyle: TextStyle(
          fontFamily: "Cairo",
          color: Colors.red,
          fontSize: 14,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none),
      ),
    );
  }

  Widget searchAppTextFieldWidget(
      TextEditingController controller,
      String labelText,
      String hintText,
      String emptyText,
      TextFieldType textFieldType) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AppTextField(
        controller: controller,
        textFieldType: textFieldType,
        textStyle: primaryTextStyle(size: 14),
        validator: (String val) {
          if (val.isEmpty) {
            return emptyText;
          }
        },
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          filled: true,
          fillColor: grey.withOpacity(0.1),
          hintText: hintText,
          hintStyle: secondaryTextStyle(),
          errorStyle: TextStyle(
            fontFamily: "Cairo",
            color: Colors.red,
            fontSize: 14,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }

  Widget nbAppButtonWidget(BuildContext context, String text, Function onTap) {
    return AppButton(
      text: text,
      textStyle: boldTextStyle(color: white),
      color: kPrimaryColor,
      onTap: onTap,
      width: context.width(),
    ).cornerRadiusWithClipRRect(20);
  }

  AppBar nbAppBarWidget(BuildContext context, {String title}) {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            finish(context);
          }),
      title: Text('$title', style: boldTextStyle(color: black, size: 20)),
      backgroundColor: white,
      centerTitle: true,
    );
  }

  InputDecoration nbInputDecoration(BuildContext context,
      {String hintText, Widget prefixIcon}) {
    return InputDecoration(
      contentPadding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      filled: true,
      fillColor: grey.withOpacity(0.1),
      hintText: hintText,
      hintStyle: secondaryTextStyle(),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      prefixIcon: prefixIcon,
    );
  }
}
