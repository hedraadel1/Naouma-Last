import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/common_functions.dart';

import 'package:project/models/room_data_model.dart';
import 'package:project/models/room_index.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/details/newPage.dart';

import '../../homeCubit.dart';
import '../../states.dart';

class NewRoomsView extends StatelessWidget {
  final _firestoreInstance = FirebaseFirestore.instance;

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     top: true,
  //     bottom: false,
  //     child: Scaffold(
  //       body: StreamBuilder<QuerySnapshot>(
  //         stream: _firestoreInstance
  //             .collection('rooms')
  //             .where("roomOwnerId",
  //                 isEqualTo: PreferencesServices.getString(ID_KEY))
  //             .snapshots(),
  //         builder:
  //             (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //           if (snapshot.hasData) {
  //             // listMessage.addAll(snapshot.data.docs);
  //             // return ListView.builder(
  //             //   padding: EdgeInsets.all(10.0),
  //             //   itemBuilder: (context, index) => MyRoomsItem(roomName: snapshot.data.docs[index]["roomName"], roomDesc: snapshot.data.docs[index]["roomDesc"],),
  //             //   itemCount: snapshot.data?.docs.length,
  //             //   scrollDirection: Axis.vertical,
  //             //   physics: BouncingScrollPhysics(),
  //             // );
  //             return Builder(
  //               builder: (BuildContext context) {
  //                 return CustomScrollView(
  //                   key: PageStorageKey<String>("myRooms"),
  //                   physics: BouncingScrollPhysics(),
  //                   slivers: <Widget>[
  //                     SliverOverlapInjector(
  //                       handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
  //                           context),
  //                     ),
  //                     SliverPadding(
  //                       padding: const EdgeInsets.symmetric(
  //                           vertical: 8.0, horizontal: 5.0),
  //                       sliver: SliverList(
  //                         delegate: SliverChildBuilderDelegate(
  //                           (BuildContext context, int index) {
  //                             return MyRoomsItem(
  //                               roomId: snapshot.data.docs[index].id,
  //                               roomName: snapshot.data.docs[index]["roomName"],
  //                               roomDesc: snapshot.data.docs[index]["roomDesc"],
  //                               roomOwnerId:
  //                                   PreferencesServices.getString(ID_KEY),
  //                             );
  //                           },
  //                           childCount: snapshot.data?.docs.length,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 );
  //               },
  //             );
  //           } else {
  //             return Center(
  //               child: CircularProgressIndicator(
  //                 valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
  //               ),
  //             );
  //           }
  //         },
  //       ),
  //     ),
  //   );
  // }

  final RoomDataModel roomData;

