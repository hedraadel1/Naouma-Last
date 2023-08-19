import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/home/homeCubit.dart';
import 'package:project/view/home/states.dart';

import 'network/cache_helper.dart';

class MahamScreen extends StatefulWidget {
  const MahamScreen({Key key}) : super(key: key);

  @override
  State<MahamScreen> createState() => _MahamScreenState();
}

class _MahamScreenState extends State<MahamScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "المهمات",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(children: [
          Column(
            children: [
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 75,
              //         width: 370,
              //         color: KstorebuttonColor,
              //         child: Center(
              //             child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.end,
              //             children: [
              //               Icon(
              //                 Icons.login,
              //                 size: 40,
              //                 color: Colors.blue,
              //               ),
              //               SizedBox(
              //                 width: 80,
              //               ),
              //               Text(
              //                 "تسجيل دخول",
              //                 style: TextStyle(fontSize: 20),
              //               ),
              //               SizedBox(
              //                 width: 70,
              //               ),
              //             ],
              //           ),
              //         )),
              //       )
              //     ],
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "المهمات اليوميه",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 50,
                        width: 30,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                        )),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {
                              HomeCubit.get(context).addExperience(exp: 100);
                            },
                            icon: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+100",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ],
                      )
                    ],
                  ),
                  // Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: TextFormField(),
                  // )
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 50,
                        width: 30,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.mic_rounded,
                          color: Colors.white,
                        )),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "أخذ المايك لمدة 10 دقائق",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+10",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            width: 80,
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          border: Border.all(
                            width: 1,
                            color: kPrimaryColor,
                            style: BorderStyle.solid,
                          ),
                          // shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          "التالي",
                          style: TextStyle(color: kPrimaryColor, fontSize: 12),
                        ))),
                  )
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     SizedBox(
              //       width: 15,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           decoration: BoxDecoration(
              //             color: kPrimaryColor,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.mic_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              // Column(
              //   children: [
              //     Container(
              //       child: Text(
              //         "أخذ المايك لمدة 10 دقائق",
              //         style: TextStyle(fontWeight: FontWeight.w500),
              //       ),
              //     ),
              //     Text("aaa")
              //   ],
              // ),
              // Icon(
              //   Icons.mic_rounded,
              //   color: Colors.white,
              // )
              //  ],
              //  )
              Divider(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                        height: 50,
                        width: 30,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.card_giftcard_outlined,
                          color: Colors.white,
                        )),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "إرسال هدية",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 80,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+6",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            width: 90,
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          border: Border.all(
                            width: 1,
                            color: kPrimaryColor,
                            style: BorderStyle.solid,
                          ),
                          // shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          "التالي",
                          style: TextStyle(color: kPrimaryColor, fontSize: 12),
                        ))),
                  )
                ],
              ),
              Divider(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(children: [
                      Container(
                          height: 50,
                          width: 30,
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.share_rounded,
                            color: Colors.white,
                          )),
                      SizedBox(
                        height: 20,
                      )
                    ]),
                  ),
                  Column(
                    children: [
                      Container(
                        child: Text(
                          "مشاركة الغرف علي شبكات",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: Text(
                              "التواصل الاجتماعي",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: 35,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.monetization_on_rounded,
                            size: 14,
                            color: Colors.blue,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            "+1",
                            style: TextStyle(color: Colors.blue),
                          ),
                          SizedBox(
                            width: 75,
                          )
                        ],
                      )
                    ],
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          border: Border.all(
                            width: 1,
                            color: kPrimaryColor,
                            style: BorderStyle.solid,
                          ),
                          // shape: BoxShape.circle,
                        ),
                        child: Center(
                            child: Text(
                          "التالي",
                          style: TextStyle(color: kPrimaryColor, fontSize: 12),
                        ))),
                  )
                ],
              ),
              // Divider(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       SizedBox(
              //         width: 5,
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.all(10.0),
              //         child: Text(
              //           "مهام التطوير",
              //           style: TextStyle(
              //               fontWeight: FontWeight.bold, fontSize: 18),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.home_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Container(
              //           child: Text(
              //             "تطوير الغرفة الخاصة بك",
              //             style: TextStyle(fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+20",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 90,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.person,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Container(
              //           child: Text(
              //             "تحديث المعلومات الشخصية",
              //             style: TextStyle(fontWeight: FontWeight.w500),
              //           ),
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+3",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 95,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.phone,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "أضف رقم هاتف إلي حسابك",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+5",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 100,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             color: kPrimaryColor,
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "استلام",
              //             style:
              //                 TextStyle(color: Colors.white, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.favorite_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "أحصل علي 10 إعجابات في اللحظات",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             )
              //           ],
              //         ),
              //         Row(
              //           children: [
              //             Text(
              //               "(0/10)",
              //               style:
              //                   TextStyle(fontSize: 12, color: Colors.grey),
              //             ),
              //             SizedBox(
              //               width: 145,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+5",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 145,
              //             )
              //           ],
              //         ),
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.follow_the_signs_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/3)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "قم بمتابعة 3 مواضيع",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+3",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 120,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.card_giftcard_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/10)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "أرسل 10 هدايا للمنشورات",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 20,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+20",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 125,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.person_add,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/10)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "إضافه 10 أصدقاء",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 40,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+5",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 125,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.timer,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "البقاء في الغرفة لمدة 15 دقيقة",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 40,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+10",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 165,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             color: kPrimaryColor,
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "استلام",
              //             style:
              //                 TextStyle(color: Colors.white, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.home_work,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/3)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "انضم الي 3 غرف",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 100,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+5",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 165,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.person,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/10)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "لديك 10 أعضاء في الغرفه",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 100,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+10",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 225,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.card_giftcard,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/10)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "ارسال 10 هدايا",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 160,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+20",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 225,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.monetization_on_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "إرسال حقيبة الحظ",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 180,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+10",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 225,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.games,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/3)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "العب حجرة ورقه مقص 3 مرات",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 100,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+10",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 225,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.games,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "(0/3)",
              //                 style: TextStyle(
              //                     fontSize: 12, color: Colors.grey),
              //               ),
              //             ),
              //             Container(
              //               child: Text(
              //                 "العب عجله الحظ 3 مرات",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 125,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+10",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 225,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Divider(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.all(5.0),
              //       child: Container(
              //           height: 50,
              //           width: 30,
              //           decoration: BoxDecoration(
              //             color: Colors.blueAccent,
              //             shape: BoxShape.circle,
              //           ),
              //           child: Icon(
              //             Icons.monetization_on_rounded,
              //             color: Colors.white,
              //           )),
              //     ),
              //     SizedBox(
              //       width: 5,
              //     ),
              //     Column(
              //       children: [
              //         Row(
              //           children: [
              //             Container(
              //               child: Text(
              //                 "الشحن لأول مرة",
              //                 style: TextStyle(fontWeight: FontWeight.w500),
              //               ),
              //             ),
              //             SizedBox(
              //               width: 190,
              //             )
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           children: [
              //             Icon(
              //               Icons.monetization_on_rounded,
              //               size: 14,
              //               color: Colors.blue,
              //             ),
              //             SizedBox(
              //               width: 5,
              //             ),
              //             Text(
              //               "+100",
              //               style: TextStyle(color: Colors.blue),
              //             ),
              //             SizedBox(
              //               width: 220,
              //             )
              //           ],
              //         )
              //       ],
              //     ),
              //     Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: Container(
              //           width: 50,
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.only(
              //               topRight: Radius.circular(10),
              //               bottomRight: Radius.circular(10),
              //               bottomLeft: Radius.circular(10),
              //               topLeft: Radius.circular(10),
              //             ),
              //             border: Border.all(
              //               width: 1,
              //               color: kPrimaryColor,
              //               style: BorderStyle.solid,
              //             ),
              //             // shape: BoxShape.circle,
              //           ),
              //           child: Center(
              //               child: Text(
              //             "التالي",
              //             style:
              //                 TextStyle(color: kPrimaryColor, fontSize: 12),
              //           ))),
              //     )
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       Container(
              //         height: 75,
              //         width: 370,
              //         child: Center(
              //             child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Row(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Icon(
              //                 Icons.monetization_on_rounded,
              //                 color: Colors.blue,
              //                 size: 16,
              //               ),
              //               SizedBox(
              //                 width: 5,
              //               ),
              //               Text(
              //                 "متجر الكريستال",
              //                 style: TextStyle(
              //                     fontSize: 15, color: Colors.blue),
              //               ),
              //               SizedBox(
              //                 width: 5,
              //               ),
              //               Icon(
              //                 Icons.arrow_forward_ios_rounded,
              //                 size: 16,
              //                 color: Colors.blue,
              //               )
              //             ],
              //           ),
              //         )),
              //       )
              //     ],
              //   ),
              // ),
            ],
          ),
        ]),
      );
    }, listener: (context, state) {
      if (state is AddExpSuccessStates) {
        CacheHelper.saveData(
                key: 'level', value: state.addExpModel.currentLevel)
            .then((value) {
          level = state.addExpModel.currentLevel.toString();

          // print(username);
          // Get.to(HomeScreen());
        });
        CacheHelper.saveData(key: 'expNum', value: state.addExpModel.currentExp)
            .then((value) {
          expNum = state.addExpModel.currentExp.toString();
        });
      }
    });
  }
}
