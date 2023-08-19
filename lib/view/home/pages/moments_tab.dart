// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:project/controller/home_controller.dart';

// class MomentsTab extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeController>(
//       init: Get.find(),
//       builder: (controller) => Scaffold(
//         body: controller.momentsTabChildren[controller.appBarCurrentItem],
//         floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.orangeAccent,
//           child: Icon(Icons.edit_outlined, color: Colors.white),
//           onPressed: () {
//             print("add btn clicked..");
//             // showDialog(context: context,
//             //     builder: (BuildContext context){
//             //       return AddDayMomentScreen();
//             //     }
//             // );
//           },
//         ),
//       ),
//     );
//   }
// }
