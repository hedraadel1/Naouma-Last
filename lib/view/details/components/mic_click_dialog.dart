import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:project/utils/constants.dart';

class MicClickDialog extends StatelessWidget {
  const MicClickDialog(
      {Key key,
      this.takeMicFunction,
      this.leaveMicFunction,
      this.lockMicFunction,
      this.unLockMicFunction,
      this.showTakeMic = true,
      this.showLeaveMic = true,
      this.micIsLocked = false,
      this.showLockMic = false})
      : super(key: key);
  final Function takeMicFunction;
  final Function leaveMicFunction;
  final Function lockMicFunction;
  final Function unLockMicFunction;
  final bool showTakeMic;
  final bool showLeaveMic;
  final bool showLockMic;
  final bool micIsLocked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: contentBox(context, theme),
      ),
    );
  }

  contentBox(context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          showTakeMic
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("آخذ المايك",
                      style: theme.textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
                ).onTap(() => takeMicFunction())
              : Container(),
          showTakeMic
              ? Divider(
                  color: Colors.black,
                  height: 1,
                )
              : Container(),
          showLeaveMic
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("ترك المايك",
                      style: theme.textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
                ).onTap(() => leaveMicFunction())
              : Container(),
          showLockMic
              ? Divider(
                  color: Colors.black,
                  height: 1,
                )
              : Container(),
          showLockMic
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("قفل المايك",
                      style: theme.textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
                ).onTap(() => lockMicFunction())
              : Container(),
          micIsLocked
              ? Divider(
                  color: Colors.black,
                  height: 1,
                )
              : Container(),
          micIsLocked
              ? Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("فتح المايك",
                      style: theme.textTheme.bodyText1
                          .copyWith(fontWeight: FontWeight.w700, fontSize: 17)),
                ).onTap(() => unLockMicFunction())
              : Container(),
        ],
      ),
    );
  }
}
