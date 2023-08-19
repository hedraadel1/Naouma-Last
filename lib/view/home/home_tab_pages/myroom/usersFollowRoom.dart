import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/users_following_room_model.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

class UsersFollowRoom extends StatefulWidget {
  String roomID;
  UsersFollowRoom({
    Key key,
    this.roomID,
  });

  @override
  State<UsersFollowRoom> createState() => _UsersFollowRoomState();
}

class _UsersFollowRoomState extends State<UsersFollowRoom> {
  get kPrimaryColor => null;

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocProvider(
      create: ((context) => HomeCubit()..usersfollowingroom(id: widget.roomID)),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddSupervsorSuccessStates) {
            CommonFunctions.showToast(
                HomeCubit.get(context).addSupervsorModel.message, Colors.green);
          }

          if (state is DeleteSupervsorSuccessStates) {
            CommonFunctions.showToast(
                HomeCubit.get(context).aaddSupervsorModel.message,
                Colors.green);
          }
        },
        builder: (context, state) {
          var model = HomeCubit.get(context).userFollowingRoomModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'الاعضاء',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).userFollowingRoomModel != null,
              builder: (context) {
                return ListView.separated(
                    itemBuilder: (context, index) => builditem(
                        HomeCubit.get(context)
                            .userFollowingRoomModel
                            .data
                            .first
                            .followers[index],
                        context),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: HomeCubit.get(context)
                        .userFollowingRoomModel
                        .data
                        .first
                        .followers
                        .length);
              },
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // builder: (BuildContext context, AsyncSnapshot snapshot) {
              //   if (HomeCubit.get(context).categoriesModel.data == null) {
              //     return CircularProgressIndicator();
              //   } else {
              //     return ListView.builder(
              //         itemBuilder: (context, index) => buildCatItem(
              //             HomeCubit.get(context).categoriesModel.data[index]),
              //         itemCount:
              //             HomeCubit.get(context).categoriesModel.data.length);
              //   }
              // },
            ),
          );
        },
      ),
    );
  }

  Widget builditem(
    Followers model,
    BuildContext context,
  ) =>
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(
                  "assets/images/Profile Image.png",
                ),
              ),
              SizedBox(
                width: 20.0,
              ),
              Text(
                model.name,
              ),
              Spacer(),
              IconButton(
                  onPressed: () {
                    HomeCubit.get(context).postSupervsorroom(id: model.id);
                  },
                  icon: Icon(Icons.person_add_alt_rounded)),
              IconButton(
                  onPressed: () {
                    HomeCubit.get(context).deleteSupervsorroom(id: model.id);
                  },
                  icon: Icon(Icons.remove_circle_outline_rounded))
            ],
          ),
          // onTap: () {
          //   showModalBottomSheet(
          //       context: context,
          //       isScrollControlled: true,
          //       builder: (context) {
          //         return FractionallySizedBox(
          //           heightFactor: 0.35,
          //           child: Container(
          //             decoration: new BoxDecoration(
          //                 color: Colors.white,
          //                 borderRadius: new BorderRadius.only(
          //                     topLeft: const Radius.circular(10.0),
          //                     topRight: const Radius.circular(10.0))),
          //             child: Column(
          //               children: [
          //                 Container(
          //                   child: FloatingActionButton(
          //                       child: CircleAvatar(
          //                         radius: 50,
          //                         backgroundImage: AssetImage(
          //                           "assets/images/Profile Image.png",
          //                         ),
          //                       ),
          //                       onPressed: () {}),
          //                 ),
          //                 SizedBox(
          //                   height: 15,
          //                 ),
          //                 Text(model.name.toString()),
          //                 Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     Padding(
          //                       padding: const EdgeInsets.all(8.0),
          //                       child: Container(
          //                           width: 50,
          //                           decoration: BoxDecoration(
          //                             color: kPrimaryColor,
          //                             borderRadius: BorderRadius.only(
          //                               topRight: Radius.circular(10),
          //                               bottomRight: Radius.circular(10),
          //                               bottomLeft: Radius.circular(10),
          //                               topLeft: Radius.circular(10),
          //                             ),
          //                             border: Border.all(
          //                               width: 1,
          //                               color: kPrimaryColor,
          //                               style: BorderStyle.solid,
          //                             ),
          //                             // shape: BoxShape.circle,
          //                           ),
          //                           child: Center(
          //                               child: Text(
          //                             "عضو",
          //                             style: TextStyle(
          //                                 color: Colors.white, fontSize: 12),
          //                           ))),
          //                     ),
          //                     SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'ID:${model.spacialId}',
          //                       style: TextStyle(color: Colors.grey),
          //                     ),
          //                     SizedBox(
          //                       width: 10,
          //                     ),
          //                     Text(
          //                       'LV.39',
          //                       style: TextStyle(
          //                           color: kPrimaryColor,
          //                           fontWeight: FontWeight.bold),
          //                     ),
          //                   ],
          //                 ),
          //                 Spacer(),
          //                 Padding(
          //                   padding: const EdgeInsets.all(20.0),
          //                   child: Row(
          //                     mainAxisAlignment: MainAxisAlignment.center,
          //                     children: [
          //                       Column(
          //                         children: [
          //                           MaterialButton(
          //                             onPressed: () {
          //                               if (type != null) {
          //                                 HomeCubit.get(context).sendgift(
          //                                     id: roomID,
          //                                     type: type,
          //                                     giftid: giftId,
          //                                     received: model.userId,
          //                                     count: controller);
          //                                 CommonFunctions.showToast(
          //                                     "${model.name}تم إرسال هديه الي",
          //                                     Colors.green);
          //                               } else {
          //                                 CommonFunctions.showToast(
          //                                     "برجاء اختيار الهدية",
          //                                     Colors.red);
          //                               }
          //                             },
          //                             color: Colors.blueAccent,
          //                             textColor: Colors.white,
          //                             child: Icon(
          //                               Icons.card_giftcard,
          //                               size: 14,
          //                             ),
          //                             padding: EdgeInsets.all(16),
          //                             shape: CircleBorder(),
          //                           ),
          //                           Text(
          //                             'إرسال هديه',
          //                             style: TextStyle(color: Colors.grey),
          //                           )
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         width: 40,
          //                       ),
          //                       Column(
          //                         children: [
          //                           MaterialButton(
          //                             onPressed: () {},
          //                             color: Colors.pink,
          //                             textColor: Colors.white,
          //                             child: Icon(
          //                               Icons.star,
          //                               size: 14,
          //                             ),
          //                             padding: EdgeInsets.all(16),
          //                             shape: CircleBorder(),
          //                           ),
          //                           Text(
          //                             'البطاقات السحرية',
          //                             style: TextStyle(color: Colors.grey),
          //                           )
          //                         ],
          //                       ),
          //                       SizedBox(
          //                         width: 40,
          //                       ),
          //                       Column(
          //                         children: [
          //                           MaterialButton(
          //                             onPressed: () {
          //                               HomeCubit.get(context).addfriend(
          //                                 id: model.userId,
          //                               );

          //                               // print(HomeCubit.get(context)
          //                               //     .addfriendsModel
          //                               //     .message);
          //                             },
          //                             color: Colors.yellow,
          //                             textColor: Colors.white,
          //                             child: Icon(
          //                               Icons.person_add,
          //                               size: 14,
          //                             ),
          //                             padding: EdgeInsets.all(16),
          //                             shape: CircleBorder(),
          //                           ),
          //                           Text(
          //                             'إضافه صديق',
          //                             style: TextStyle(color: Colors.grey),
          //                           )
          //                         ],
          //                       ),
          //                     ],
          //                   ),
          //                 )
          //               ],
          //             ),
          //           ),
          //         );
          //       });
          // },
        ),
      );
}
