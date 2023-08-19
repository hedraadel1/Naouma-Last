// import 'package:flutter/material.dart';
// import 'package:naouma/utils/constants.dart';
// import 'package:naouma/widgets/custom_raised_button.dart';

// class DailyPrizeDialog extends StatelessWidget {
//   const DailyPrizeDialog({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Dialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(kBorderRadius),
//         ),
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         child: contentBox(context, theme),
//       ),
//     );
//   }

//   contentBox(context, ThemeData theme) {
//     return Stack(
//       children: <Widget>[
//         Container(
//           // padding: const EdgeInsets.all(kDefaultPadding),
//           decoration: BoxDecoration(
//               shape: BoxShape.rectangle,
//               color: Colors.white,
//               borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
//               boxShadow: [
//                 BoxShadow(
//                     color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
//               ]),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 100,
//                 decoration: BoxDecoration(
//                   color: Colors.deepOrange,
//                   borderRadius:
//                       BorderRadius.vertical(bottom: Radius.circular(16.0)),
//                 ),
//                 child: Center(
//                     child: Text(
//                   "الجائزة اليومية",
//                   style: theme.textTheme.bodyText1
//                       .copyWith(fontWeight: FontWeight.bold, fontSize: 19),
//                 )),
//               ),
//               GridView.builder(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 24, horizontal: 16.0),
//                 shrinkWrap: true,
//                 itemCount: 8,
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 4.0,
//                     mainAxisSpacing: 4.0,
//                     childAspectRatio: 1),
//                 itemBuilder: (context, index) {
//                   return Stack(
//                     children: [
//                       Container(
//                         width: 100,
//                         height: 100,
//                         padding: const EdgeInsets.all(16.0),
//                         decoration: BoxDecoration(
//                             color: Color(0xfffae4fc),
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(8.0))),
//                         child: Icon(
//                           Icons.style,
//                         ),
//                       ),
//                       Positioned(
//                         top: 0,
//                         right: 0,
//                         child: Container(
//                             padding: const EdgeInsets.symmetric(
//                                 horizontal: 4.0, vertical: 2.0),
//                             decoration: BoxDecoration(
//                                 color: Colors.deepPurple,
//                                 borderRadius: BorderRadius.only(
//                                     bottomLeft: Radius.circular(16.0))),
//                             child: Text(
//                               "${index + 1}",
//                               style: theme.textTheme.button,
//                             )),
//                       ),
//                     ],
//                   );
//                 },
//               ),
//               Text(
//                 "لقد سجلت الدخول لمدة ١ يوما",
//                 style: theme.textTheme.bodyText1
//                     .copyWith(fontSize: 16, fontWeight: FontWeight.w600),
//               ),
//               SizedBox(
//                 height: kDefaultPadding,
//               ),
//               Padding(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
//                 child: CustomRaisedButton(
//                   title: "تسجيل دخول",
//                   function: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           left: kBorderRadius / 2,
//           top: kBorderRadius / 2,
//           child: GestureDetector(
//             onTap: () => Navigator.pop(context),
//             child: Container(
//               padding: const EdgeInsets.all(6.0),
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 shape: BoxShape.circle,
//               ),
//               child: Icon(
//                 Icons.close,
//                 size: 24,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
