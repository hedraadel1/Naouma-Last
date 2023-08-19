import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/models/room_data_model.dart';
import 'package:project/utils/constants.dart';

class HomeListItem extends StatelessWidget {
  final RoomDataModel roomData;

  const HomeListItem({Key key, this.roomData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        // onTap: ()=> Get.to(DetailsScreen(roomData: roomData,), duration: Duration(milliseconds: 1000), transition: Transition.leftToRightWithFade),
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
                    borderRadius:
                        BorderRadius.horizontal(right: Radius.circular(8.0)),
                    child: Image.asset(
                      roomData.image,
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
                            roomData.name,
                            maxLines: 1,
                            style: theme.textTheme.bodyText1
                                .copyWith(color: Colors.black, fontSize: 15),
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
                                style: theme.textTheme.bodyText2
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        _sizedBox(height: 8),
                        Text(
                          roomData.roomDesc,
                          maxLines: 1,
                          style: theme.textTheme.bodyText2.copyWith(
                              color: Colors.grey.shade600, fontSize: 13),
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
                          "1177",
                          maxLines: 1,
                          style: theme.textTheme.bodyText2.copyWith(
                              color: Colors.grey.shade600, fontSize: 13),
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
    );
  }

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
