// import 'dart:io';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:naouma/controller/moments_controller.dart';
// import 'package:naouma/utils/common_functions.dart';
// import 'package:naouma/utils/constants.dart';

// import 'add_subject_today_moment.dart';

// class AddDayMomentScreen extends StatelessWidget {
//   const AddDayMomentScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: GetBuilder<MomentsController>(
//         init: MomentsController(),
//         builder: (controller) => SafeArea(
//           top: false,
//           child: Scaffold(
//             backgroundColor: Colors.white,
//             appBar: AppBar(
//               title: Text("لحظاتي"),
//               backgroundColor: kPrimaryColor,
//               actions: [
//                 FlatButton(
//                     onPressed: () => print("publish btn cliked"),
//                     child: Text(
//                       "نشر",
//                       style: theme.textTheme.bodyText1
//                           .copyWith(color: Colors.white, fontSize: 18),
//                     ))
//               ],
//             ),
//             body: Container(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   GestureDetector(
//                     onTap: () async {
//                       final result = await Get.to(AddSubjectToDayMoment());
//                       print("return data: $result");
//                       controller.setSelectedSubject("نشاطات اللحظات في يلا");
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.all(10.0),
//                       color: Colors.white,
//                       child: Row(
//                         children: [
//                           Image.asset("assets/icons/slack_icon.png",
//                               width: 24, height: 24),
//                           _sizedBox(width: 12),
//                           Expanded(
//                               child: Text(controller.selectedSubjectTitle,
//                                   style: theme.textTheme.bodyText1
//                                       .copyWith(fontSize: 18))),
//                           Icon(Icons.arrow_back_ios_rounded)
//                         ],
//                       ),
//                     ),
//                   ),
//                   Divider(color: Colors.grey),
//                   Expanded(
//                       child: Container(
//                     padding: const EdgeInsets.all(16.0),
//                     child: SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextFormField(
//                             obscureText: false,
//                             maxLines: 4,
//                             onSaved: (value) {},
//                             keyboardType: TextInputType.text,
//                             decoration: InputDecoration.collapsed(
//                                 hintText:
//                                     "تودي اضافة مواضيع ذات صلة الي زيادة فرص ترشيحك ضمن المقترحة"),
//                           ),
//                           _sizedBox(height: 28),
//                           SizedBox(
//                             width: 128,
//                             height: 128,
//                             child: DottedBorder(
//                               borderType: BorderType.RRect,
//                               radius: Radius.circular(12),
//                               padding: EdgeInsets.all(8),
//                               child: Center(
//                                   child: GestureDetector(
//                                       onTap: () async {
//                                         await CommonFunctions.imagePicker(
//                                                 context, theme)
//                                             .then((value) {
//                                           print(value.path);
//                                         });
//                                       },
//                                       child: Icon(
//                                         Icons.add_a_photo_outlined,
//                                         color: Colors.grey,
//                                         size: 86,
//                                       ))),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   )),
//                   Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () => controller.getMyLocation(),
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 3.0, horizontal: 6.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.25),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.location_on_outlined),
//                                 _sizedBox(width: 3.0),
//                                 Text(controller.currentAddress),
//                               ],
//                             ),
//                           ),
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             // showDialog(context: context,
//                             //     builder: (BuildContext context){
//                             //       return ShareWithDialog();
//                             //     }
//                             // );
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 vertical: 3.0, horizontal: 6.0),
//                             decoration: BoxDecoration(
//                               color: Colors.grey.withOpacity(0.25),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10.0)),
//                               border: Border.all(color: Colors.grey),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(Icons.language),
//                                 _sizedBox(width: 3.0),
//                                 Text("عام")
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _sizedBox({double width, double height}) {
//     return SizedBox(
//       width: width,
//       height: height,
//     );
//   }
// }
