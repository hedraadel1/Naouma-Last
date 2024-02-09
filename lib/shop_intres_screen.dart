import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:project/myIntres_screen.dart';

import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/wallet_screen.dart';

import 'models/shop_intres_model.dart';

class ShopIntresScreen extends StatefulWidget {
  @override
  _ShopIntresScreenState createState() => _ShopIntresScreenState();
}

class _ShopIntresScreenState extends State<ShopIntresScreen> {
  String id;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // Widget build(BuildContext context) {
  //   return BlocConsumer<ShopCubit, ShopIntresStates>(
  //     listener: (context, state) {},
  //     builder: (context, state) {
  //       return ConditionalBuilder(
  //         condition: ShopCubit.get(context).intresModel != null,
  //         builder: (context) =>
  //             getIntresItem(ShopCubit.get(context).intresModel),
  //         fallback: (context) => Container(
  //           color: Colors.white,
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         ),
  //       );
  //     },
  //   );

  //   //  Scaffold(
  //   //     backgroundColor: Colors.grey.shade300,
  //   //     appBar: AppBar(
  //   //       centerTitle: true,
  //   //       title: Text(
  //   //         "المركبات",
  //   //         style: TextStyle(color: Colors.white),
  //   //       ),
  //   //     ),
  //   //     body: Padding(
  //   //       padding: const EdgeInsets.all(8.0),
  //   //       child: Container(
  //   //         child: GridView.builder(
  //   //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //   //               crossAxisCount: 2,
  //   //             ),
  //   //             itemCount: 300,
  //   //             itemBuilder: (BuildContext context, int index) {
  //   //               return Card(
  //   //                 child: Column(
  //   //                   mainAxisAlignment: MainAxisAlignment.center,
  //   //                   children: [
  //   //                     Text("aaa"),
  //   //                     Text("aaa"),
  //   //                     Text("aaa"),
  //   //                     Text("aaa"),
  //   //                     Text("aaa"),
  //   //                   ],
  //   //                 ),
  //   //               );
  //   //             }),
  //   //       ),
  //   //     )
  //   //     // body: NestedScrollView(
  //   //     //   headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
  //   //     //     return <Widget>[
  //   //     //       SliverOverlapAbsorber(
  //   //     //         handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
  //   //     //         sliver: SliverAppBar(
  //   //     //           expandedHeight: size.height * 0.22,
  //   //     //           floating: true,
  //   //     //           pinned: true,
  //   //     //           snap: false,
  //   //     //           backgroundColor: Colors.grey.shade300,
  //   //     //           forceElevated: innerBoxIsScrolled,
  //   //     //           flexibleSpace: Stack(
  //   //     //             children: [
  //   //     //               Container(
  //   //     //                 margin: const EdgeInsets.only(
  //   //     //                     left: 2.0, right: 2.0, top: 0.0, bottom: 0),
  //   //     //                 decoration: BoxDecoration(
  //   //     //                   color: kPrimaryColor,
  //   //     //                   // image: DecorationImage(
  //   //     //                   //   image: NetworkImage(
  //   //     //                   //       'https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/4bb82b72535211.5bead62fe26d5.jpg'),
  //   //     //                   //   //your image
  //   //     //                   //   fit: BoxFit.cover,
  //   //     //                   // ),
  //   //     //                   borderRadius: BorderRadius.only(
  //   //     //                     bottomLeft: Radius.circular(0),
  //   //     //                     bottomRight: Radius.circular(0),
  //   //     //                   ),
  //   //     //                 ),
  //   //     //                 // child: HomeSlide(),
  //   //     //               ),

  //   //     //               // Align(
  //   //     //               //   alignment: Alignment.center,
  //   //     //               //   // child: _loadingRoom?Center(child: Container(width: 24, height:24,child: CircularProgressIndicator()),):_haveARoom?_myRoom(roomId, roomName, roomDesc):_createRoomSlide(theme),
  //   //     //               //   child: StreamBuilder<QuerySnapshot>(
  //   //     //               //     stream: _firestoreInstance
  //   //     //               //         .collection('rooms')
  //   //     //               //         .where("roomOwnerId",
  //   //     //               //             isEqualTo:
  //   //     //               //                 PreferencesServices.getString(ID_KEY))
  //   //     //               //         .snapshots(),
  //   //     //               //     builder: (BuildContext context,
  //   //     //               //         AsyncSnapshot<QuerySnapshot> snapshot) {
  //   //     //               //       if (snapshot.hasData &&
  //   //     //               //           snapshot.data.docs.length > 0) {
  //   //     //               //         return _myRoom(
  //   //     //               //             snapshot.data.docs[0].id,
  //   //     //               //             snapshot.data.docs[0]['roomName'],
  //   //     //               //             snapshot.data.docs[0]['roomDesc']);
  //   //     //               //       } else {
  //   //     //               //         return _createRoomSlide(theme);
  //   //     //               //       }
  //   //     //               //     },
  //   //     //               //   ),
  //   //     //               // ),
  //   //     //             ],
  //   //     //           ),

  //   //     //           // bottom: AppBar(
  //   //     //           //   toolbarHeight: 50,
  //   //     //           //   backgroundColor: Colors.white,
  //   //     //           //   elevation: 4.0,
  //   //     //           //   title: TabBar(
  //   //     //           //     indicatorSize: TabBarIndicatorSize.label,
  //   //     //           //     indicatorColor: kPrimaryColor,
  //   //     //           //     indicatorWeight: 4.0,
  //   //     //           //     labelStyle: TextStyle(
  //   //     //           //         fontSize: 18.0, fontWeight: FontWeight.w700),
  //   //     //           //     //For Selected tab
  //   //     //           //     tabs:
  //   //     //           //         _tabs.map((String name) => Tab(text: name)).toList(),
  //   //     //           //   ),
  //   //     //           // ),
  //   //     //         ),
  //   //     //       ),
  //   //     //     ];
  //   //     //   },
  //   //     //   body: Row(
  //   //     //     children: [
  //   //     //       Expanded(
  //   //     //           flex: 1,
  //   //     //           child: Column(
  //   //     //             mainAxisAlignment: MainAxisAlignment.spaceAround,
  //   //     //             children: [
  //   //     //               Container(
  //   //     //                 color: Colors.green,
  //   //     //                 child: Text('aaaa'),
  //   //     //               ),
  //   //     //             ],
  //   //     //           )),
  //   //     //       Expanded(
  //   //     //         flex: 1,
  //   //     //         child: Container(
  //   //     //           color: Colors.black,
  //   //     //           child: Text('aaaa'),
  //   //     //         ),
  //   //     //       ),
  //   //     //       Expanded(
  //   //     //         flex: 1,
  //   //     //         child: Container(
  //   //     //           color: Colors.red,
  //   //     //           child: Text('aaaa'),
  //   //     //         ),
  //   //     //       ),
  //   //     //       Expanded(
  //   //     //         flex: 1,
  //   //     //         child: Container(
  //   //     //           color: Colors.green,
  //   //     //           child: Text('aaaa'),
  //   //     //         ),
  //   //     //       ),
  //   //     //     ],
  //   //     //   ),
  //   //     // ),
  //   //     );
  // }

  Widget build(BuildContext context) {
    String count;

    return Builder(
      builder: (BuildContext context) {
        // ShopCubit.get(context).specialRoomID();
        ShopCubit.get(context).getWalletAmount();

        return BlocConsumer<ShopCubit, ShopIntresStates>(
          listener: (context, state) {
            if (state is ShopPurchaseSuccessStates) {
              haveIntes = true;

              if (ShopCubit.get(context).shopPurchaseModel.status == 201) {
                if (ShopCubit.get(context).shopPurchaseModel.message != null) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: AlertDialog(
                        title: Center(
                          child: Text(
                              '${ShopCubit.get(context).shopPurchaseModel.message}'),
                        ),
                        // content: const Text('AlertDialog description'),
                        actions: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  // ShopCubit.get(context)
                                  //     .shopPurchase(id: model.id);
                                  // ShopCubit.get(context).getWalletAmount();
                                  Get.to(WalletScreen());
                                },
                                child: const Text('الشحن'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'no'),
                                child: const Text('إلغاء'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                  // CommonFunctions.showToast(
                  //     ShopCubit.get(context).shopPurchaseModel.message,
                  //     Colors.green);
                } else {
                  CommonFunctions.showToast('تم شراء مركبة', Colors.green);
                }
              }
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: ShopCubit.get(context).intresModel != null &&
                  ShopCubit.get(context).getWalletModel != null,
              builder: (context) => getIntresItem(
                  ShopCubit.get(context).intresModel,
                  ShopCubit.get(context).getWalletModel),
              fallback: (context) => Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget getIntresItem(IntresModel model, GetWalletModel model1) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigator.pop();
            },
          ),
          actions: [
            TextButton(
              child: Text(
                "الخاص بي",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                Get.to(MyIntersScreen());
              },
            )
          ],
          centerTitle: true,
          title: Text(
            "المركبات",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                      model.data.length,
                      (index) => buildGridleProduct(
                            model.data[index],
                          )))),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Row(
            children: [
              IconButton(
                  icon:
                      Icon(Icons.monetization_on_rounded, color: Colors.orange),
                  onPressed: () {}),
              Text(
                model1.data.walletAmount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WalletScreen()),
                      );
                    },
                    child: Text(
                      "< الشحن",
                      style: TextStyle(color: kPrimaryColor),
                    )),
              )
            ],
          ),
        ),
      );

  Widget buildGridleProduct(IntresData model) => Column(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                height: 270,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(8.0),
                        left: Radius.circular(8.0)),
                    child: Column(
                      children: [
                        Image.network(
                          (model.url ?? '') + model.giftLink,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('٣٠يوما/' + model.name),
                            Text(
                              model.price.toString(),
                              style: TextStyle(color: KstorebuttonColor),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.monetization_on_rounded,
                              color: Colors.orange,
                              size: 14,
                            )
                          ],
                        ),
                        InkWell(
                          child: Container(
                            width: double.infinity,
                            height: 46,
                            color: KstorebuttonColor,
                            child: Center(
                              child: Text(
                                'شراء',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ),
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  title: Center(
                                    child: const Text(
                                      'هل تريد شراء مركبه ',
                                    ),
                                  ),
                                  // content: const Text('AlertDialog description'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            ShopCubit.get(context)
                                                .shopPurchase(id: id);
                                            ShopCubit.get(context)
                                                .getWalletAmount();
                                            Navigator.pop(context, 'yes');

                                            // CommonFunctions.showToast(
                                            //     'تم شراء مركبه', Colors.green);

                                            // Navigator.of(context).push(new MaterialPageRoute(
                                            //     builder: (context) => PersonalID_screen()));
                                          },
                                          child: const Text('نعم'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'no'),
                                          child: const Text('لا'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );

                            setState(() {
                              id = model.id.toString();
                              print(id);
                            });

                            // ShopCubit.get(context).shopPurchase(id: id);
                          },
                        )
                      ],
                    )),
              ),
            ),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Theme(
                      data: ThemeData(
                          dialogBackgroundColor: Colors.grey.withOpacity(0.0)),
                      child: AlertDialog(
                        content: SingleChildScrollView(
                            child: Image.network(
                          model.url + model.giftLink,
                        )),
                      ),
                    );
                  });
            },
          ),
          // Container(child: Center(child: Text(model.price.toString()))),
        ],
      );
}
