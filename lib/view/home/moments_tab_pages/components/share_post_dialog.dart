// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:naouma/utils/constants.dart';

// class ShareMomentPostDialog extends StatelessWidget {
//   const ShareMomentPostDialog({Key key}) : super(key: key);

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
//           padding: const EdgeInsets.all(16.0),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 child: Text("المشاركة مع الاصدقاط",
//                     style: theme.textTheme.bodyText1
//                         .copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
//               ),
//               Divider(color: Colors.black),
//               Container(
//                 child: Text("اعادة نشر",
//                     style: theme.textTheme.bodyText1
//                         .copyWith(fontWeight: FontWeight.w700, fontSize: 18)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
