import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:project/common_functions.dart';
import 'package:project/models/get_wallet_model.dart';
import 'package:project/models/shop_purchase_model.dart';
import 'package:project/shopCubit.dart';
import 'package:project/shopStates.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/wallet_screen.dart';
import 'dart:math';
import 'models/shop_background_mode.dart';
import 'myBackground_screen.dart';

class ShopbackgroundGift extends StatefulWidget {
  const ShopbackgroundGift({Key key}) : super(key: key);

  @override
  State<ShopbackgroundGift> createState() => _ShopbackgroundGiftState();
}

class _ShopbackgroundGiftState extends State<ShopbackgroundGift> {
  String id;
  String price;
  double difference;

  @override
  // Widget build(BuildContext context) {
  //   return BlocConsumer<ShopCubit, ShopIntresStates>(
  //     listener: (context, state) {

  //     },
  //     builder: (context, state) {
  //       return ConditionalBuilder(
  //         condition: ShopCubit.get(context).backgroundModel != null,
  //         builder: (context) =>
  //             getIntresItem(ShopCubit.get(context).backgroundModel),
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
        // ShopCubit.get(context).getBackgroundData();
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
                  CommonFunctions.showToast('تم شراء موضوع', Colors.green);
                }
              }
            }
            // else {
            //   if (ShopCubit.get(context).shopPurchaseModel.status == 400)
            //     CommonFunctions.showToast(
            //         'لا يوجد رصيد كافي في المحفظة', Colors.red);
            // }

            // if (state is ShopPurchaseErrorStates) {
            //   if (ShopCubit.get(context).shopPurchaseModel.status == 400)
            //     CommonFunctions.showToast(
            //         ShopCubit.get(context).shopPurchaseModel.message,
            //         Colors.red);
            // }
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition: ShopCubit.get(context).backgroundModel != null &&
                  ShopCubit.get(context).getWalletModel != null,
              builder: (context) => getIntresItem(
                  ShopCubit.get(context).backgroundModel,
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

  Widget getIntresItem(BackgroundModel model, GetWalletModel model1) =>
      Scaffold(
        backgroundColor: Colors.grey.shade300,
        appBar: AppBar(
          actions: [
            TextButton(
              child: Text(
                "الخاص بي",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
              onPressed: () {
                Get.to(MyBackgroundScreen());
              },
            )
          ],
          centerTitle: true,
          title: Text(
            "الموضوعات",
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
                  childAspectRatio: 1 / 1.4,
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

  Widget buildGridleProduct(BackgroundData model) => Column(
        children: [
          InkWell(
            child: ClipRRect(
                borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(8.0), left: Radius.circular(8.0)),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network(
                          model.url + model.giftLink,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.fill,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 170,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.monetization_on_rounded,
                                    color: Colors.orange,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    model.price.toString(),
                                    style: TextStyle(color: Colors.orange),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    // Container(
                    //     child: Center(child: Text(model.price.toString()))),
                    InkWell(
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        color: KstorebuttonColor,
                        child: Center(
                          child: Text(
                            'شراء',
                            style: TextStyle(color: Colors.white, fontSize: 18),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              title: Center(
                                child: const Text('هل تريد شراء موضوع للغرفة'),
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
                                            .shopPurchase(id: model.id);
                                        ShopCubit.get(context)
                                            .getWalletAmount();
                                        Navigator.pop(context, 'yes');
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
                          // price = totalWalletAmount-model.price.toString();
                        });

                        //  ShopCubit.get(context).shopPurchase(id: id);
                      },
                    )
                  ],
                )),
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
              setState(() {
                // id = model.id.toString();
                // print(id);
                // image = model.url;
                // pressGeoON = true;
                // CacheHelper.saveData(key: 'image', value: model.url);
              });
            },
          ),
        ],
      );
}
