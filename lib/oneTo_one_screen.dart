import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/route_manager.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/endpoint.dart';
import 'package:project/models/auth_model.dart';
import 'package:project/models/create_user_model.dart';
import 'package:project/models/oneMessage_model.dart';
import 'package:project/models/roomUser.dart';
import 'package:project/models/show_friends_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

class Onechat extends StatelessWidget {
  ShowFriendsModelData userModel;
  InRoomUserModelModelData user;
  bool fromRoomUser;
  bool fromchat;
  String userid;
  Onechat(
      {this.userModel,
      this.user,
      this.fromRoomUser,
      this.fromchat,
      this.userid});
  var massageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        if (fromRoomUser == true) {
          HomeCubit.get(context)
              .getmasseges(receverId: user.spacialId.toString());
          print('${user.userId.toString()}');
        } else {
          HomeCubit.get(context).getmasseges(receverId: userModel.userId);
        }

        if (fromchat == true) {
          HomeCubit.get(context).getmasseges(receverId: userid);
        }

        return BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      navigator.pop(context);
                    },
                  ),
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset("assets/images/Profile Image.png"),
                        backgroundColor: kPrimaryColor,
                        radius: 20,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      // fromchat == true ? Text(name) : Text(userModel.name),
                      fromRoomUser == true
                          ? Text(user.name)
                          : Text(userModel.name)
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: true,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var message =
                                    HomeCubit.get(context).masseges[index];
                                if (senderId == message.senderId)
                                  return buildmymassege(message);
                                return buildmassege(message);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15.0,
                                  ),
                              itemCount:
                                  HomeCubit.get(context).masseges.length),
                        ),
                        // buildmassege(),
                        // buildmymassege(),
                        // Spacer(),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2.0),
                          decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  keyboardType: TextInputType.text,
                                  controller: massageController,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration.collapsed(
                                    hintText: "رسالتك...",
                                    hintStyle: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.orange,
                                  ),
                                  child: Icon(
                                    Icons.send,
                                    color: Colors.white,
                                  ),
                                ),
                                onTap: () {
                                  // print(userModel.userId);

                                  if (fromRoomUser == true) {
                                    print('_________________________________');
                                    print(user.userId.toString());
                                    HomeCubit.get(context).sendmassege(
                                        receverId: user.spacialId.toString(),
                                        datatime: DateTime.now().toString(),
                                        text: massageController.text);
                                  } else {
                                    print('Xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                                    print(userModel.userId);
                                    HomeCubit.get(context).sendmassege(
                                        receverId: userModel.userId,
                                        datatime: DateTime.now().toString(),
                                        text: massageController.text);
                                  }

                                  //  if (fromchat == true) {
                                  //   print('_________________________________');
                                  //   print(user.userId.toString());
                                  //   HomeCubit.get(context).sendmassege(
                                  //       receverId: user.spacialId.toString(),
                                  //       datatime: DateTime.now().toString(),
                                  //       text: massageController.text);
                                  // } else {
                                  //   print('Xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
                                  //   print(userModel.userId);
                                  //   HomeCubit.get(context).sendmassege(
                                  //       receverId: userModel.userId,
                                  //       datatime: DateTime.now().toString(),
                                  //       text: massageController.text);
                                  // }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // fallback: (context) => Center(
                  //   child: CircularProgressIndicator(),
                  // ),
                ));
          },
        );
      },
    );
  }

  Widget buildmassege(OneMasseageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(model.text),
        ),
      );

  Widget buildmymassege(OneMasseageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: kPrimaryColor.withOpacity(.2),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10.0),
                topStart: Radius.circular(10.0),
                topEnd: Radius.circular(10.0),
              )),
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Text(model.text),
        ),
      );
}




//  Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         HomeCubit.get(context).getmasseges(receverId: userModel.uid);
//         return BlocConsumer<HomeCubit, HomeStates>(
//           listener: (context, state) {},
//           builder: (context, state) {
//             return Scaffold(
//                 appBar: AppBar(
//                   titleSpacing: 0.0,
//                   title: Row(
//                     children: [
//                       CircleAvatar(
//                         child: Image.asset("assets/images/Profile Image.png"),
//                         backgroundColor: kPrimaryColor,
//                         radius: 20,
//                       ),
//                       SizedBox(
//                         width: 15,
//                       ),
//                       Text(userModel.name)
//                     ],
//                   ),
//                 ),
//                 body: ConditionalBuilder(
//                   condition: HomeCubit.get(context).masseges.length > 0,
//                   builder: (context) => Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Column(
//                       children: [
//                         Expanded(
//                           child: ListView.separated(
//                               physics: BouncingScrollPhysics(),
//                               itemBuilder: (context, index) {
//                                 var message =
//                                     HomeCubit.get(context).masseges[index];
//                                 if (senderId == message.senderId)
//                                   return buildmymassege(message);
//                                 return buildmassege(message);
//                               },
//                               separatorBuilder: (context, index) => SizedBox(
//                                     height: 15.0,
//                                   ),
//                               itemCount:
//                                   HomeCubit.get(context).masseges.length),
//                         ),
//                         // buildmassege(),
//                         // buildmymassege(),
//                         Spacer(),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 6, vertical: 2.0),
//                           decoration: BoxDecoration(
//                             color: Colors.black26,
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(16.0)),
//                           ),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: TextField(
//                                   keyboardType: TextInputType.text,
//                                   controller: massageController,
//                                   style: TextStyle(color: Colors.white),
//                                   decoration: InputDecoration.collapsed(
//                                     hintText: "رسالتك...",
//                                     hintStyle: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                               ),
//                               InkWell(
//                                 child: Container(
//                                   padding: const EdgeInsets.all(5.0),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Colors.orange,
//                                   ),
//                                   child: Icon(
//                                     Icons.send,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 onTap: () {
//                                   print(userModel.uid);
//                                   HomeCubit.get(context).sendmassege(
//                                       receverId: userModel.uid,
//                                       datatime: DateTime.now().toString(),
//                                       text: massageController.text);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   fallback: (context) => Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                 ));
//           },
//         );
//       },
//     );
//   }