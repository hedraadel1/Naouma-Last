import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:project/utils/constants.dart';

class SuggestedListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ListTile(
            isThreeLine: true,
            leading: Image.asset(
              "assets/images/item_image.png",
              width: 75,
              height: 75,
            ),
            title: Text(
              'مقولات و حكم',
              style: theme.textTheme.bodyText1,
            ),
            subtitle: Column(
              children: [
                Row(
                  children: [
                    _buildBodyIconWithText("", "144"),
                    _buildBodyIconWithText("", "112"),
                    _buildBodyIconWithText("", "57"),
                  ],
                ),
                Text(""),
              ],
            ),
            trailing: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
                border: Border.all(color: kPrimaryColor),
              ),
              child: Text(
                "متابعة",
                style: theme.textTheme.bodyText2.copyWith(color: kPrimaryColor),
              ),
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
              width: MediaQuery.of(context).size.width - 100.0,
              child: Divider(
                color: Colors.grey,
                thickness: 1.5,
              )),
        ],
      ),
    );
  }

  Widget _buildBodyIconWithText(String icon, String text) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Icon(
            Icons.perm_identity,
            color: Colors.white,
            size: 16,
          ),
        ),
        _sizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _sizedBox({double width, double height}) {
    return SizedBox(
      width: width,
      height: height,
    );
  }
}
