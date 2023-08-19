import 'package:flutter/material.dart';
import '../utils/constants.dart';

import 'custom_text.dart';

class CustomRaisedButton extends StatelessWidget {
  final String title;
  final Function function;

  const CustomRaisedButton({Key key, this.title, this.function}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        color: kPrimaryColor,
        onPressed: function,
        child: Text(title, style: theme.textTheme.button, textAlign: TextAlign.center,),
      ),
    );
  }
}
