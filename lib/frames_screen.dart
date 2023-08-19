/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/get_wallet_model.dart';

import 'package:project/utils/constants.dart';
import 'package:project/models/frames_model.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/wallet_screen.dart';

import 'models/shop_intres_model.dart';

class framesScreen extends StatefulWidget {
  @override
  _framesScreenState createState() => _framesScreenState();
}

class _framesScreenState extends State<framesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  // Widget build(BuildContext context) {
  //   final size = MediaQuery.of(context).size;
  //   final theme = Theme.of(context);
  //   bool pressAttention = false;
  //   int check = 0;

  //   return BlocConsumer<ShopCubit, ShopIntresStates>(
  //     listener: (context, state) {},
  //     builder: (context, state) {
  //       return ConditionalBuilder(
  //         condition: ShopCubit.get(context).framesModel != null,
  //         builder: (context) =>
  //             getIntresItem(ShopCubit.get(context).framesModel),
  //         fallback: (context) => Container(
  //           color: Colors.white,
  //           child: Center(
  //             child: CircularProgressIndicator(),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        // ShopCubit.get(context).getFramesData();
        ShopCubit.get(context).getWalletAmount();

        return BlocConsumer<ShopCubit, ShopIntresStates>(
          listener: (context, state) {
            if (state is ShopPurchaseSuccessStates) {
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
                  CommonFunctions.showToast('تم شراء إطار', Colors.green);
                }
              }
            }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: ShopCubit.get(context).framesModel != null &&
                  ShopCubit.get(context).getWalletModel != null,
              builder: (context) => getIntresItem(
                  ShopCubit.get(context).framesModel,
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

  Widget getIntresItem(FramesModel model, GetWalletModel model1) => Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              navigator.pop();
            },
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.report_gmailerrorred_sharp,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
          centerTitle: true,
          title: Text(
            "البطاقه السحريه",
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
                  children: List.generate(model.data.length,
                      (index) => buildGridleProduct(model.data[index])))),
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

  Widget buildGridleProduct(
    FrameData model,
  ) =>
      Column(
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                height: 280,
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
                          model.url + model.giftLink,
                          height: 180,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('١٥يوما/' + model.name),
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
                        Spacer(),
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
                            print(model.id);
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
                                    'هل تريد شراء بطاقة سحرية ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )),

                                  // content: const Text('AlertDialog description'),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            ShopCubit.get(context).shopPurchase(
                                                id: model.id.toString());
                                            ShopCubit.get(context)
                                                .getWalletAmount();
                                            Navigator.pop(context, 'yes');

                                            // CommonFunctions.showToast(
                                            //     'تم شراء بطاقة سحرية',
                                            //     Colors.green);

                                            hasFrame =
                                                model.url + model.giftLink;
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

                            // setState(() {
                            //   fimage = model.url;
                            //   pressGeoON = !pressGeoON;
                            //   // CacheHelper.saveData(key: 'frameimage', value: model.url);
                            // });
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

          // : Container(
          //     width: 180,
          //     color: KstorebuttonColor,
          //     child: Center(
          //       child: Text(
          //         "done",
          //         style: TextStyle(color: Colors.white),
          //       ),
          //     ),
          //   )
        ],
      );
}
