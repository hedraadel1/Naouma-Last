import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

import '../../../../common_functions.dart';
import '../../../../models/blockList_model.dart.dart';
import '../../../../models/users_following_room_model.dart';

class BlockListRoom extends StatefulWidget {
  BlockListRoom({Key key});
  @override
  State<BlockListRoom> createState() => _BlockListRoomState();
}

class _BlockListRoomState extends State<BlockListRoom> {
  TextEditingController roomNamecontroller = TextEditingController();
  TextEditingController roomDesccontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var model;
    return BlocProvider(
      create: ((context) => HomeCubit()..getBlockList()),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          // if (state is AddSupervsorSuccessStates) {
          //   CommonFunctions.showToast(
          //       HomeCubit.get(context).addSupervsorModel.message, Colors.green);
          // }

          // if (state is DeleteSupervsorSuccessStates) {
          //   CommonFunctions.showToast(
          //       HomeCubit.get(context).aaddSupervsorModel.message,
          //       Colors.green);
          // }
        },
        builder: (context, state) {
          var model = HomeCubit.get(context).userBlockListRoomModel;
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'قائمه المحظورين',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: HomeCubit.get(context).userBlockListRoomModel != null,
              builder: (context) {
                return ListView.separated(
                    itemBuilder: (context, index) => builditem(
                        HomeCubit.get(context)
                            .userBlockListRoomModel
                            .data[index],
                        context),
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: HomeCubit.get(context)
                        .userBlockListRoomModel
                        .data
                        .length);
              },
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: Text("لا يوجد"),
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
    BlockListModelData model,
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
              // IconButton(
              //     onPressed: () {
              //       HomeCubit.get(context).postSupervsorroom(id: model.id);
              //     },
              //     icon: Icon(Icons.person_add_alt_rounded)),
              IconButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: Center(
                            child: const Text(
                                'هل تريد ازالة العضو من قائمة الحظر'),
                          ),
                          // content: const Text('AlertDialog description'),
                          actions: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    HomeCubit.get(context)
                                        .removeBlacklist(id: model.id);

                                    Navigator.pop(context, 'yes');

                                    // Get.to(BlockListRoom());
                                    // CommonFunctions
                                    //     .showToast(
                                    //         'تم اصمات العضو',
                                    //         Colors
                                    //             .green);
                                  },
                                  child: const Text('نعم'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'no'),
                                  child: const Text('لا'),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.remove_circle_outline_rounded))
            ],
          ),
        ),
      );
}
