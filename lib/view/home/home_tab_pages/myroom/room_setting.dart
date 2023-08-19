import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/common_functions.dart';
import 'package:project/utils/constants.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:project/view/details/newPage.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/home_tab_pages/myroom/blackList.dart';
import 'package:project/view/home/home_tab_pages/myroom/usersFollowRoom.dart';
import 'package:project/view/home/states.dart';
import 'package:image_picker/image_picker.dart';

class RoomSettings extends StatefulWidget {
  String roomName;
  String roomID;
  String roomImage;

  String type;
  String giftId;
  String controller;
  bool status = false;
  RoomSettings(
      {this.roomName,
      this.type,
      this.giftId,
      this.controller,
      this.roomID,
      this.roomImage});

  @override
  State<RoomSettings> createState() => _RoomSettingsState();
}

class _RoomSettingsState extends State<RoomSettings> {
  Future<File> pickImage(ImageSource source) async {
    var image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
      imagename = imageFile.path.split("/").last;
      // base64 = base64Encode(imageFile.readAsBytesSync());
      //  imageFile.path.split("/").last;

      print(imageFile.path);

      return imageFile;
    }
  }

  Future<File> imagePicker(BuildContext context, ThemeData themeData) {
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    TextEditingController roomNamecontroller = TextEditingController();
    TextEditingController roomDesccontroller = TextEditingController();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is EditRoomSuccessStates) {
          CommonFunctions.showToast('تم التعديل', Colors.green);
          Navigator.pop(context);
          Get.to(DetailsScreen());
        }
      },
      builder: (context, state) {
        roomNamecontroller.text = widget.roomName;
        roomDesccontroller.text = widget.type;
        return Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: AppBar(
              actions: [
                TextButton(
                  child: Text(
                    "تعديل",
                    style: TextStyle(color: kPrimaryLightColor, fontSize: 15),
                  ),
                  onPressed: () {
                    print('imaaaaaaaaaaaaage');
                    print(imageFile);

                    HomeCubit.get(context).editRoom(
                        roomdesc: roomDesccontroller.text,
                        name: roomNamecontroller.text,
                        countMics: 10,
                        supervisor: 1,
                        imagefile: imageFile,
                        filename: imagename);
                  },
                )
              ],
              title: Text(
                "الاعدادات",
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
            ),
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                    child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 120,
                                height: 120,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    clipBehavior: Clip.none,
                                    children: [
                                      Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            // color: Colors.grey.shade400,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24.0)),
                                          ),
                                          child: imageFile == null
                                              ? Image.network(widget.roomImage,
                                                  fit: BoxFit.fill)
                                              : Image.file(imageFile),
                                        ),
                                      ),
                                      Positioned(
                                        left: -16,
                                        bottom: 0,
                                        child: GestureDetector(
                                          onTap: () async {
                                            print("pick image");

                                            imageFile = await imagePicker(
                                                context, theme);
                                            //  controller.update();
                                          },
                                          child: Container(
                                            height: 46,
                                            width: 46,
                                            padding: const EdgeInsets.all(6.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              color: Colors.grey,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 40,
                                      child: TextField(
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              height: 0.5,
                                              color: Colors.black),
                                          controller: roomNamecontroller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                            ),
                                            // hintText: "aaaaa"
                                          )),
                                    ),
                                    Spacer(),
                                    Text(
                                      "اسم الغرفة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 40,
                                      child: TextField(
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              height: 0.5,
                                              color: Colors.black),
                                          controller: roomDesccontroller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey.shade400),
                                            ),
                                            // hintText: "aaaaa"
                                          )),
                                    ),
                                    Spacer(),
                                    Text(
                                      "إشعار عام",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      "التصنيف",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: InkWell(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Spacer(),
                                      Text(
                                        "قائمة الاعضاء",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UsersFollowRoom(
                                                  roomID: widget.roomID,
                                                )));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '0',
                                      style:
                                          TextStyle(color: KstorebuttonColor),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.monetization_on_rounded,
                                      color: Colors.orange,
                                      size: 16,
                                    ),
                                    Spacer(),
                                    Text(
                                      "رسوم العضوية",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      "المكافأة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '5',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      "عدد المايكات",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'الاعضاء فقط',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    Spacer(),
                                    Text(
                                      "الاذن لاخذ المايك",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoSwitch(
                                      value: widget.status,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   status = value;
                                        // });
                                      },
                                    ),
                                    Spacer(),
                                    Text(
                                      "السماح للمشرفين بقفل/إلغاء قفل المايك",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    // Text(
                                    //   '',
                                    //   style: TextStyle(color: Colors.grey),
                                    // ),
                                    // Spacer(),

                                    InkWell(
                                      child: Container(
                                        child: Text(
                                          "المستخدمين الممنوعين من الدخول",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      onTap: () {
                                        Get.to(BlockListRoom());
                                      },
                                    ),

                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "المستخدمين المزالون في الغرفة ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CupertinoSwitch(
                                      value: widget.status,
                                      onChanged: (value) {
                                        // setState(() {
                                        //   status = value;
                                        // });
                                      },
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "السماح للزوار بالدخول",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "يمكن للمستخدمين الآخرين دخول غرفتي",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(
                                          "من دون تسجيل الدخول ",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.stretch,
                //     children: <Widget>[
                //       Expanded(
                //         child: Container(
                //           color: Colors.purple,
                //         ),
                //       ),
                //       Expanded(
                //         child: Container(
                //           color: Colors.black,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ));
      },
    );
  }
}

// class RoomSettings extends StatelessWidget {
//   String roomName;
//   String roomID;
//   String roomImage;

//   String type;
//   String giftId;
//   String controller;
//   bool status = false;
//   // File imageFile;

//   RoomSettings(
//       {this.roomName,
//       this.type,
//       this.giftId,
//       this.controller,
//       this.roomID,
//       this.roomImage});

//   static Future<File> pickImage(ImageSource source) async {
//     var image = await ImagePicker().pickImage(source: source);
//     if (image != null) {
//       imageFile = File(image.path);

//       imagename = imageFile.path.split("/").last;
//       // base64 = base64Encode(imageFile.readAsBytesSync());
//       //  imageFile.path.split("/").last;

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
//                 // style: themeData.textTheme.subtitle,
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
//                           //  style: themeData.textTheme.body1,
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
//                           // style: themeData.textTheme.body1,
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

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     TextEditingController roomNamecontroller = TextEditingController();
//     TextEditingController roomDesccontroller = TextEditingController();

//     return BlocConsumer<HomeCubit, HomeStates>(
//       listener: (context, state) {
//         if (state is EditRoomSuccessStates) {
//           CommonFunctions.showToast('تم التعديل', Colors.green);
//         }
//       },
//       builder: (context, state) {
//         roomNamecontroller.text = roomName;
//         roomDesccontroller.text = type;
//         return Scaffold(
//             backgroundColor: Colors.grey[300],
//             appBar: AppBar(
//               actions: [
//                 TextButton(
//                   child: Text(
//                     "تعديل",
//                     style: TextStyle(color: kPrimaryLightColor, fontSize: 15),
//                   ),
//                   onPressed: () {
//                     print('imaaaaaaaaaaaaage');
//                     print(imageFile);

//                     HomeCubit.get(context).editRoom(
//                         roomdesc: roomDesccontroller.text,
//                         name: roomNamecontroller.text,
//                         countMics: 10,
//                         supervisor: 1,
//                         imagefile: imageFile,
//                         filename: imagename);
//                   },
//                 )
//               ],
//               title: Text(
//                 "الاعدادات",
//                 style: TextStyle(color: Colors.white),
//               ),
//               centerTitle: true,
//             ),
//             body: Row(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Expanded(
//                     child: ListView(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: <Widget>[
//                         Container(
//                           color: Colors.white,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               SizedBox(
//                                 width: 120,
//                                 height: 120,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Stack(
//                                     fit: StackFit.expand,
//                                     overflow: Overflow.visible,
//                                     children: [
//                                       Center(
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             // color: Colors.grey.shade400,
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(24.0)),
//                                           ),
//                                           child: imageFile == null
//                                               ? Image.network(roomImage,
//                                                   fit: BoxFit.fill)
//                                               : Image.file(imageFile),
//                                         ),
//                                       ),
//                                       Positioned(
//                                         left: -16,
//                                         bottom: 0,
//                                         child: GestureDetector(
//                                           onTap: () async {
//                                             print("pick image");

