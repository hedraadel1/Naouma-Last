import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/friendRequests.dart';
import 'package:project/level_screen.dart';
import 'package:project/missions_screen.dart';
import 'package:project/models/getProfile_model.dart';
import 'package:project/settingsScreen.dart';
import 'package:project/store_screen.dart';
import 'package:project/utils/constants.dart';
import 'package:project/utils/preferences_services.dart';
import 'package:project/view/login/login_view.dart';
import 'package:project/view/profile/profile_cubit.dart';
import 'package:project/view/profile/profile_screen.dart';
import 'package:project/view/profile/profile_states.dart';

import '../../../perimem_screen.dart';
import '../../../shopCubit.dart';
import '../../../shopStates.dart';
import '../../../wallet_screen.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer(this.scaffoldKey);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
        create: (context) => ProfileCubit()
          ..getprofile()
          ..getuserExp(id: apiid)
          ..getWalletAmount(),

        // ProfileCubit.get(context).getprofile();
        // ProfileCubit.get(context).getuserExp(id: id);

        child: BlocConsumer<ProfileCubit, ProfileStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = ProfileCubit.get(context).getUserExpModel;
            var waletmodel = ProfileCubit.get(context).getWalletModel;
            return ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    50.0,
                  ),
                  bottomLeft: Radius.circular(
                    50.0,
                  )),
              child: Drawer(
                child: ListView(
                  children: <Widget>[
                    // Row(
                    //   children: [
                    //     IconButton(
                    //         icon: Icon(Icons.person_add),
                    //         onPressed: () {
                    //           Get.to(ProfileScreen());
                    //         }),
                    //   ],
                    // ),

                    _createHeader(
                        ProfileCubit.get(context).profileModel, theme, context),
                    Divider(
                      color: Colors.grey,
                      height: 2,
                    ), //here is a divider
                    // _createDrawerItem(
                    //   icon: Icon(
                    //     Icons.add_alert_rounded,
                    //     size: 28,
                    //   ),
                    //   title: 'طلبات الصداقه',
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Get.to(FriendRequestsScreen());
                    //   },
                    // ),

                    _createDrawerItem(
                      icon: Icon(
                        Icons.home,
                        size: 28,
                      ),
                      title: 'المهمات',
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(MahamScreen());
                      },
                    ),
                    // _createDrawerItem(
                    //   icon: Icon(Icons.wallet_travel),
                    //   title: 'المحفظة',
                    //   onTap: () {
                    //     Navigator.pop(context);
                    //     Get.to(WalletScreen());
                    //   },
                    // ),

                    SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.wallet_travel,
                            size: 28,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text('المحفظة'),
                          Spacer(),

                          ConditionalBuilder(
                            condition:
                                ProfileCubit.get(context).getWalletModel !=
                                    null,
                            builder: (context) => Row(
                              children: [
                                Text(
                                  "${waletmodel.data.walletAmount.toString()}",
                                  style: TextStyle(color: Colors.orange),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.monetization_on_rounded,
                                  color: Colors.orange,
                                  size: 15,
                                ),
                              ],
                            ),
                            fallback: (context) => Container(
                              color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          // Text(
                          //   '',
                          //   // "Lv.${model.data.userCurrentLevel.toString()}",
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(WalletScreen());
                      },
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    _createDrawerItem(
                      icon: Icon(
                        Icons.wallet_membership_outlined,
                        size: 28,
                      ),
                      title: 'الاستقراطية',
                      onTap: () {
                        Get.to(PerimemScreen());
                      },
                    ),
                    _createDrawerItem(
                      icon: Icon(
                        Icons.store,
                        size: 28,
                      ),
                      title: 'المتجر',
                      onTap: () {
                        Get.to(StoreScreen());
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    InkWell(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.label_important_outline_sharp,
                            size: 28,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text('المستوي'),
                          Spacer(),

                          ConditionalBuilder(
                            condition:
                                ProfileCubit.get(context).getUserExpModel !=
                                    null,
                            builder: (context) => Text(
                              "Lv.${model.data.userCurrentLevel.toString()}",
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            fallback: (context) => Container(
                              color: Colors.white,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          // Text(
                          //   '',
                          //   // "Lv.${model.data.userCurrentLevel.toString()}",
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          SizedBox(
                            width: 10,
                          )
                        ],
                      ),
                      onTap: () {
                        Get.to(LevelScreen());
                      },
                    ),
                    // _createDrawerItem(
                    //   icon: Icon(
                    //     Icons.label_important_outline_sharp,
                    //     size: 28,
                    //   ),
                    //   title: 'المستوي',
                    //   onTap: () {
                    //     Get.to(LevelScreen());
                    //   },
                    // ),
                    Divider(),
                    _createDrawerItem(
                      icon: Icon(
                        Icons.language,
                        size: 28,
                      ),
                      title: 'اللغة',
                      onTap: () {
                        Navigator.pop(context);
                        // Get.to(LanguageScreen());
                      },
                    ),
                    _createDrawerItem(
                      icon: Icon(
                        Icons.request_quote_outlined,
                        size: 28,
                      ),
                      title: 'الأسئلة الشائعة والموضوعات',
                      onTap: () {
                        Navigator.pop(context);
                        // Get.to(CommonQuestionsScreen());
                      },
                    ),
                    _createDrawerItem(
                      icon: Icon(
                        Icons.settings,
                        size: 28,
                      ),
                      title: 'الاعدادات',
                      onTap: () {
                        Navigator.pop(context);
                        Get.to(SettingsScreen());
                      },
                    ),

                    // _createDrawerItem(
                    //   icon: Icon(
                    //     Icons.settings,
                    //     size: 28,
                    //   ),
                    //   title: 'تسجيل دخول',
                    //   onTap: () {
                    //     CacheHelper.removeData(key: 'token').then((value) {
                    //       if (value) {
                    //         Get.to(LoginView());
                    //       }
                    //     });
                    //   },
                    // ),
                  ],
                ),
              ),
            );
          },
        )

        // create: (context) => ProfileCubit()..getprofile(),

        );
  }

  Widget _createHeader(GetProfileModel model, ThemeData theme, context) {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 15,
          ),
          hasFrame != null
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                        width: 60,
                        child: Image.network(
                          hasFrame,
                        )), // Back image
                    InkWell(
                      child: Container(
                        width: 40,
                        child: Image.asset(
                          "assets/images/Profile Image.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                      onTap: () {
                        Get.to(ProfileScreen());
                      },
                    ) // Front image
                  ],
                )
              : InkWell(
                  child: Container(
                    width: 40,
                    child: Image.asset(
                      "assets/images/Profile Image.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  onTap: () {
                    Get.to(ProfileScreen());
                  },
                ),

          SizedBox(
            height: 10,
          ),

          Container(
            child: Text(username),
          ),
          Container(
            child: Text("${userid}:ID"),
          )

          // SizedBox(
          //     // height: 8.0,
          //     ),
          // // Text(
          // //   PreferencesServices.getString(Name_KEY),
          // //   style: theme.textTheme.bodyText1.copyWith(
          // //       color: Colors.black,
          // //       fontSize: 17,
          // //       fontWeight: FontWeight.bold),
          // // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       child: Text("المستوي"),
          //     ),
          //     SizedBox(
          //       width: 15,
          //     ),
          //     Container(
          //       decoration: BoxDecoration(
          //           color: KbuttonColor,
          //           borderRadius: BorderRadius.circular(10)),
          //       width: 50,
          //       child: Center(
          //         child: Text(
          //           level,
          //           style: TextStyle(color: Color.fromARGB(255, 74, 74, 74)),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       child: Text("نقاط الخبرة"),
          //     ),
          //     SizedBox(
          //       width: 10,
          //     ),
          //     Container(
          //       decoration: BoxDecoration(
          //           color: KbuttonColor,
          //           borderRadius: BorderRadius.circular(10)),
          //       width: 50,
          //       child: Center(
          //         child: Text(
          //           expNum,
          //           style: TextStyle(color: Color.fromARGB(255, 74, 74, 74)),
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       child: Container(
          //         decoration: BoxDecoration(
          //             color: KbuttonColor,
          //             borderRadius: BorderRadius.circular(10)),
          //         width: 100,
          //         child: Center(
          //           child: Text(
          //             'طلبات الصداقة',
          //             style:
          //                 TextStyle(color: Color.fromARGB(255, 74, 74, 74)),
          //           ),
          //         ),
          //       ),
          //       onTap: () {
          //         Navigator.pop(context);
          //         Get.to(FriendRequestsScreen());
          //       },
          //     ),
          //     SizedBox(
          //       width: 15,
          //     ),
          //     Image.asset(
          //       "assets/icons/roomaddfriend.png",
          //     ),
          //   ],
          // ),

          // SizedBox(
          //   height: 10,
          // ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     InkWell(
          //       child: Container(
          //         decoration: BoxDecoration(
          //             color: KbuttonColor,
          //             borderRadius: BorderRadius.circular(10)),
          //         width: 100,
          //         child: Center(
          //           child: Text(
          //             'الملف الشخصي',
          //             style:
          //                 TextStyle(color: Color.fromARGB(255, 74, 74, 74)),
          //           ),
          //         ),
          //       ),
          //       onTap: () {
          //         Navigator.pop(context);
          //         Get.to(ProfileScreen());
          //       },
          //     ),
          //     SizedBox(
          //       width: 15,
          //     ),
          //     Image.asset(
          //       "assets/icons/roomaddfriend.png",
          //     ),
          //   ],
          // )
          // IconButton(onPressed: (){}, icon: icon)
          // Text(
          //   model.data.first.name.toString(),
          //   style: theme.textTheme.bodyText2.copyWith(
          //     color: Colors.black,
          //   ),
          // ),
          // Text(
          //   model.data.first.userId.toString(),
          //   style: theme.textTheme.bodyText2.copyWith(
          //     color: Colors.black,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _createDrawerItem(
      {Icon icon, String title, GestureTapCallback onTap}) {
    return ListTile(
      leading: icon,
      title: Text(title),
      // trailing: Icon(),
      onTap: onTap,
    );
  }
}
