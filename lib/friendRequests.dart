import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/friendRequest_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/moments_tab_pages/suggested_view.dart';
import 'package:project/view/home/states.dart';

class FriendRequestsScreen extends StatefulWidget {
  const FriendRequestsScreen({Key key}) : super(key: key);

  @override
  State<FriendRequestsScreen> createState() => _FriendRequestsScreenState();
}

class _FriendRequestsScreenState extends State<FriendRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (BuildContext context) {
      HomeCubit.get(context).getfriendRequests();
      return BlocConsumer<HomeCubit, HomeStates>(listener: (context, state) {
        if (state is AcceptFriendRequestsSuccessStates) {
          CommonFunctions.showToast('تم قبول الطلب', Colors.green);
          HomeCubit.get(context).getfriendRequests();
        }
      }, builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('طلبات الصداقة'),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => SuggestedView()),
                // );
              },
            ),
          ),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).friendRequestsModel != null,
            builder: (context) =>
                builditem(HomeCubit.get(context).friendRequestsModel, context),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: Container(
                    child: Text(
                  'لا يوجد طلبات صداقة',
                  style: TextStyle(color: Colors.grey),
                )),
              ),
            ),
          ),
        );
      });
    }
        // create: (context) => HomeCubit()..getfriendRequests(),

        );
  }

  // Widget build(BuildContext context) {
  //   return Builder(
  //     builder: (BuildContext context) {
  //       // ShopCubit.get(context).getBackgroundData();
  //       ShopCubit.get(context).getWalletAmount();
  //       // ShopCubit.get(context).mySpecialID();
  //       // HomeCubit.get(context).getWalletAmount();
  //       return BlocConsumer<ShopCubit, ShopIntresStates>(
  //         listener: (context, state) {
  //           if (state is PersonalPurchaseIDSuccessStates) {
  //             ShopCubit.get(context).mySpecialID();
  //             ShopCubit.get(context).getWalletAmount();
  //           }
  //         },
  //         builder: (context, state) {
  //           return ConditionalBuilder(
  //             condition: ShopCubit.get(context).specialIDModel != null,
  //             builder: (context) => getIDItem(
  //                 ShopCubit.get(context).specialIDModel,
  //                 ShopCubit.get(context).getWalletModel),
  //             fallback: (context) => Container(
  //               color: Colors.white,
  //               child: Center(
  //                 child: CircularProgressIndicator(),
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  Widget builditem(FriendRequestsModel model, context) => Scaffold(
          // appBar: AppBar(),
          body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: ListView.separated(
            itemBuilder: (context, index) => buildfriendRequestItem(
                HomeCubit.get(context).friendRequestsModel.message[index],
                context),
            itemCount:
                HomeCubit.get(context).friendRequestsModel.message.length,
            separatorBuilder: (BuildContext context, int index) => Divider(),
          ),
        ),
      ));

  Widget buildfriendRequestItem(Message model, context) => InkWell(
        onTap: () {
          // Get.to(Onechat(
          //   userModel: model,
          //   //  createUserModel: model,
          //   //  userModel: model,
          // ));
          //    Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => Onechat(
          //       // userModel: model),
          //   ),
          // );
        },
        child: Container(
          margin: const EdgeInsets.all(6.0),
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: Colors.white,
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Image.asset("assets/images/Profile Image.png"),
              backgroundColor: kPrimaryColor,
              radius: 28,
            ),
            title: Text(model.name),
            subtitle: Text(
              model.userId,
              // style: theme.textTheme.bodyText2
              // .copyWith(fontSize: 13, color: Colors.grey),
              maxLines: 2,
            ),
            trailing: TextButton(
                onPressed: () {},
                child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        topLeft: Radius.circular(10),
                      ),
                      border: Border.all(
                        width: 1,
                        color: kPrimaryColor,
                        style: BorderStyle.solid,
                      ),
                      // shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: TextButton(
                      onPressed: () {
                        HomeCubit.get(context)
                            .acceptfriendrequest(id: model.id);
                        HomeCubit.get(context).getfriendRequests();

                        setState(() {
                          Get.to(FriendRequestsScreen());
                        });
                        HomeCubit.get(context).addfirendFirebase(
                            receverId: model.userId, name: model.name);
                      },
                      child: Text(
                        "قبول الطلب",
                        style: TextStyle(fontSize: 12),
                      ),
                    )))),
          ),
        ),
      );
}

// class FriendRequestsScreen extends StatelessWidget {
//   const FriendRequestsScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => HomeCubit()..getfriendRequests(),
//       child: BlocConsumer<HomeCubit, HomeStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//               appBar: AppBar(
//                 title: Text('طلبات الصداقة'),
//                 centerTitle: true,
//               ),
//               body: ConditionalBuilder(
//                 condition: HomeCubit.get(context).friendRequestsModel != null,
//                 builder: (context) => builditem(
//                     HomeCubit.get(context).friendRequestsModel, context),
//                 fallback: (context) => Container(
//                   color: Colors.white,
//                   child: Center(
//                     child: Container(
//                         child: Text(
//                       'لا يوجد طلبات صداقة',
//                       style: TextStyle(color: Colors.grey),
//                     )),
//                   ),
//                 ),
//               ),
//             );
//           }),
//     );
//   }

//   Widget builditem(FriendRequestsModel model, context) => Scaffold(
//           // appBar: AppBar(),
//           body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Container(
//           child: ListView.separated(
//             itemBuilder: (context, index) => buildfriendRequestItem(
//                 HomeCubit.get(context).friendRequestsModel.message[index],
//                 context),
//             itemCount:
//                 HomeCubit.get(context).friendRequestsModel.message.length,
//             separatorBuilder: (BuildContext context, int index) => Divider(),
//           ),
//         ),
//       ));

//   Widget buildfriendRequestItem(Message model, context) => InkWell(
//         onTap: () {
//           // Get.to(Onechat(
//           //   userModel: model,
//           //   //  createUserModel: model,
//           //   //  userModel: model,
//           // ));
//           //    Navigator.push(
//           //   context,
//           //   MaterialPageRoute(
//           //     builder: (context) => Onechat(
//           //       // userModel: model),
//           //   ),
//           // );
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
//                     width: 70,
//                     decoration: BoxDecoration(
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
//                         HomeCubit.get(context)
//                             .acceptfriendrequest(id: model.id);

                            
//                       },
//                       child: Text(
//                         "قبول الطلب",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     )))),
//           ),
//         ),
//       );
// }