//                                             imageFile = await imagePicker(
//                                                 context, theme);
//                                             //  controller.update();
//                                           },
//                                           child: Container(
//                                             height: 46,
//                                             width: 46,
//                                             padding: const EdgeInsets.all(6.0),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               shape: BoxShape.circle,
//                                             ),
//                                             child: Icon(
//                                               Icons.camera_alt_outlined,
//                                               color: Colors.grey,
//                                               size: 28,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Container(
//                                       width: 150,
//                                       height: 40,
//                                       child: TextField(
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               height: 0.5,
//                                               color: Colors.black),
//                                           controller: roomNamecontroller,
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20.0)),
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey.shade400),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20.0)),
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey.shade400),
//                                             ),
//                                             // hintText: "aaaaa"
//                                           )),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "اسم الغرفة",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Container(
//                                       width: 200,
//                                       height: 40,
//                                       child: TextField(
//                                           style: TextStyle(
//                                               fontSize: 15.0,
//                                               height: 0.5,
//                                               color: Colors.black),
//                                           controller: roomDesccontroller,
//                                           decoration: InputDecoration(
//                                             border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20.0)),
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey.shade400),
//                                             ),
//                                             enabledBorder: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(20.0)),
//                                               borderSide: BorderSide(
//                                                   color: Colors.grey.shade400),
//                                             ),
//                                             // hintText: "aaaaa"
//                                           )),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "إشعار عام",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '',
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "التصنيف",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: InkWell(
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.end,
//                                     children: [
//                                       Spacer(),
//                                       Text(
//                                         "قائمة الاعضاء",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                   onTap: () {
//                                     Navigator.of(context).push(
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 UsersFollowRoom(
//                                                   roomID: roomID,
//                                                 )));
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           color: Colors.white,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '0',
//                                       style:
//                                           TextStyle(color: KstorebuttonColor),
//                                     ),
//                                     SizedBox(
//                                       width: 5,
//                                     ),
//                                     Icon(
//                                       Icons.monetization_on_rounded,
//                                       color: Colors.orange,
//                                       size: 16,
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "رسوم العضوية",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '',
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "المكافأة",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           color: Colors.white,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       '5',
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "عدد المايكات",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       'الاعضاء فقط',
//                                       style: TextStyle(color: Colors.grey),
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "الاذن لاخذ المايك",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     CupertinoSwitch(
//                                       value: status,
//                                       onChanged: (value) {
//                                         // setState(() {
//                                         //   status = value;
//                                         // });
//                                       },
//                                     ),
//                                     Spacer(),
//                                     Text(
//                                       "السماح للمشرفين بقفل/إلغاء قفل المايك",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                           color: Colors.white,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     // Text(
//                                     //   '',
//                                     //   style: TextStyle(color: Colors.grey),
//                                     // ),
//                                     // Spacer(),

//                                     InkWell(
//                                       child: Container(
//                                         child: Text(
//                                           "المستخدمين الممنوعين من الدخول",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ),
//                                       onTap: () {
//                                         Get.to(BlockListRoom());
//                                       },
//                                     ),

//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Text(
//                                       "المستخدمين المزالون في الغرفة ",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Divider(),
//                               Padding(
//                                 padding: const EdgeInsets.all(15.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     CupertinoSwitch(
//                                       value: status,
//                                       onChanged: (value) {
//                                         // setState(() {
//                                         //   status = value;
//                                         // });
//                                       },
//                                     ),
//                                     Spacer(),
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         Text(
//                                           "السماح للزوار بالدخول",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "يمكن للمستخدمين الآخرين دخول غرفتي",
//                                           style: TextStyle(color: Colors.grey),
//                                         ),
//                                         Text(
//                                           "من دون تسجيل الدخول ",
//                                           style: TextStyle(color: Colors.grey),
//                                         ),
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 )),
//                 // Expanded(
//                 //   child: Column(
//                 //     crossAxisAlignment: CrossAxisAlignment.stretch,
//                 //     children: <Widget>[
//                 //       Expanded(
//                 //         child: Container(
//                 //           color: Colors.purple,
//                 //         ),
//                 //       ),
//                 //       Expanded(
//                 //         child: Container(
//                 //           color: Colors.black,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ));
//       },
//     );
//   }
// }
