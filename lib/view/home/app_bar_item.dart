import 'package:flutter/material.dart';

class AppBarItem extends StatelessWidget {
  final String title;
  final Color textColor;

  const AppBarItem({Key key, this.title, this.textColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(title, style: TextStyle(color: textColor),),
    );
  }
}
