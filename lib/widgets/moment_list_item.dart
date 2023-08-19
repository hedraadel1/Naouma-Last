import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/utils/constants.dart';

class MomentListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        child: Image.asset("assets/images/Profile Image.png"),
                      ),
                    ),
                    _sizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "title",
                            style: theme.textTheme.bodyText1,
                            maxLines: 1,
                          ),
                          Text(
                            "body1",
                            style: theme.textTheme.bodyText2,
                            maxLines: 2,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.access_alarms_rounded,
                                color: Colors.blue,
                                size: 18,
                              ),
                              _sizedBox(width: 4.0),
                              Icon(
                                Icons.update,
                                color: Colors.blue,
                                size: 18,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => print("follow btn clicked"),
                          child: Container(
                            // height: 30,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              border: Border.all(color: kPrimaryColor),
                            ),
                            child: Text(
                              "متابعة",
                              style: theme.textTheme.bodyText2
                                  .copyWith(color: kPrimaryColor, fontSize: 15),
                            ),
                          ),
                        ),
                        // _sizedBox(width: 2.0),
                        IconButton(
                            icon: Icon(
                              Icons.more_horiz,
                              size: 18,
                            ),
                            onPressed: () {
                              // showDialog(context: context,
                              //     builder: (BuildContext context){
                              //       return CallCenterBtnDialog();
                              //     }
                              // );
                            }),
                      ],
                    ),
                  ],
                ),
              ),
              _sizedBox(height: 6.0),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home, color: Colors.blue, size: 18),
                    _sizedBox(width: 2.0),
                    Text(
                      "القهوة وضحكتك",
                      style: theme.textTheme.bodyText2.copyWith(fontSize: 13),
                    ),
                    _sizedBox(width: 2.0),
                    Icon(
                      Icons.arrow_back_ios_sharp,
                      color: Colors.blue,
                      size: 16,
                    ),
                  ],
                ),
              ),
              _sizedBox(height: 6.0),
              Text(
                "القهوة ملاذ دائما وابدا ##",
                style: theme.textTheme.bodyText1.copyWith(color: Colors.black),
              ),
              _sizedBox(height: 8.0),
              Container(
                width: 140,
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  child: Image.asset(
                    "assets/images/item_image.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              _sizedBox(height: 8.0),
              Container(
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(color: Colors.grey.shade50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        icon: Icon(Icons.ios_share),
                        onPressed: () {
                          // showDialog(context: context,
                          //     builder: (BuildContext context){
                          //       return ShareMomentPostDialog();
                          //     }
                          // );
                        }),
                    Row(
                      children: [
                        IconButton(icon: Icon(Icons.share), onPressed: () {}),
                        Text(
                          "125",
                          style: theme.textTheme.bodyText2
                              .copyWith(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.star_border), onPressed: () {}),
                        Text(
                          "125",
                          style: theme.textTheme.bodyText2
                              .copyWith(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.card_giftcard), onPressed: () {}),
                        Text(
                          "125",
                          style: theme.textTheme.bodyText2
                              .copyWith(color: Colors.grey, fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              _sizedBox(height: 8.0),
              Text(
                "شعور أحمد",
                style: theme.textTheme.bodyText1.copyWith(color: Colors.black),
              ),
              _sizedBox(height: 6.0),
              Text(
                "القهوة تجلب غيمات من السعادةوالبهجة",
                style: theme.textTheme.bodyText2.copyWith(color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
