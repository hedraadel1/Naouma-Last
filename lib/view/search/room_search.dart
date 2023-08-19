import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/search_model.dart';
import 'package:project/models/userSearch_model.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/details/details_screen.dart';
import 'package:project/view/details/newPage.dart';
import 'package:project/view/search/cubit.dart';
import 'package:project/view/search/states.dart';

class SearchRoom extends StatelessWidget {
  @override
  TextEditingController roomsearchtext = TextEditingController();
  TextEditingController usersearchtext = TextEditingController();

  var fromkey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchScreenCubit(),
      child: BlocConsumer<SearchScreenCubit, SearchAppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: DefaultTabController(
              length: 2,
              child: Form(
                key: fromkey,
                child: Scaffold(
                    appBar: PreferredSize(
                        preferredSize: Size.fromHeight(28.0),
                        child: AppBar(
                          backgroundColor: Colors.white,
                          bottom: TabBar(
                            indicator: BoxDecoration(
                              color: KstorebuttonColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            // indicatorWeight: 5,
                            // indicatorPadding: EdgeInsets.only(top: 40),
                            tabs: [
                              InkWell(
                                child: Container(
                                  child: Text(
                                    "غرف",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                onTap: () {},
                              ),
                              InkWell(
                                child: Container(
                                  child: Text(
                                    "الاعضاء",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        )),
                    body: TabBarView(
                      children: [
                        // Icon(Icons.directions_transit),
                        Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: roomsearchtext,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'enter text to search';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String text) {
                                    SearchScreenCubit.get(context)
                                        .search(roomId: text);
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.search),
                                      ),
                                      hintText: "البحث عن غرف",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ))),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          if (state is SearchLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          if (state is SearchSuccessStates)
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => buildroomItem(
                                    SearchScreenCubit.get(context)
                                        .searchModel
                                        .data[index]),
                                itemCount: SearchScreenCubit.get(context)
                                    .searchModel
                                    .data
                                    .length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                              ),
                            ),
                        ]),

                        Column(children: [
                          SizedBox(
                            height: 20,
                          ),
                          Directionality(
                            textDirection: TextDirection.rtl,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                  controller: usersearchtext,
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'enter text to search';
                                    }
                                    return null;
                                  },
                                  onFieldSubmitted: (String text) {
                                    SearchScreenCubit.get(context)
                                        .Usersearch(userId: text);
                                  },
                                  decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.search),
                                      ),
                                      hintText: "البحث عن اعضاء",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide:
                                            BorderSide(color: Colors.black),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20.0)),
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ))),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          if (state is UserSearchLoadingState)
                            LinearProgressIndicator(),
                          SizedBox(
                            height: 10,
                          ),
                          if (state is UserSearchSuccessStates)
                            Expanded(
                              child: ListView.separated(
                                itemBuilder: (context, index) => builduserItem(
                                    SearchScreenCubit.get(context)
                                        .userSearchModel
                                        .data[index]),
                                itemCount: SearchScreenCubit.get(context)
                                    .userSearchModel
                                    .data
                                    .length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        Divider(),
                              ),
                            ),
                        ]),
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildroomItem(SearchData model) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: true,
          bottom: false,
          child: GestureDetector(
            onTap: () async {
              await Permission.microphone.request();
              Get.to(
                DetailsScreen(
                  roomId: model.id.toString(),
                  roomDesc: model.roomDesc,
                  roomName: model.roomName,
                  // role: ClientRole.Audience,

                  // roomName: model.roomName,
                ),
                // duration: Duration(milliseconds: 1000),
              );
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

  Widget builduserItem(UserSearchModelData model) => Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
          top: true,
          bottom: false,
          child: GestureDetector(
            onTap: () async {
              // await Permission.microphone.request();
              // Get.to(
              //   DetailsScreen(
              //     roomId: model.id.toString(),
              //     roomDesc: model.roomDesc,
              //     roomName: model.roomName,
              //     role: ClientRole.Audience,

              //     // roomName: model.roomName,
              //   ),
              //   // duration: Duration(milliseconds: 1000),
              // );
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
                      width: 70,
                      height: 70,
                      child: ClipRRect(
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8.0)),
                        child: Image.asset(
                          "assets/images/Profile Image.png",
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
                              // Icon(Icons.flag),
                              _sizedBox(width: 4.0),
                              Expanded(
                                  child: Text(
                                model.name,
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
                                // Icon(
                                //   Icons.queue_music,
                                //   size: 20,
                                // ),
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
                                    "عضو",
                                    // style: theme.textTheme.bodyText2
                                    //     .copyWith(fontSize: 13),
                                  ),
                                ),
                              ],
                            ),
                            _sizedBox(height: 8),
                            Text(
                              '',
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
}
