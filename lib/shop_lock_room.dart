/*
 * Copyright (c) 2023. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
 * Morbi non lorem porttitor neque feugiat blandit. Ut vitae ipsum eget quam lacinia accumsan.
 * Etiam sed turpis ac ipsum condimentum fringilla. Maecenas magna.
 * Proin dapibus sapien vel ante. Aliquam erat volutpat. Pellentesque sagittis ligula eget metus.
 * Vestibulum commodo. Ut rhoncus gravida arcu.
 */

// import 'dart:ui';
//
// import 'package:conditional_builder/conditional_builder.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:project/common_functions.dart';
// import 'package:project/models/get_wallet_model.dart';
// import 'package:project/models/showLocks_model.dart';
// import 'package:project/shopCubit.dart';
// import 'package:project/shopStates.dart';
// import 'package:project/utils/constants.dart';
// import 'package:project/wallet_screen.dart';
//
// class ShopLockRoom extends StatefulWidget {
//   const ShopLockRoom({Key key}) : super(key: key);
//
//   @override
//   State<ShopLockRoom> createState() => _ShopLockRoomState();
// }
//
// class _ShopLockRoomState extends State<ShopLockRoom> {
//   @override
//   Widget build(BuildContext context) {
//     return Builder(
//       builder: (BuildContext context) {
//         // ShopCubit.get(context).specialRoomID();
//         ShopCubit.get(context).getWalletAmount();
//         ShopCubit.get(context).showLocks();
//
//         return BlocConsumer<ShopCubit, ShopIntresStates>(
//           listener: (context, state) {
//             if (state is LockPurchaseSuccessStates) {
//               CommonFunctions.showToast('تم شراء قفل للغرفة', Colors.green);
//               // haveIntes = true;
//
//               // if (ShopCubit.get(context).shopPurchaseModel.status == 201) {
//               //   if (ShopCubit.get(context).shopPurchaseModel.message != null) {
//               //     showDialog<String>(
//               //       context: context,
//               //       builder: (BuildContext context) => Directionality(
//               //         textDirection: TextDirection.rtl,
//               //         child: AlertDialog(
//               //           title: Center(
//               //             child: Text(
//               //                 '${ShopCubit.get(context).shopPurchaseModel.message}'),
//               //           ),
//               //           // content: const Text('AlertDialog description'),
//               //           actions: <Widget>[
//               //             Row(
//               //               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               //               children: [
//               //                 TextButton(
//               //                   onPressed: () {
//               //                     // ShopCubit.get(context)
//               //                     //     .shopPurchase(id: model.id);
//               //                     // ShopCubit.get(context).getWalletAmount();
//               //                     Get.to(WalletScreen());
//               //                   },
//               //                   child: const Text('الشحن'),
//               //                 ),
//               //                 TextButton(
//               //                   onPressed: () => Navigator.pop(context, 'no'),
//               //                   child: const Text('إلغاء'),
//               //                 ),
//               //               ],
//               //             )
//               //           ],
//               //         ),
//               //       ),
//               //     );
//               //     // CommonFunctions.showToast(
//               //     //     ShopCubit.get(context).shopPurchaseModel.message,
//               //     //     Colors.green);
//               //   } else {
//               //     CommonFunctions.showToast('تم شراء مركبة', Colors.green);
//               //   }
//               // }
//             }
//           },
//           builder: (context, state) {
//             return ConditionalBuilder(
//               condition: ShopCubit.get(context).getWalletModel != null &&
//                   ShopCubit.get(context).showLocksModel != null,
//               builder: (context) => buildItem(
//                   ShopCubit.get(context).getWalletModel,
//                   ShopCubit.get(context).showLocksModel),
//               fallback: (context) => Container(
//                 color: Colors.white,
//                 child: Center(
//                   child: CircularProgressIndicator(),
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   Widget buildItem(GetWalletModel model, ShowLocksModel modelData) => Scaffold(
//         appBar: AppBar(
//           title: Text('قفل الغرفة',
//               style: TextStyle(
//                 color: Colors.white,
//                 // fontWeight: FontWeight.bold,
//               )),
//         ),
//         body: ListView(children: [
//           Column(children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Container(
//                       height: 150,
//                       // margin: EdgeInsets.all(100.0),
//                       decoration: BoxDecoration(
//                           color: kPrimaryLightColor, shape: BoxShape.circle),
//
//                       child: Column(children: [
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           'صالح',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 16),
//                         ),
//                         // SizedBox(
//                         //   height: 10,
//                         // ),
//                         Container(
//                             height: 10,
//                             width: 140,
//                             child: Divider(
//                               color: Colors.white,
//                             )),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text('0',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16)),
//
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Container(
//                             height: 10,
//                             width: 140,
//                             child: Divider(
//                               color: Colors.white,
//                             )),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Text('أيام',
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16)),
//                       ]),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//
//             ListView.builder(
//                 scrollDirection: Axis.vertical,
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) =>
//                     lockList(modelData.data[index], index, context
//
//                         // HomeCubit.get(context).showFriendsModel.data[index],
//                         ),
//                 // : (context, index) => Divider(),
//                 itemCount: modelData.data.length),
//
//             // ListView.separated(
//             //     itemCount: 1,
//             //     separatorBuilder: (context, int) {
//             //       return Divider();
//             //     },
//             //     itemBuilder: (context, index) {
//             //       return Row(
//             //         mainAxisAlignment: MainAxisAlignment.center,
//             //         children: [
//             //           Container(
//             //             width: 350,
//             //             height: 70,
//             //             child: Row(
//             //               children: [
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 Container(
//             //                   width: 70,
//             //                   height: 30,
//             //                   decoration: BoxDecoration(
//             //                       borderRadius: BorderRadius.circular(10),
//             //                       color: Colors.orange),
//             //                   child: Center(
//             //                       child: Text("شراء",
//             //                           style: TextStyle(
//             //                               color: Colors.white, fontSize: 16))),
//             //                 ),
//             //                 SizedBox(
//             //                   width: 30,
//             //                 ),
//             //                 Text('٢ شهر',
//             //                     style: TextStyle(
//             //                         color: Colors.grey, fontSize: 16)),
//             //                 Spacer(),
//
//             //                 Text('19,999',
//             //                     style: TextStyle(
//             //                         color: Colors.orange,
//             //                         fontWeight: FontWeight.bold,
//             //                         fontSize: 16)),
//             //                 SizedBox(
//             //                   width: 2,
//             //                 ),
//
//             //                 Icon(
//             //                   Icons.monetization_on_rounded,
//             //                   size: 16,
//             //                   color: Colors.orange,
//             //                 ),
//             //                 SizedBox(
//             //                   width: 10,
//             //                 ),
//             //                 // Text('aaaaaaaaaaaa'),
//             //               ],
//             //             ),
//             //             decoration: BoxDecoration(
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 border: Border.all(color: Colors.grey.shade400)),
//             //           )
//             //         ],
//             //       );
//             //     }),
//
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       width: 350,
//             //       height: 70,
//             //       child: Row(
//             //         children: [
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           Container(
//             //             width: 70,
//             //             height: 30,
//             //             decoration: BoxDecoration(
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 color: Colors.orange),
//             //             child: Center(
//             //                 child: Text("شراء",
//             //                     style: TextStyle(
//             //                         color: Colors.white, fontSize: 16))),
//             //           ),
//             //           SizedBox(
//             //             width: 30,
//             //           ),
//             //           Text('١ شهر',
//             //               style: TextStyle(color: Colors.grey, fontSize: 16)),
//             //           Spacer(),
//
//             //           Text('6,999',
//             //               style: TextStyle(
//             //                   color: Colors.orange,
//             //                   fontWeight: FontWeight.bold,
//             //                   fontSize: 16)),
//             //           SizedBox(
//             //             width: 2,
//             //           ),
//
//             //           Icon(
//             //             Icons.monetization_on_rounded,
//             //             size: 16,
//             //             color: Colors.orange,
//             //           ),
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           // Text('aaaaaaaaaaaa'),
//             //         ],
//             //       ),
//             //       decoration: BoxDecoration(
//             //           borderRadius: BorderRadius.circular(10),
//             //           border: Border.all(color: Colors.grey.shade400)),
//             //     )
//             //   ],
//             // ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       width: 350,
//             //       height: 70,
//             //       child: Row(
//             //         children: [
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           Container(
//             //             width: 70,
//             //             height: 30,
//             //             decoration: BoxDecoration(
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 color: Colors.orange),
//             //             child: Center(
//             //                 child: Text("شراء",
//             //                     style: TextStyle(
//             //                         color: Colors.white, fontSize: 16))),
//             //           ),
//             //           SizedBox(
//             //             width: 30,
//             //           ),
//             //           Text('٢ شهر',
//             //               style: TextStyle(color: Colors.grey, fontSize: 16)),
//             //           Spacer(),
//
//             //           Text('19,999',
//             //               style: TextStyle(
//             //                   color: Colors.orange,
//             //                   fontWeight: FontWeight.bold,
//             //                   fontSize: 16)),
//             //           SizedBox(
//             //             width: 2,
//             //           ),
//
//             //           Icon(
//             //             Icons.monetization_on_rounded,
//             //             size: 16,
//             //             color: Colors.orange,
//             //           ),
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           // Text('aaaaaaaaaaaa'),
//             //         ],
//             //       ),
//             //       decoration: BoxDecoration(
//             //           borderRadius: BorderRadius.circular(10),
//             //           border: Border.all(color: Colors.grey.shade400)),
//             //     )
//             //   ],
//             // ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     Container(
//             //       width: 350,
//             //       height: 70,
//             //       child: Row(
//             //         children: [
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           Container(
//             //             width: 70,
//             //             height: 30,
//             //             decoration: BoxDecoration(
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 color: Colors.orange),
//             //             child: Center(
//             //                 child: Text("شراء",
//             //                     style: TextStyle(
//             //                         color: Colors.white, fontSize: 16))),
//             //           ),
//             //           SizedBox(
//             //             width: 30,
//             //           ),
//             //           Text('٣ شهر',
//             //               style: TextStyle(color: Colors.grey, fontSize: 16)),
//             //           Spacer(),
//
//             //           Text('69,999',
//             //               style: TextStyle(
//             //                   color: Colors.orange,
//             //                   fontWeight: FontWeight.bold,
//             //                   fontSize: 16)),
//             //           SizedBox(
//             //             width: 2,
//             //           ),
//
//             //           Icon(
//             //             Icons.monetization_on_rounded,
//             //             size: 16,
//             //             color: Colors.orange,
//             //           ),
//             //           SizedBox(
//             //             width: 10,
//             //           ),
//             //           // Text('aaaaaaaaaaaa'),
//             //         ],
//             //       ),
//             //       decoration: BoxDecoration(
//             //           borderRadius: BorderRadius.circular(10),
//             //           border: Border.all(color: Colors.grey.shade400)),
//             //     )
//             //   ],
//             // ),
//             Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Center(
//                   child: Text(
//                     "قفل الغرفة",
//                     style: TextStyle(color: Colors.grey.shade600),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     'قفل الغرفة  .',
//                     style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ]),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     ' أدخل الغرفة بكلمة مرور  ',
//                     style: TextStyle(color: Colors.grey.shade400),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ]),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     'مزايا لمالك الروم  .',
//                     style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ]),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     'فقط مالك الغرفة يستطيع إغلاق أو فتح الغرفة  ',
//                     style: TextStyle(color: Colors.grey.shade400),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ]),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     'كيفية الاستخدام   .',
//                     style: TextStyle(color: Colors.grey.shade500, fontSize: 16),
//                   ),
//                   SizedBox(
//                     width: 15,
//                   ),
//                 ]),
//                 Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//                   Text(
//                     'في الغرفة ->أعلي اليمين ...->القفل  ',
//                     style: TextStyle(color: Colors.grey.shade400),
//                   ),
//                   SizedBox(
//                     width: 30,
//                   ),
//                 ]),
//               ],
//             )
//           ]),
//         ]),
//         bottomNavigationBar: BottomAppBar(
//           child: Row(
//             children: [
//               IconButton(
//                   icon:
//                       Icon(Icons.monetization_on_rounded, color: Colors.orange),
//                   onPressed: () {}),
//               Text(
//                 model.data.walletAmount.toString(),
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               Spacer(),
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => WalletScreen()),
//                       );
//                     },
//                     child: Text(
//                       "< الشحن",
//                       style: TextStyle(color: kPrimaryColor),
//                     )),
//               )
//             ],
//           ),
//         ),
//       );
// }
//
// Widget lockList(ShowLocksModelData model, int index, context) => Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Container(
//           width: 350,
//           height: 70,
//           child: Row(
//             children: [
//               SizedBox(
//                 width: 10,
//               ),
//               InkWell(
//                 child: Container(
//                   width: 70,
//                   height: 30,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       color: Colors.orange),
//                   child: Center(
//                       child: Text("شراء",
//                           style: TextStyle(color: Colors.white, fontSize: 16))),
//                 ),
//                 onTap: () {
//                   showDialog<String>(
//                     context: context,
//                     builder: (BuildContext context) => Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: AlertDialog(
//                         shape: RoundedRectangleBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(15))),
//                         title: Center(
//                           child: const Text('هل تريد شراء قفل للغرفة'),
//                         ),
//                         // content: const Text('AlertDialog description'),
//                         actions: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//                                   ShopCubit.get(context)
//                                       .lockPurchase(id: model.id);
//                                   Navigator.pop(context, 'yes');
//
//                                   // CommonFunctions
//                                   //     .showToast(
//                                   //         'تم حظر العضو',
//                                   //         Colors
//                                   //             .green);
//                                 },
//                                 child: const Text('نعم'),
//                               ),
//                               TextButton(
//                                 onPressed: () => Navigator.pop(context, 'no'),
//                                 child: const Text('لا'),
//                               ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               index == 1
//                   ? Text('٢ شهر',
//                       style: TextStyle(color: Colors.grey, fontSize: 16))
//                   : Text('١ شهر',
//                       style: TextStyle(color: Colors.grey, fontSize: 16)),
//               Spacer(),
//
//               Text(model.price.toString(),
//                   style: TextStyle(
//                       color: Colors.orange,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16)),
//               SizedBox(
//                 width: 2,
//               ),
//
//               Icon(
//                 Icons.monetization_on_rounded,
//                 size: 16,
//                 color: Colors.orange,
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               // Text('aaaaaaaaaaaa'),
//             ],
//           ),
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10),
//               border: Border.all(color: Colors.grey.shade400)),
//         )
//       ],
//     );
