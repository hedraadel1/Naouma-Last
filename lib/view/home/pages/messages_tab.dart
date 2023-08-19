// import 'dart:ui';

// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/instance_manager.dart';
// import 'package:project/common_functions.dart';
// import 'package:project/models/auth_model.dart';
// import 'package:project/models/create_user_model.dart';
// import 'package:project/models/show_friends_model.dart';
// import 'package:project/oneTo_one_screen.dart';
// import 'package:project/utils/constants.dart';
// import 'package:project/view/home/homeCubit.dart';
// import 'package:project/view/home/states.dart';

// class MessagesTab extends StatefulWidget {
//   const MessagesTab({Key key}) : super(key: key);

//   @override
//   State<MessagesTab> createState() => _MessageTabState();
// }

// class _MessageTabState extends State<MessagesTab> {
//   List<String> list = List.generate(100, (i) => i.toString());

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..showfriends(),
//       child: BlocConsumer<HomeCubit, HomeStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return ConditionalBuilder(
//               condition: HomeCubit.get(context).showFriendsModel != null,
//               builder: (context) =>
//                   builditem(HomeCubit.get(context).showFriendsModel, context),
//               fallback: (context) => Container(
//                 color: Colors.white,
//                 child: Center(
//                   child: Container(
//                       child: Text(
//                     'لا يوجد أصدقاء ',
//                     style: TextStyle(color: Colors.grey),
//                   )),
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   Widget builditem(ShowFriendsModel model, context) => Scaffold(
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             child: ListView.separated(
//               itemBuilder: (context, index) => buildfriendRequestItem(
//                   HomeCubit.get(context).showFriendsModel.data[index], context),
//               itemCount: HomeCubit.get(context).showFriendsModel.data.length,
//               separatorBuilder: (BuildContext context, int index) => Divider(),
//             ),
//           ),
//         ),
//       );

//   void removeItem(int index) {
//     setState(() {
//       list = List.from(list)..removeAt(index);
//     });
//   }

//   Widget buildfriendRequestItem(
//     ShowFriendsModelData model,
//     context,
//   ) =>
//       InkWell(
//         onTap: () {
//           Get.to(Onechat(
//             userModel: model,
//             //  createUserModel: model,
//             //  userModel: model,
//           ));
//           // Navigator.push(
//           //     context,
//           //     MaterialPageRoute(
//           //       builder: (context) => Onechat(
//           //           // userModel: model),
//           //           ),
//           //     ));
//         },
//         child: Container(
//           margin: const EdgeInsets.all(6.0),
//           padding: const EdgeInsets.all(4.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(12.0)),
//             color: Colors.white,
//           ),
//           child: ListTile(
//             leading: CircleAvatar(
//               child: Image.asset("assets/images/Profile Image.png"),
//               backgroundColor: kPrimaryColor,
//               radius: 28,
//             ),
//             title: Text(model.name),
//             subtitle: Text(
//               model.userId,
//               // style: theme.textTheme.bodyText2
//               // .copyWith(fontSize: 13, color: Colors.grey),
//               maxLines: 2,
//             ),
//             trailing: TextButton(
//                 onPressed: () {},
//                 child: Container(
//                     width: 50,
//                     decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius: BorderRadius.only(
//                         topRight: Radius.circular(10),
//                         bottomRight: Radius.circular(10),
//                         bottomLeft: Radius.circular(10),
//                         topLeft: Radius.circular(10),
//                       ),
//                       border: Border.all(
//                         width: 1,
//                         color: kPrimaryColor,
//                         style: BorderStyle.solid,
//                       ),
//                       // shape: BoxShape.circle,
//                     ),
//                     child: Center(
//                         child: TextButton(
//                       onPressed: () {
//                         showDialog<String>(
//                           context: context,
//                           builder: (BuildContext context) => Directionality(
//                             textDirection: TextDirection.rtl,
//                             child: AlertDialog(
//                               title: const Text('إزاله من قائمه الاصدقاء'),
//                               // content: const Text('AlertDialog description'),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () {
//                                     HomeCubit.get(context)
//                                         .deletefriend(id: model.id);
//                                     Navigator.pop(context, 'no');

//                                     CommonFunctions.showToast(
//                                         'تم ازاله العضو', Colors.green);
//                                   },
//                                   child: const Text('نعم'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context, 'no'),
//                                   child: const Text('لا'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                         // HomeCubit.get(context).deletefriend(id: model.id);
//                       },
//                       child: Text(
//                         "إزالة ",
//                         style: TextStyle(fontSize: 12, color: Colors.white),
//                       ),
//                     )))),
//           ),
//         ),
//       );
// }

// // // class MessagesTab extends StatelessWidget {
// // //   @override

// // //   Widget builditem(ShowFriendsModel model, context) => Scaffold(
// // //         body: Padding(
// // //           padding: const EdgeInsets.all(8.0),
// // //           child: Container(
// // //             child: ListView.separated(
// // //               itemBuilder: (context, index) => buildfriendRequestItem(
// // //                   HomeCubit.get(context).showFriendsModel.data[index], context),
// // //               itemCount: HomeCubit.get(context).showFriendsModel.data.length,
// // //               separatorBuilder: (BuildContext context, int index) => Divider(),
// // //             ),
// // //           ),
// // //         ),
// // //       );

// // //   Widget buildfriendRequestItem(ShowFriendsModelData model, context,) => InkWell(
// // //         onTap: () {
// // //           Get.to(Onechat(
// // //             userModel: model,
// // //             //  createUserModel: model,
// // //             //  userModel: model,
// // //           ));
// // //           // Navigator.push(
// // //           //     context,
// // //           //     MaterialPageRoute(
// // //           //       builder: (context) => Onechat(
// // //           //           // userModel: model),
// // //           //           ),
// // //           //     ));
// // //         },
// // //         child: Container(
// // //           margin: const EdgeInsets.all(6.0),
// // //           padding: const EdgeInsets.all(4.0),
// // //           decoration: BoxDecoration(
// // //             borderRadius: BorderRadius.all(Radius.circular(12.0)),
// // //             color: Colors.white,
// // //           ),
// // //           child: ListTile(
// // //             leading: CircleAvatar(
// // //               child: Image.asset("assets/images/Profile Image.png"),
// // //               backgroundColor: kPrimaryColor,
// // //               radius: 28,
// // //             ),
// // //             title: Text(model.name),
// // //             subtitle: Text(
// // //               model.userId,
// // //               // style: theme.textTheme.bodyText2
// // //               // .copyWith(fontSize: 13, color: Colors.grey),
// // //               maxLines: 2,
// // //             ),
// // //             trailing: TextButton(
// // //                 onPressed: () {},
// // //                 child: Container(
// // //                     width: 50,
// // //                     decoration: BoxDecoration(
// // //                       color: kPrimaryColor,
// // //                       borderRadius: BorderRadius.only(
// // //                         topRight: Radius.circular(10),
// // //                         bottomRight: Radius.circular(10),
// // //                         bottomLeft: Radius.circular(10),
// // //                         topLeft: Radius.circular(10),
// // //                       ),
// // //                       border: Border.all(
// // //                         width: 1,
// // //                         color: kPrimaryColor,
// // //                         style: BorderStyle.solid,
// // //                       ),
// // //                       // shape: BoxShape.circle,
// // //                     ),
// // //                     child: Center(
// // //                         child: TextButton(
// // //                       onPressed: () {
// // //                         showDialog<String>(
// // //                           context: context,
// // //                           builder: (BuildContext context) => Directionality(
// // //                             textDirection: TextDirection.rtl,
// // //                             child: AlertDialog(
// // //                               title: const Text('إزاله من قائمه الاصدقاء'),
// // //                               // content: const Text('AlertDialog description'),
// // //                               actions: <Widget>[
// // //                                 TextButton(
// // //                                   onPressed: () {
// // //                                     HomeCubit.get(context)
// // //                                         .deletefriend(id: model.id);
// // //                                     Navigator.pop(context, 'no');

// // //                                     CommonFunctions.showToast(
// // //                                         'تم ازاله العضو', Colors.green);
// // //                                   },
// // //                                   child: const Text('نعم'),
// // //                                 ),
// // //                                 TextButton(
// // //                                   onPressed: () => Navigator.pop(context, 'no'),
// // //                                   child: const Text('لا'),
// // //                                 ),
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         );
// // //                         // HomeCubit.get(context).deletefriend(id: model.id);
// // //                       },
// // //                       child: Text(
// // //                         "إزالة ",
// // //                         style: TextStyle(fontSize: 12, color: Colors.white),
// // //                       ),
// // //                     )))),
// // //           ),
// // //         ),
// // //       );
// // // }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/controller/home_controller.dart';

class MomentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: Get.find(),
      builder: (controller) => Scaffold(
        body: controller.momentsTabChildren[controller.appBarCurrentItem],
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.orangeAccent,
        //   child: Icon(Icons.edit_outlined, color: Colors.white),
        //   onPressed: () {
        //     print("add btn clicked..");
        //     // showDialog(context: context,
        //     //     builder: (BuildContext context){
        //     //       return AddDayMomentScreen();
        //     //     }
        //     // );
        //   },
        // ),
      ),
    );
  }
}
