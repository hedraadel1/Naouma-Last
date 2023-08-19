// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:naouma/controller/call_center_controller.dart';
// import 'package:naouma/utils/common_functions.dart';
// import 'package:naouma/utils/constants.dart';

// class CallCenterScreen extends StatelessWidget {
//   CallCenterScreen({Key key}) : super(key: key);

//   List<String> _list = [
//     "يتعلق بالجنس",
//     "اعلانات",
//     "عنف دموي",
//     "االاعمال المخالفة للقانون",
//     "سرقة محتوي",
//     "اخري"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);

//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: SafeArea(
//         top: false,
//         child: Scaffold(
//           backgroundColor: Colors.white,
//           appBar: AppBar(
//             title: Text("الاشتكاء علي منشور"),
//           ),
//           body: GetBuilder<CallCenterController>(
//             init: CallCenterController(),
//             builder: (controller) => Container(
//               padding: const EdgeInsets.all(12.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: size.width,
//                     height: size.height * 0.25,
//                     child: Wrap(
//                       alignment: WrapAlignment.spaceAround,
//                       spacing: 15,
//                       runSpacing: 5,
//                       children: List.generate(
//                         _list.length,
//                         (index) => SizedBox(
//                           width: size.width / 2 - 20,
//                           child: FlatButton(
//                             padding: const EdgeInsets.all(6.0),
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(16.0)),
//                             onPressed: () {
//                               controller.updateSelectedReason(index);
//                             },
//                             child: FittedBox(
//                                 child: Text(
//                               _list[index],
//                               style:
//                                   TextStyle(color: Colors.white, fontSize: 18),
//                             )),
//                             color: controller.selectedReasonIndex == index
//                                 ? kPrimaryColor.withOpacity(0.7)
//                                 : Colors.grey.shade300,
//                           ),
//                         ),
//                       ).toList(),
//                     ),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                     ),
//                     child: Text("وصف المحتوي"),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   TextField(
//                     controller: controller.editingController,
//                     keyboardType: TextInputType.text,
//                     obscureText: false,
//                     maxLines: 3,
//                     maxLength: 200,
//                     decoration: InputDecoration.collapsed(
//                         hintText: "وصف سبب الاشتكاء عن هذا المنشور"),
//                   ),
//                   Container(
//                     width: double.infinity,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 12, vertical: 10),
//                     decoration: BoxDecoration(
//                       color: Colors.grey.shade300,
//                     ),
//                     child: Text("لقطة الشاشة (اختياري)"),
//                   ),
//                   SizedBox(
//                     height: 16,
//                   ),
//                   SizedBox(
//                     width: 128,
//                     height: 128,
//                     child: DottedBorder(
//                       borderType: BorderType.RRect,
//                       radius: Radius.circular(12),
//                       padding: EdgeInsets.all(8),
//                       child: Center(
//                           child: GestureDetector(
//                               onTap: () async {
//                                 await CommonFunctions.imagePicker(
//                                         context, theme)
//                                     .then((value) {
//                                   print(value.path);
//                                 });
//                               },
//                               child: Icon(
//                                 Icons.add_a_photo_outlined,
//                                 color: Colors.grey,
//                                 size: 86,
//                               ))),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: GestureDetector(
//             onTap: () => print("shawa approve clicked"),
//             child: Container(
//               width: size.width,
//               height: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//               ),
//               child: Center(
//                 child: Text(
//                   "تقديم",
//                   style: theme.textTheme.bodyText1
//                       .copyWith(color: kPrimaryColor, fontSize: 19),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
