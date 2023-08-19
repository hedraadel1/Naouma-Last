import 'dart:io';

import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/common_functions.dart';
import 'package:project/controller/rooms_controller.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/home_screen.dart';
import 'package:project/view/home/home_tab_pages/my_room_tab.dart';
import 'package:project/view/home/states.dart';
import 'package:project/widgets/custom_raised_button.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key key}) : super(key: key);

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  File imageFile;
  TextEditingController roomnameController = TextEditingController();
  TextEditingController descnameController = TextEditingController();
  GlobalKey<FormState> fomrkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    TextStyle style = TextStyle(fontFamily: 'Almarai', fontSize: 15.0);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is HomeSuccessStates) {
          Navigator.pop(context, true);
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              title: Text("انشاء غرفة"),
            ),
            body: GetBuilder<RoomsController>(
              init: RoomsController(),
              builder: (controller) => Form(
                key: fomrkey,
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: Stack(
                            fit: StackFit.expand,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24.0)),
                                ),
                                child: imageFile == null
                                    ? Image.asset(
                                        "assets/images/Profile Image.png",
                                        fit: BoxFit.fill)
                                    : Image.file(imageFile),
                              ),
                              Positioned(
                                left: -16,
                                bottom: 0,
                                child: GestureDetector(
                                  onTap: () async {
                                    print("pick image");
                                    imageFile =
                                        await CommonFunctions.imagePicker(
                                            context, theme);
                                    controller.update();
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
                        _sizedBox(height: 36),
                        TextFormField(
                          obscureText: false,
                          style: style,
                          enabled: true,
                          maxLength: 24,
                          controller: roomnameController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            controller.roomName = value;
                          },
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "يجب ادخال رقم اسم الغرفة";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 1,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
                            errorStyle: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            labelText: "اسم الغرفة",
                            labelStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                        ),
                        Divider(color: Colors.grey),
                        _sizedBox(height: 16),
                        TextFormField(
                          obscureText: false,
                          style: style,
                          enabled: true,
                          maxLength: 240,
                          controller: descnameController,
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            controller.roomDesc = value;
                          },
                          validator: (String val) {
                            if (val.isEmpty) {
                              return "يجب ادخال رقم اشعار الغرفة";
                            } else {
                              return null;
                            }
                          },
                          maxLines: 2,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            contentPadding:
                                EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
                            errorStyle: TextStyle(
                              fontFamily: "Cairo",
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            labelText: "اشعار الغرفة",
                            labelStyle: TextStyle(fontSize: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                        ),
                        _sizedBox(height: 24),
                        ConditionalBuilder(
                          condition: state is! HomeLoadingState,
                          builder: (context) => CommonFunctions()
                              .nbAppButtonWidget(context, 'إنشاء مجانا', () {
                            if (fomrkey.currentState.validate()) {
                              HomeCubit.get(context).createroom(
                                  roomname: roomnameController.text,
                                  roomdesc: descnameController.text);
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
                        // CustomRaisedButton(
                        //   title: "انشاء مجانا",
                        //   function: () {
                        //     if (controller.globalKey.currentState
                        //         .validate()) {
                        //       // HomeCubit.get(context).createroom(
                        //       //     roomname: roomname.text,
                        //       //     roomdesc: roomdesc.text);
                        //       // No any error in validation
                        //       controller.globalKey.currentState.save();
                        //       // imageFile !=null?print("imge: ${imageFile.path}"):print("empty image");
                        //       // if(imageFile == null){
                        //       //   CommonFunctions.showToast("يجب اختيار صورة الغرفة اولا!", Colors.red);
                        //       //   return;
                        //       // }
                        //       // valid data...
                        //       // send request
                        //       // controller.createRoom(imageFile);
                        //       HomeCubit.get(context).createroom(
                        //           roomname: roomnameController.text,
                        //           roomdesc: descnameController.text);
                        //     }
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }

  void pickImage(ImageSource source) async {
    var image = await ImagePicker().getImage(source: source);
    if (image != null) {
      imageFile = File(image.path);
      print(imageFile.path);
    }
  }

  void _imagePicker(BuildContext context, ThemeData themeData) {
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
                          // style: themeData.textTheme.body1,
                        ),
                      ],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.camera);
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
                    onPressed: () {
                      Navigator.pop(context);
                      pickImage(ImageSource.gallery);
                    }),
              ],
            ),
          );
        });
  }
}

// class CreateRoomScreen extends StatelessWidget {
//   CreateRoomScreen({Key key}) : super(key: key);

//   File imageFile;
//   TextEditingController roomnameController = TextEditingController();
//   TextEditingController descnameController = TextEditingController();
//   GlobalKey<FormState> fomrkey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     TextStyle style = TextStyle(fontFamily: 'Almarai', fontSize: 15.0);

