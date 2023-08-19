import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:nb_utils/nb_utils.dart';

class ChatMessageItem extends StatelessWidget {
  const ChatMessageItem({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      child: Row(
        children: [
          CircleAvatar(),
          10.width,
          Expanded(child: Text(
            "chat message content", style: theme.textTheme.bodyText1.copyWith(color: Colors.white),
          ),),
        ],
      ),
    );
  }
}
