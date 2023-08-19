import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:get/get.dart';
import 'package:project/models/get_user_exp_model.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:project/models/profileGifts_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/models/getProfile_model.dart';
import 'package:project/utils/images.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';
import 'package:project/view/profile/profile_cubit.dart';
import 'package:project/view/profile/profile_states.dart';

import '../../edit_profile_screen.dart';
import '../../models/follow_room_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => ProfileCubit()
        ..getprofile()
        ..getuserExp(id: apiid),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ProfileCubit.get(context).profileModel != null &&
                ProfileCubit.get(context).getUserExpModel != null,
            builder: (context) => getprofilee(
              ProfileCubit.get(context).profileModel,
              ProfileCubit.get(context).getUserExpModel,
            ),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getprofilee(
    GetProfileModel model,
    GetUserExpModel model1,
  ) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Get.to(EditProfileScreen());
                },
              ),
            ],
          )
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _profileImage(),
              16.height,
              _infoContainer(model.data.first, model1.data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileImage() {
    return Stack(
      children: [
        Container(
          color: kPrimaryColor,
          margin: const EdgeInsets.only(bottom: 35),
          width: double.infinity,
          height: 0.20,

          // child: Image.asset("name"),
        ),
        Container(
          height: 170,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CircleAvatar(
              backgroundImage: AssetImage(kDefaultProfileImage),
              backgroundColor: kPrimaryColor,
              radius: 35,
            ),
          ),
        ),
      ],
    );
  }

  Widget _infoContainer(ProfileData model, GetUserExpModelData model1) {
    return Container(
      child: Column(
        children: [
          Text(model.name),
          6.height,
          Text(
            model.userId,
          ),
          8.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Text(
                  "LV.${model1.userCurrentLevel}",
                  // style:
                  //     theme.textTheme.bodyText1.copyWith(color: Colors.white),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "نقاط الخبرة : ${model1.userCurrentExp}",
                        // style: theme.textTheme.bodyText1
                        //     .copyWith(color: Colors.white),
                      ),
                      Icon(
                        Icons.bookmark_border_outlined,
                        color: Colors.white,
                        size: 16,
                      )
                    ],
                  )),
              SizedBox(
                width: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(children: [
                  Text(
                    "مصر",
                    // style:
                    //     theme.textTheme.bodyText1.copyWith(color: Colors.white),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 16,
                  )
                ]),
              ),
            ],
          ),
          6.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "الملف الشخصي فارغ",
              ),
            ],
          ),
          8.height,
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Column(
          //         children: [
          //           Text("1"),
          //           4.height,
          //           Text("زار"),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Text("0"),
          //           4.height,
          //           Text("متابعة"),
          //         ],
          //       ),
          //       Column(
          //         children: [
          //           Text("0"),
          //           4.height,
          //           Text("متابعين"),
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 50,
          ),
          Column(
            children: [
              // Divider(),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text("الشارة"),
              //         ),
              //       ),
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Icon(
              //         Icons.arrow_forward_ios,
              //         color: Colors.grey,
              //         size: 16,
              //       ),
              //     )
              //   ],
              // ),
              Divider(),
              InkWell(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("الغرف"),
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Get.to(Myroom());
                },
              ),
              // Divider(),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Text("اللحظات"),
              //         ),
              //       ),
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Icon(
              //         Icons.arrow_forward_ios,
              //         color: Colors.grey,
              //         size: 16,
              //       ),
              //     )
              //   ],
              // ),
              Divider(),
              InkWell(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("الهدايا"),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  Get.to(GiftProfile(
                    profileModel: model,
                  ));
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _personalInfo(double width, ProfileData model1) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: Text(
              "المعلومات الشخصية",
            ),
          ),
          16.height,
          Row(
            children: [
              SizedBox(
                width: width / 3,
                child: Text(""),
              ),
              SizedBox(
                width: width / 3 - 28,
                child: Text(""),
              )
            ],
          ),
          Divider(),
          10.height,
          Row(
            children: [
              SizedBox(
                width: width / 3,
                child: Text(""),
              ),
              SizedBox(
                width: width / 3 - 28,
                child: Text(""),
              )
            ],
          ),
          Divider(),
          10.height,
          Row(
            children: [
              SizedBox(
                width: width / 3,
                child: Text(""),
              ),
              SizedBox(
                width: width / 3 - 28,
                child: Text(""),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GiftProfile extends StatelessWidget {
  ProfileData profileModel;
  GiftProfile({
    this.profileModel,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..giftuserProfile(id: profileModel.id),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ProfileCubit.get(context).profileGiftsModel != null,
            builder: (context) =>
                getIntresItem(ProfileCubit.get(context).profileGiftsModel),
            fallback: (context) => Container(
              color: Colors.white,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getIntresItem(ProfileGiftsModel model) => Scaffold(
        appBar: AppBar(
          title: Text('الهدايا'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: GridView.count(
                  crossAxisCount: 4,
                  mainAxisSpacing: 1.0,
                  crossAxisSpacing: 1.0,
                  childAspectRatio: 1 / 1,
                  children: List.generate(model.data.length,
                      (index) => buildGridleProduct(model.data[index])))),
        ),
      );

  Widget buildGridleProduct(ProfileGiftsModelData model) => Column(
        children: [
          InkWell(
            child: ClipRRect(
              borderRadius:
                  BorderRadius.horizontal(right: Radius.circular(8.0)),
              child: Image.network(
                model.url,
                height: 60,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            onTap: () {
              // showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return Theme(
              //         data: ThemeData(
              //             dialogBackgroundColor: Colors.grey.withOpacity(0.0)),
              //         child: AlertDialog(
              //           content: SingleChildScrollView(
              //               child: Image.network(
              //             model.url,
              //           )),
              //         ),
              //       );
              //     });
              // setState(() {
              //   // image = model.url;
              //   // CacheHelper.saveData(key: 'image', value: model.url);
              // });
            },
          ),
          // Container(child: Center(child: Text(model.price.toString()))),
          // Container(
          //   width: 180,
          //   color: KstorebuttonColor,
          //   child: Center(
          //     child: Text(
          //       "شراء",
          //       style: TextStyle(color: Colors.white),
          //     ),
          //   ),
          // )
        ],
      );
}

class Myroom extends StatelessWidget {
  const Myroom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..followingroom(),
      child: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text('الغرف'),
                centerTitle: true,
              ),
              body: ConditionalBuilder(
                condition: HomeCubit.get(context).followModel != null,
                builder: (context) => ListView.builder(
                    itemBuilder: (context, index) => buildroomItem(
                        HomeCubit.get(context).followModel.data[index]),
                    itemCount: HomeCubit.get(context).followModel.data.length),
                fallback: (context) => Container(
                  color: Colors.white,
                  child: Center(
                      child: Container(
                    child: Text(
                      "لم يتم الانضمام الي غرفة",
                      style: TextStyle(color: Colors.grey),
                    ),
                  )),
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
              ),
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

  buildroomItem(FollowModelData model) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: true,
          bottom: false,
          child: GestureDetector(
            // onTap: () async {
            //   // await Permission.microphone.request();

            //   Get.to(
            //     DetailsScreen(
            //       roomId: model.id.toString(),
            //       roomDesc: model.roomDesc,
            //       roomName: model.roomName,
            //       // role: ClientRole.Audience,

            //       // roomName: model.roomName,
            //     ),
            //     // duration: Duration(milliseconds: 1000),
            //   );
            // },
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
                        child: Image.asset(
                          "assets/images/item_image.png",
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
                            Row(
                              children: [
                                Icon(
                                  Icons.queue_music,
                                  size: 20,
                                ),
                                _sizedBox(width: 6.0),
                                Container(
                                  // height: 30,
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                    color: kPrimaryColor,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Text(
                                    "موسيقى",
                                    // style: theme.textTheme.bodyText2
                                    //     .copyWith(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
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
                            Icon(
                              Icons.queue_music,
                              size: 20,
                            ),
                            Icon(
                              Icons.perm_identity_sharp,
                              size: 20,
                            ),
                            Text(
                              model.roomId.toString(),
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




// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:naouma/utils/constants.dart';
// import 'package:naouma/utils/images.dart';
// import 'package:nb_utils/nb_utils.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     return BlocConsumer<HomeCubit, HomeStates>(builder: (context, state){
//       return  ListView.builder(ITE,itemBuilder: (BuildContext context, int index)=>)
//     }, listener: (context, state) {});
//      Scaffold(
//       appBar: AppBar(
//         title: Text("الملف الشخصي"),
//       ),
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               _profileImage(size.height),
//               16.height,
//               _infoContainer(theme),
//               16.height,
//               _infoContainer(theme),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _profileImage(
//     double height,
//   ) {
//     return Stack(
//       children: [
//         // Container(
//         //   margin: const EdgeInsets.only(bottom: 35),
//         //   width: double.infinity,
//         //   height: height * 0.25,
//         //   child: Image.asset("name"),
//         // ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: CircleAvatar(
//             backgroundImage: AssetImage(kDefaultProfileImage),
//             backgroundColor: kPrimaryColor,
//             radius: 35,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _infoContainer(ThemeData theme) {
//     return Container(
//       child: Column(
//         children: [
//           Text(
//             "محمود عبدالمجيد",
//           ),
//           6.height,
//           Text(
//             "ID: 632145852",
//           ),
//           8.height,
//           Row(
//             children: [
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                 ),
//                 child: Text(
//                   "LV.25",
//                   style:
//                       theme.textTheme.bodyText1.copyWith(color: Colors.white),
//                 ),
//               ),
//               Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 2.0, horizontal: 4.0),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                   ),
//                   child: Row(
//                     children: [
//                       Text(
//                         "LV.25",
//                         style: theme.textTheme.bodyText1
//                             .copyWith(color: Colors.white),
//                       ),
//                       Icon(
//                         Icons.bookmark_border_outlined,
//                         color: Colors.white,
//                         size: 16,
//                       )
//                     ],
//                   )),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                 ),
//                 child: Row(children: [
//                   Text(
//                     "تركيا",
//                     style:
//                         theme.textTheme.bodyText1.copyWith(color: Colors.white),
//                   ),
//                   Icon(
//                     Icons.location_on_outlined,
//                     color: Colors.white,
//                     size: 16,
//                   )
//                 ]),
//               ),
//             ],
//           ),
//           6.height,
//           Row(
//             children: [
//               Text(
//                 "الوصف الوصف الوصف الوصف",
//               ),
//             ],
//           ),
//           8.height,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Column(
//                 children: [
//                   Text("88"),
//                   4.height,
//                   Text("زار"),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text("88"),
//                   4.height,
//                   Text("متابعة"),
//                 ],
//               ),
//               Column(
//                 children: [
//                   Text("22"),
//                   4.height,
//                   Text("متابعين"),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _personalInfo(double width) {
//     return Container(
//       child: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             padding:
//                 const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
//             decoration: BoxDecoration(
//               color: Colors.grey,
//             ),
//             child: Text(
//               "المعلومات الشخصية",
//             ),
//           ),
//           16.height,
//           Row(
//             children: [
//               SizedBox(
//                 width: width / 3,
//                 child: Text(""),
//               ),
//               SizedBox(
//                 width: width / 3 - 28,
//                 child: Text(""),
//               )
//             ],
//           ),
//           Divider(),
//           10.height,
//           Row(
//             children: [
//               SizedBox(
//                 width: width / 3,
//                 child: Text(""),
//               ),
//               SizedBox(
//                 width: width / 3 - 28,
//                 child: Text(""),
//               )
//             ],
//           ),
//           Divider(),
//           10.height,
//           Row(
//             children: [
//               SizedBox(
//                 width: width / 3,
//                 child: Text(""),
//               ),
//               SizedBox(
//                 width: width / 3 - 28,
//                 child: Text(""),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }











// ///////////////////////////////////////////////////////////////////////

// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:naouma/models/getProfile_model.dart';
// import 'package:naouma/utils/constants.dart';
// import 'package:naouma/utils/images.dart';
// import 'package:naouma/view/home/homeCubit.dart';
// import 'package:naouma/view/home/states.dart';
// import 'package:nb_utils/nb_utils.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final theme = Theme.of(context);
//     return BlocConsumer<HomeCubit, HomeStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return ConditionalBuilder(
//           condition: HomeCubit.get(context).profileModel != null,
//           builder: (context) =>
//               buildprofile(HomeCubit.get(context).profileModel),
//           fallback: (context) => CircularProgressIndicator(),
//         );

//         // return Scaffold(
//         //   appBar: AppBar(
//         //     title: Text("الملف الشخصي"),
//         //   ),
//         //   body: Container(
//         //     child: SingleChildScrollView(
//         //       child: Column(
//         //         children: [
//         //           Stack(
//         //             alignment: const FractionalOffset(0.98, 1.12),
//         //             children: <Widget>[
//         //               new Container(
//         //                   height: 150,
//         //                   color: kPrimaryColor,
//         //                   child: new Column(
//         //                     children: <Widget>[
//         //                       new Container(
//         //                           margin: const EdgeInsets.fromLTRB(
//         //                               0.0, 20.0, 0.0, 0.0),
//         //                           child: new Column(children: <Widget>[
//         //                             new Row(
//         //                               mainAxisAlignment:
//         //                                   MainAxisAlignment.spaceBetween,
//         //                               children: <Widget>[
//         //                                 new Row(
//         //                                   children: <Widget>[
//         //                                     new IconButton(
//         //                                         icon: new Icon(
//         //                                           Icons.arrow_back,
//         //                                           color: Colors.white,
//         //                                         ),
//         //                                         onPressed: () {
//         //                                           Navigator.pop(
//         //                                               context, false);
//         //                                         }),
//         //                                   ],
//         //                                 ),
//         //                               ],
//         //                             ),
//         //                           ])),
//         //                     ],
//         //                   )),
//         //               Column(
//         //                 mainAxisAlignment: MainAxisAlignment.end,
//         //                 children: [
//         //                   Container(child: Text("")),
//         //                   SizedBox(
//         //                     height: 25,
//         //                   ),
//         //                   Row(
//         //                     mainAxisAlignment: MainAxisAlignment.center,
//         //                     children: [
//         //                       Container(
//         //                           margin: const EdgeInsets.only(top: 15),
//         //                           child: _profileImage(size.height)),
//         //                     ],
//         //                   )
//         //                 ],
//         //               )
//         //             ],
//         //           ),
//         //           // _profileImage(size.height),
//         //           10.height,
//         //           Padding(
//         //             padding: const EdgeInsets.all(8.0),
//         //             child: _infoContainer(theme),
//         //           ),
//         //           16.height,
//         //           // _infoContainer(theme),
//         //         ],
//         //       ),
//         //     ),
//         //   ),
//         // );
//       },
//     );
//   }

//   Widget buildprofile(GetProfileModel model) {
//     return Scaffold(
//       body: Container(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Stack(
//                 alignment: const FractionalOffset(0.98, 1.12),
//                 children: <Widget>[
//                   new Container(
//                       height: 150,
//                       color: kPrimaryColor,
//                       child: new Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: <Widget>[
//                           new Container(
//                               margin: const EdgeInsets.fromLTRB(
//                                   0.0, 20.0, 0.0, 0.0),
//                               child: new Column(children: <Widget>[
//                                 new Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: <Widget>[
//                                     new Row(
//                                       children: <Widget>[
//                                         new IconButton(
//                                             icon: new Icon(
//                                               Icons.arrow_back,
//                                               color: Colors.white,
//                                             ),
//                                             onPressed: () {
//                                               // Navigator.pop(
//                                               //     context, false);
//                                             }),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ])),
//                         ],
//                       )),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           // Container(
//                           //     margin: const EdgeInsets.only(top: 15),
//                           //     child: _profileImage()),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//               _profileImage(),
//               10.height,
//               Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     height: double.infinity,
//                     width: double.infinity,
//                     child: ListView.builder(
//                       itemBuilder: (BuildContext context, int index) {
//                         return _infoContainer(model.data[index],
//                             HomeCubit.get(context).profileModel);
//                       },
//                       itemCount: 1,
//                     ),
//                   )),
//               16.height,
//               // _infoContainer(theme),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Widget buildprofile(GetProfileModel model) => Scaffold(
//   //       appBar: AppBar(
//   //         title: Text("الملف الشخصي"),
//   //       ),
//   //       body: Container(
//   //         child: SingleChildScrollView(
//   //           child: Column(
//   //             children: [
//   //               Stack(
//   //                 alignment: const FractionalOffset(0.98, 1.12),
//   //                 children: <Widget>[
//   //                   new Container(
//   //                       height: 150,
//   //                       color: kPrimaryColor,
//   //                       child: new Column(
//   //                         children: <Widget>[
//   //                           new Container(
//   //                               margin: const EdgeInsets.fromLTRB(
//   //                                   0.0, 20.0, 0.0, 0.0),
//   //                               child: new Column(children: <Widget>[
//   //                                 new Row(
//   //                                   mainAxisAlignment:
//   //                                       MainAxisAlignment.spaceBetween,
//   //                                   children: <Widget>[
//   //                                     new Row(
//   //                                       children: <Widget>[
//   //                                         new IconButton(
//   //                                             icon: new Icon(
//   //                                               Icons.arrow_back,
//   //                                               color: Colors.white,
//   //                                             ),
//   //                                             onPressed: () {
//   //                                               Navigator.pop(context, false);
//   //                                             }),
//   //                                       ],
//   //                                     ),
//   //                                   ],
//   //                                 ),
//   //                               ])),
//   //                         ],
//   //                       )),
//   //                   Column(
//   //                     mainAxisAlignment: MainAxisAlignment.end,
//   //                     children: [
//   //                       Container(child: Text("")),
//   //                       SizedBox(
//   //                         height: 25,
//   //                       ),
//   //                       Row(
//   //                         mainAxisAlignment: MainAxisAlignment.center,
//   //                         children: [
//   //                           Container(
//   //                               margin: const EdgeInsets.only(top: 15),
//   //                               child: _profileImage(size.height)),
//   //                         ],
//   //                       )
//   //                     ],
//   //                   )
//   //                 ],
//   //               ),
//   //               // _profileImage(size.height),
//   //               10.height,
//   //               Padding(
//   //                 padding: const EdgeInsets.all(8.0),
//   //                 child: _infoContainer(),
//   //               ),
//   //               16.height,
//   //               // _infoContainer(theme),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );

//   Widget _profileImage() {
//     return Stack(
//       children: [
//         // Container(
//         //   margin: const EdgeInsets.only(bottom: 35),
//         //   width: double.infinity,
//         //   // height: height * 0.5,
//         //   // child: Image.asset("name"),
//         // ),
//         // Align(
//         //   alignment: Alignment.bottomCenter,
//         //   child: CircleAvatar(
//         //     backgroundImage: AssetImage(kDefaultProfileImage),
//         //     backgroundColor: kPrimaryColor,
//         //     radius: 35,
//         //   ),
//         // ),
//       ],
//     );
//   }

//   Widget _infoContainer(ProfileData model, GetProfileModel model1) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(model.name),
//           6.height,
//           Text(
//             model.userId,
//           ),
//           8.height,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                 ),
//                 child: Text(
//                   "LV.25",
//                   // style:
//                   //     theme.textTheme.bodyText1.copyWith(color: Colors.white),
//                 ),
//               ),
//               Container(
//                   padding: const EdgeInsets.symmetric(
//                       vertical: 2.0, horizontal: 4.0),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                   ),
//                   child: Row(
//                     children: [
//                       // Text(
//                       //   "LV.25",
//                       //   style: theme.textTheme.bodyText1
//                       //       .copyWith(color: Colors.white),
//                       // ),
//                       Icon(
//                         Icons.bookmark_border_outlined,
//                         color: Colors.white,
//                         size: 16,
//                       )
//                     ],
//                   )),
//               Container(
//                 padding:
//                     const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   borderRadius: BorderRadius.all(Radius.circular(16.0)),
//                 ),
//                 child: Row(children: [
//                   Text(
//                     "مصر",
//                     // style:
//                     // theme.textTheme.bodyText1.copyWith(color: Colors.white),
//                   ),
//                   Icon(
//                     Icons.location_on_outlined,
//                     color: Colors.white,
//                     size: 16,
//                   )
//                 ]),
//               ),
//             ],
//           ),
//           10.height,
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 "الملف الشخصي فارع",
//               ),
//             ],
//           ),
//           8.height,
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   children: [
//                     Text("1"),
//                     4.height,
//                     Text("زار"),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(model1.follow.toString()),
//                     4.height,
//                     Text("متابعة"),
//                   ],
//                 ),
//                 Column(
//                   children: [
//                     Text(model1.followMe.toString()),
//                     4.height,
//                     Text("متابعين"),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Widget _personalInfo(double width) {
//   //   return Container(
//   //     child: Column(
//   //       children: [
//   //         Container(
//   //           width: double.infinity,
//   //           padding:
//   //               const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
//   //           decoration: BoxDecoration(
//   //             color: Colors.grey,
//   //           ),
//   //           child: Text(
//   //             "المعلومات الشخصية",
//   //           ),
//   //         ),
//   //         16.height,
//   //         Row(
//   //           children: [
//   //             SizedBox(
//   //               width: width / 3,
//   //               child: Text(""),
//   //             ),
//   //             SizedBox(
//   //               width: width / 3 - 28,
//   //               child: Text(""),
//   //             )
//   //           ],
//   //         ),
//   //         Divider(),
//   //         10.height,
//   //         Row(
//   //           children: [
//   //             SizedBox(
//   //               width: width / 3,
//   //               child: Text(""),
//   //             ),
//   //             SizedBox(
//   //               width: width / 3 - 28,
//   //               child: Text(""),
//   //             )
//   //           ],
//   //         ),
//   //         Divider(),
//   //         10.height,
//   //         Row(
//   //           children: [
//   //             SizedBox(
//   //               width: width / 3,
//   //               child: Text(""),
//   //             ),
//   //             SizedBox(
//   //               width: width / 3 - 28,
//   //               child: Text(""),
//   //             ),
//   //           ],
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// }