  NewRoomsView({Key key, this.roomData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return BlocProvider(
      create: (context) => HomeCubit()..getCategory(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ConditionalBuilder(
              condition: HomeCubit.get(context).roomIndexModel != null,
              builder: (context) => ListView.builder(
                  itemBuilder: (context, index) => buildCatItem(
                      HomeCubit.get(context).roomIndexModel.data[index],
                      context,
                      _controller),
                  itemCount: HomeCubit.get(context).roomIndexModel.data.length),
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              // child: FutureBuilder(
              //   future: HomeCubit.get(context).getCategory(),
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (HomeCubit.get(context).categoriesModel.data == null) {
              //       return CircularProgressIndicator();
              //     } else {
              //       return ListView.builder(
              //           itemBuilder: (context, index) => buildCatItem(
              //               HomeCubit.get(context).categoriesModel.data[index]),
              //           itemCount:
              //               HomeCubit.get(context).categoriesModel.data.length);
              //     }
              //   },
              // ),
            );
            // ConditionalBuilder(
            //   condition: HomeCubit.get(context).getWalletModel != null,
            //   builder: (context) =>
            //       mybackgroundItem(HomeCubit.get(context).getWalletModel.data),
            //   fallback: (context) => Container(
            //     color: Colors.white,
            //     child: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   ),
            // );

            // return ListView.separated(
            //     itemBuilder: (context, index) => buildCatItem(
            //         HomeCubit.get(context).categoriesModel.data[index]),
            //     separatorBuilder: (context, index) => Divider(),
            //     itemCount: HomeCubit.get(context).categoriesModel.data.length);
          }),
    );
  }

  buildCatItem(RoomIndexModelData model, context,
          TextEditingController _controller) =>
      Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: true,
          bottom: false,
          child: GestureDetector(
            onTap: () async {
              if (model.password == null) {
                Get.to(
                  DetailsScreen(
                    roomId: model.id.toString(),
                    roomDesc: model.roomDesc,
                    roomName: model.roomName,
                    roomOwnerId: model.roomOwner.toString(),
                    userID: apiid,
                    roomImage: model.backgroundUrl,
                    //role: ClientRole.Audience,

                    // roomName: model.roomName,
                  ),
                  // duration: Duration(milliseconds: 1000),
                );
              }
              if (model.password != null && model.userType == 'owner') {
                Get.to(
                  DetailsScreen(
                    roomId: model.id.toString(),
                    roomDesc: model.roomDesc,
                    roomName: model.roomName,
                    roomOwnerId: model.roomOwner.toString(),
                    userID: apiid,
                    roomImage: model.backgroundUrl,
                    //role: ClientRole.Audience,

                    // roomName: model.roomName,
                  ),
                  // duration: Duration(milliseconds: 1000),
                );
              }
              if (model.password != null && model.userType != 'owner') {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => Directionality(
                    textDirection: TextDirection.rtl,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      title: Center(
                        child: const Text('برجاء ادخال كلمة السر للغرفة'),
                      ),
                      // content: const Text('AlertDialog description'),
                      actions: <Widget>[
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 250,
                                  child: Directionality(
                                    textDirection: TextDirection.rtl,
                                    child:
                                        CommonFunctions().nbAppTextFieldWidget(
                                      _controller,
                                      'Password',
                                      "ادخل كلمة المرور",
                                      'برجاء ادخال كلمه المرور',
                                      TextFieldType.PASSWORD,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: kPrimaryLightColor,

                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      topLeft: Radius.circular(10),
                                    ),
                                    // border: Border.all(
                                    //   width: 1,
                                    //   color: kPrimaryColor,
                                    //   style: BorderStyle.solid,
                                    // ),
                                    // shape: BoxShape.circle,
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      if (_controller.text == model.password) {
                                        Get.to(
                                          DetailsScreen(
                                            roomId: model.id.toString(),
                                            roomDesc: model.roomDesc,
                                            roomName: model.roomName,
                                            roomOwnerId:
                                                model.roomOwner.toString(),
                                            userID: apiid,
                                            roomImage: model.backgroundUrl,
                                            passwordRoom: _controller.text,
                                            //role: ClientRole.Audience,

                                            // roomName: model.roomName,
                                          ),

                                          // duration: Duration(milliseconds: 1000),
                                        );
                                        // Navigator.pop(context, 'yes');
                                      } else {
                                        CommonFunctions.showToast(
                                            'كلمة المرور المدخلة غير صحيحة',
                                            Colors.red);
                                      }
                                      // // ShopCubit.get(context)
                                      // //     .lockPurchase(id: model.id);
                                    },
                                    child: const Text(
                                      'دخول',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                // TextButton(
                                //   onPressed: () => Navigator.pop(context, 'no'),
                                //   child: const Text('لا'),
                                // ),
                              ],
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: [
                            //     TextButton(
                            //       onPressed: () {
                            //         // ShopCubit.get(context)
                            //         //     .lockPurchase(id: model.id);
                            //         Navigator.pop(context, 'yes');

                            //         // CommonFunctions
                            //         //     .showToast(
                            //         //         'تم حظر العضو',
                            //         //         Colors
                            //         //             .green);
                            //       },
                            //       child: const Text('نعم'),
                            //     ),
                            //     TextButton(
                            //       onPressed: () => Navigator.pop(context, 'no'),
                            //       child: const Text('لا'),
                            //     ),
                            //   ],
                            // )
                          ],
                        )
                      ],
                    ),
                  ),
                );
                // Get.to(
                //   DetailsScreen(
                //     roomId: model.id.toString(),
                //     roomDesc: model.roomDesc,
                //     roomName: model.roomName,
                //     roomOwnerId: model.roomOwner.toString(),
                //     userID: apiid,
                //     roomImage: model.backgroundUrl,
                //     //role: ClientRole.Audience,

                //     // roomName: model.roomName,
                //   ),
                //   // duration: Duration(milliseconds: 1000),
                // );
              }
              // await Permission.microphone.request();
            },
            child: Container(
                margin: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8.0)),
                        child: Image.network(
                          model.backgroundUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    // _sizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // _sizedBox(height: 10),
                            Row(children: [
                              Icon(Icons.flag),
                              _sizedBox(width: 4.0),
                              Expanded(
                                  child: Text(
                                model.roomName,
                                maxLines: 1,
                                // style: theme.textTheme.bodyText1
                                // .copyWith(color: Colors.black, fontSize: 15),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.start,
                              )),
                            ]),
                            _sizedBox(height: 6),
                            // Row(
                            //   children: [
                            //     Icon(
                            //       Icons.queue_music,
                            //       size: 20,
                            //     ),
                            //     _sizedBox(width: 6.0),
                            //     Container(
                            //       // height: 30,
                            //       padding:
                            //           const EdgeInsets.symmetric(horizontal: 4),
                            //       decoration: BoxDecoration(
                            //         color: kPrimaryColor,
                            //         borderRadius:
                            //             BorderRadius.all(Radius.circular(10.0)),
                            //       ),
                            //       child: Text(
                            //         "موسيقى",
                            //         // style: theme.textTheme.bodyText2
                            //         //     .copyWith(fontSize: 13),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            _sizedBox(height: 8),
                            Text(
                              model.roomDesc,
                              maxLines: 1,
                              // style: theme.textTheme.bodyText2.copyWith(
                              //     color: Colors.grey.shade600, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                            // _sizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            // Icon(
                            //   Icons.queue_music,
                            //   size: 20,
                            // ),
                            Icon(
                              Icons.perm_identity_sharp,
                              size: 20,
                            ),
                            Text(
                              model.id.toString(),
                              maxLines: 1,
                              // style: theme.textTheme.bodyText2.copyWith(
                              //     color: Colors.grey.shade600, fontSize: 13),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        // _sizedBox(height: 8),
                        // Row(
                        //   children: [
                        //     Icon(Icons.queue_music),
                        //     Icon(Icons.perm_identity_sharp),
                        //   ],
                        // ),
                      ],
                    ),
                    _sizedBox(width: 10),
                  ],
                )),
          ),
        ),
      );

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
