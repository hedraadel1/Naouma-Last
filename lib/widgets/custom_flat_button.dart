import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'custom_text.dart';

class CustomFlatButton extends StatelessWidget {
  final String imageName;
  final String title;
  final Function onPressed;

  const CustomFlatButton({Key key, this.imageName, this.title, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 36.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        color: Colors.white,
      onPressed: onPressed,
      child: Row(
        children: [
          Image.asset(imageName),
          SizedBox(
            width: 12.0,
          ),
          Expanded(
            child: CustomText(
              title: title,
              fontSize: 16,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