//     return BlocProvider(
//         create: (BuildContext context) => HomeCubit(),
//         child: BlocConsumer<HomeCubit, HomeStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Directionality(
//               textDirection: TextDirection.rtl,
//               child: Scaffold(
//                 appBar: AppBar(
//                   title: Text("انشاء غرفة"),
//                 ),
//                 body: GetBuilder<RoomsController>(
//                   init: RoomsController(),
//                   builder: (controller) => Form(
//                     key: fomrkey,
//                     child: SingleChildScrollView(
//                       child: Container(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               width: 120,
//                               height: 120,
//                               child: Stack(
//                                 fit: StackFit.expand,
//                                 overflow: Overflow.visible,
//                                 children: [
//                                   Container(
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.all(
//                                           Radius.circular(24.0)),
//                                     ),
//                                     child: imageFile == null
//                                         ? Image.asset(
//                                             "assets/images/Profile Image.png",
//                                             fit: BoxFit.fill)
//                                         : Image.file(imageFile),
//                                   ),
//                                   Positioned(
//                                     left: -16,
//                                     bottom: 0,
//                                     child: GestureDetector(
//                                       onTap: () async {
//                                         print("pick image");
//                                         imageFile =
//                                             await CommonFunctions.imagePicker(
//                                                 context, theme);
//                                         controller.update();
//                                       },
//                                       child: Container(
//                                         height: 46,
//                                         width: 46,
//                                         padding: const EdgeInsets.all(6.0),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           shape: BoxShape.circle,
//                                         ),
//                                         child: Icon(
//                                           Icons.camera_alt_outlined,
//                                           color: Colors.grey,
//                                           size: 28,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             _sizedBox(height: 36),
//                             TextFormField(
//                               obscureText: false,
//                               style: style,
//                               enabled: true,
//                               maxLength: 24,
//                               controller: roomnameController,
//                               keyboardType: TextInputType.text,
//                               onSaved: (value) {
//                                 controller.roomName = value;
//                               },
//                               validator: (String val) {
//                                 if (val.isEmpty) {
//                                   return "يجب ادخال رقم اسم الغرفة";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               maxLines: 1,
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white,
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
//                                 errorStyle: TextStyle(
//                                   fontFamily: "Cairo",
//                                   color: Colors.red,
//                                   fontSize: 14,
//                                 ),
//                                 labelText: "اسم الغرفة",
//                                 labelStyle: TextStyle(fontSize: 16),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(6.0)),
//                               ),
//                             ),
//                             Divider(color: Colors.grey),
//                             _sizedBox(height: 16),
//                             TextFormField(
//                               obscureText: false,
//                               style: style,
//                               enabled: true,
//                               maxLength: 240,
//                               controller: descnameController,
//                               keyboardType: TextInputType.text,
//                               onSaved: (value) {
//                                 controller.roomDesc = value;
//                               },
//                               validator: (String val) {
//                                 if (val.isEmpty) {
//                                   return "يجب ادخال رقم اشعار الغرفة";
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               maxLines: 2,
//                               decoration: InputDecoration(
//                                 fillColor: Colors.white,
//                                 contentPadding:
//                                     EdgeInsets.fromLTRB(8.0, 12.0, 8.0, 16.0),
//                                 errorStyle: TextStyle(
//                                   fontFamily: "Cairo",
//                                   color: Colors.red,
//                                   fontSize: 14,
//                                 ),
//                                 labelText: "اشعار الغرفة",
//                                 labelStyle: TextStyle(fontSize: 16),
//                                 border: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(6.0)),
//                               ),
//                             ),
//                             _sizedBox(height: 24),
//                             ConditionalBuilder(
//                               condition: state is! HomeLoadingState,
//                               builder: (context) => CommonFunctions()
//                                   .nbAppButtonWidget(context, 'إنشاء مجانا',
//                                       () {
//                                 if (fomrkey.currentState.validate()) {
//                                   HomeCubit.get(context).createroom(
//                                       roomname: roomnameController.text,
//                                       roomdesc: descnameController.text);
//                                 }
//                                 // controller.loginFormKey.currentState.save();
//                                 // // No any error in validation
//                                 // controller.loginEmail =
//                                 //     controller.phoneNumberController.text;
//                                 // controller.password =
//                                 //     controller.passwordController.text;

//                                 // controller.login();
//                               }),
//                               fallback: (context) => Center(
//                                 child: CircularProgressIndicator(),
//                               ),
//                             ),
//                             // CustomRaisedButton(
//                             //   title: "انشاء مجانا",
//                             //   function: () {
//                             //     if (controller.globalKey.currentState
//                             //         .validate()) {
//                             //       // HomeCubit.get(context).createroom(
//                             //       //     roomname: roomname.text,
//                             //       //     roomdesc: roomdesc.text);
//                             //       // No any error in validation
//                             //       controller.globalKey.currentState.save();
//                             //       // imageFile !=null?print("imge: ${imageFile.path}"):print("empty image");
//                             //       // if(imageFile == null){
//                             //       //   CommonFunctions.showToast("يجب اختيار صورة الغرفة اولا!", Colors.red);
//                             //       //   return;
//                             //       // }
//                             //       // valid data...
//                             //       // send request
//                             //       // controller.createRoom(imageFile);
//                             //       HomeCubit.get(context).createroom(
//                             //           roomname: roomnameController.text,
//                             //           roomdesc: descnameController.text);
//                             //     }
//                             //   },
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ));
//   }

//   Widget _sizedBox({double width, double height}) {
//     return SizedBox(
//       width: width,
//       height: height,
//     );
//   }

//   void pickImage(ImageSource source) async {
//     var image = await ImagePicker().getImage(source: source);
//     if (image != null) {
//       imageFile = File(image.path);
//       print(imageFile.path);
//     }
//   }

//   void _imagePicker(BuildContext context, ThemeData themeData) {
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
//                           // style: themeData.textTheme.body1,
//                         ),
//                       ],
//                     ),
//                     onPressed: () {
//                       Navigator.pop(context);
//                       pickImage(ImageSource.camera);
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
//                     onPressed: () {
//                       Navigator.pop(context);
//                       pickImage(ImageSource.gallery);
//                     }),
//               ],
//             ),
//           );
//         });
//   }
// }
