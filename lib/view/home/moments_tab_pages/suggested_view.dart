import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/friendRequests.dart';
import 'package:project/widgets/moment_list_item.dart';

import '../../../utils/constants.dart';

class SuggestedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: ListView(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Icon(
                                //   Icons.arrow_back_ios,
                                //   size: 16,
                                // ),
                                // Spacer(),
                                Text(
                                  "فريق يلا",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.headphones,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Icon(
                                //   Icons.arrow_back_ios,
                                //   size: 16,
                                // ),
                                // Spacer(),
                                Text(
                                  "الانشطة",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.flag_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Icon(
                                //   Icons.arrow_back_ios,
                                //   size: 16,
                                // ),
                                // Spacer(),
                                Text(
                                  "النظام",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.flag_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: InkWell(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Icon(
                                  //   Icons.arrow_back_ios,
                                  //   size: 16,
                                  // ),
                                  // Spacer(),
                                  Text(
                                    "طلبات الصداقة",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),

                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.people,
                                        size: 18,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                Get.to(FriendRequestsScreen());
                              },
                            ),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                // Icon(
                                //   Icons.arrow_back_ios,
                                //   size: 16,
                                // ),
                                // Spacer(),
                                Text(
                                  "إشعار اللحظات",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryLightColor,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.timer,
                                      size: 18,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )),
            // Expanded(
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.stretch,
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           color: Colors.purple,
            //         ),
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.black,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ));
  }
}
