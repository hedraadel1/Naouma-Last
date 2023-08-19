import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final Alignment alignment;
  final int maxLines;
  Color bgColor;
  double radius;

  CustomText(
      {this.title,
      this.color = Colors.black,
      this.fontSize = 15,
      this.alignment = Alignment.topLeft,
      this.maxLines,
      this.bgColor = Colors.transparent,
      this.radius = 0});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      alignment: alignment,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(radius)),
      // child: Text(title, style: theme.textTheme.body1.copyWith(fontSize: fontSize, color: color), maxLines: maxLines),
    );
  }
}
