import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project/controller/discovery_controller.dart';
import 'package:project/models/country_model.dart';
import 'package:project/models/discovery_martba_model.dart';
import 'package:project/utils/constants.dart';

class DiscoveryTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<DiscoveryController>(
          init: DiscoveryController(),
          builder: (controller) => Container(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "المرتبة",
                        style: theme.textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        "اليوم",
                        style: theme.textTheme.bodyText2
                            .copyWith(color: Colors.black, fontSize: 14),
                      ),
                    ],
                  ),
                  _sizedBox(height: 6),
                  GridView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemCount: controller.martbaList.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        childAspectRatio: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return _martbaListItem(
                          controller.martbaList[index], theme);
                    },
                  ),
                  _sizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "البلدان",
                        style: theme.textTheme.bodyText1.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            "أكثر",
                            style: theme.textTheme.bodyText2
                                .copyWith(color: Colors.black, fontSize: 14),
                          ),
                          _sizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    shrinkWrap: true,
                    itemCount: controller.countriesList.length,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 8,
                        childAspectRatio: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return _countryItemWidget(
                          controller.countriesList[index], theme);
                    },
                  ),
                  _sizedBox(height: 12.0),
                  Text(
                    "العناصر",
                    style: theme.textTheme.bodyText1.copyWith(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  GridView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    shrinkWrap: true,
                    itemCount: 12,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 8,
                        childAspectRatio: 1),
                    itemBuilder: (BuildContext context, int index) {
                      return _imageItem(index);
                    },
                  ),
                ],
              ),
            ),
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

  Widget _martbaListItem(DiscovertMartbaItem _item, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        print("${_item.title}");
        // Get.to(MartbaScreen());
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: _item.backgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Icon(
              _item.firstIcon,
              size: 24,
              color: Colors.white,
            ),
            _sizedBox(width: 5.0),
            Expanded(
                child: Text(
              _item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
            )),
            CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.6),
              child: Icon(
                _item.lastIcon,
                color: Colors.black,
              ),
              radius: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _countryItemWidget(CountryModel _item, ThemeData theme) {
    return GestureDetector(
      onTap: () {
        print(_item.title);
        // Get.to(CountryLivesScreen(title: _item.title,));
      },
      child: Container(
        height: 56,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: kGreyColor.shade100,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Row(
          children: [
            Icon(
              _item.iconData,
              size: 24,
              color: Colors.black,
            ),
            _sizedBox(width: 10.0),
            Expanded(
                child: Text(
              _item.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.bodyText1.copyWith(color: Colors.black),
            )),
          ],
        ),
      ),
    );
  }

  Widget _imageItem(int index) {
    return GestureDetector(
      onTap: () => print("index: $index"),
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            child: Image.asset(
              "assets/images/item_image.png",
              fit: BoxFit.fill,
            )),
      ),
    );
  }
}
