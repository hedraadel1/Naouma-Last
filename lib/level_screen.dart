import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:project/utils/constants.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({Key key}) : super(key: key);

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  Text text = Text(
    "300",
    style: TextStyle(color: Colors.red),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "المستوي",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Image.asset("assets/icons/loading.gif"),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "فوائد المستوي العالي",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: KstorebuttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.report_gmailerrorred_sharp,
                            color: Colors.white,
                          )),
                      // child: Icon(
                      //   Icons.report_gmailerrorred_sharp,
                      //   color: Colors.orangeAccent,
                      // ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "سوف تحصل علي مكافاة قطع ذهبية في كل مرة يرتفع مستواك",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                          "تساعدك المستويات العالية للحصول علي المزيد من الاهتمام"),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "طرق لرفع المستوي",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: KstorebuttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.report_gmailerrorred_sharp,
                            color: Colors.white,
                          )),
                      // child: Icon(
                      //   Icons.report_gmailerrorred_sharp,
                      //   color: Colors.orangeAccent,
                      // ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "انت لست عضوا في يلا بريميم. مستواك يزداد بالسرعة القياسية",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "(الحد الاقصي لليوم:700 خبرة)",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "البقاء في الغرفة",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 3,
                    width: 350,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("0/"),
                    Text(
                      "300",
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(),
                    Text("خبرة"),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text("/ـ 10 دقائق"),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "تكاليف القطع الذهبية أو الكريستال",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "(هدايا ،البطاقات السحرية،موضوعات الغرفه و غيرها من السلع في المتجر)",
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 3,
                    width: 350,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("0/"),
                    Text(
                      "300",
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(),
                    Text("خبرة"),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text("/ـ 3 قطع ذهبية أو كريستال"),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "إعجاب في الحظات",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 3,
                    width: 350,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("0/"),
                    Text(
                      "50",
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(),
                    Text("خبرة"),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text("/ـ 1 إعجاب "),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "إرسال رسائل الي الاصدقاء ",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.grey.shade300,
                    height: 3,
                    width: 350,
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text("0/"),
                    Text(
                      "50",
                      style: TextStyle(color: Colors.red),
                    ),
                    Spacer(),
                    Text("خبرة"),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(
                      width: 1,
                    ),
                    Text("/ـ 1 رسالة "),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "مكافآت المستوي الحصرية",
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                            color: KstorebuttonColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.report_gmailerrorred_sharp,
                            color: Colors.white,
                          )),
                      // child: Icon(
                      //   Icons.report_gmailerrorred_sharp,
                      //   color: Colors.orangeAccent,
                      // ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "شارة المستوي",
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.only(
                                //   topRight: Radius.circular(10),
                                //   bottomRight: Radius.circular(10),
                                //   bottomLeft: Radius.circular(10),
                                //   topLeft: Radius.circular(10),
                                // ),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.orange,
                                  style: BorderStyle.solid,
                                ),
                                // shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              )),
                        ),
                        Container(
                          child: Text(
                            "LV.20",
                            style: TextStyle(color: Colors.orange),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.only(
                                //   topRight: Radius.circular(10),
                                //   bottomRight: Radius.circular(10),
                                //   bottomLeft: Radius.circular(10),
                                //   topLeft: Radius.circular(10),
                                // ),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.blue,
                                  style: BorderStyle.solid,
                                ),
                                // shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              )),
                        ),
                        Container(
                          child: Text(
                            "LV.30",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.only(
                                //   topRight: Radius.circular(10),
                                //   bottomRight: Radius.circular(10),
                                //   bottomLeft: Radius.circular(10),
                                //   topLeft: Radius.circular(10),
                                // ),
                                border: Border.all(
                                  width: 1,
                                  color: Colors.red,
                                  style: BorderStyle.solid,
                                ),
                                // shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              )),
                        ),
                        Container(
                          child: Text(
                            "LV.40",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Text(
                        "إطار مستوي الملف الشخصي",
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Image.network(
                                  'https://newidea.link/nauma-v2/public/uploads/images/shop/2OOVViO4NXvakRXUgo4ZKpEpJnvOhILMMhgvFkMo.gif'),
                            )),
                        Container(
                          child: Text(
                            "LV.5",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Image.network(
                                  "https://newidea.link/nauma-v2/public/uploads/images/shop/uBF7fvBratrKFQSo5JugEJvvdDbDSUbth5vn15WR.gif"),
                            )),
                        Container(
                          child: Text(
                            "LV.20",
                            style: TextStyle(color: Colors.purple),
                          ),
                        )
                      ],
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                      size: 10,
                    ),
                    Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Image.network(
                                  "https://newidea.link/nauma-v2/public/uploads/images/shop/kc41ILKGdeuafc9cQdKrkkbfETYEEEulCHV5rDtb.gif"),
                            )),
                        Container(
                          child: Text(
                            "LV.50",
                            style: TextStyle(color: KstorebuttonColor),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ],
        ));
  }
}
