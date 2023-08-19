// import 'package:hive/hive.dart';

// part 'User.g.dart';

// @HiveType(typeId: 0)
// class User {
//   @HiveField(0)
//   final String name;

//   @HiveField(1)
//   final String phoneNumber;

//   final String? firebaseToken;

//   User(this.name, this.phoneNumber, {this.firebaseToken});

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is User &&
//           runtimeType == other.runtimeType &&
//           name == other.name &&
//           phoneNumber == other.phoneNumber;

//   @override
//   int get hashCode => name.hashCode ^ phoneNumber.hashCode;
// }

import 'package:firebase_auth/firebase_auth.dart' as Auth;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:project/utils/constants.dart';
import 'package:project/view/login/Timer.dart';

class SMSCodeDialog extends StatefulWidget {
  final String phoneNumber;
  final Function(String smsCode, BuildContext dialogContext) onSMSCodeEntered;
  final int resendToken;

  const SMSCodeDialog(
      {Key key, this.onSMSCodeEntered, this.phoneNumber, this.resendToken})
      : super(key: key);

  @override
  _SMSCodeDialogState createState() => _SMSCodeDialogState();
}

class _SMSCodeDialogState extends State<SMSCodeDialog> {
  TextEditingController smsCodeController = TextEditingController();
  bool showResend = false;
  final TimerController _timerController =
      TimerController(duration: Duration(seconds: 120));

  void _resendVerificationCode() {
    Auth.FirebaseAuth.instance.verifyPhoneNumber(
      forceResendingToken: widget.resendToken,
      phoneNumber: widget.phoneNumber,
      timeout: Duration(seconds: 120),
      verificationCompleted: (Auth.PhoneAuthCredential credential) {},
      verificationFailed: (Auth.FirebaseAuthException e) {
        print("failed");
      },
      codeSent: (String verificationId, int resendToken) async {
        setState(() {
          showResend = false;
        });
        _timerController.restart();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print("timeout");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Center(
            child: TimerWidget(
              controller: _timerController,
              onFinish: () {
                setState(() {
                  showResend = true;
                });
              },
            ),
          ),
          Center(
              child: TextField(
            textAlign: TextAlign.center,
            controller: smsCodeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            style:
                TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
          )),
        ],
      ),
      content: Container(
        height: 100,
        // + (showResend ? 20 : 0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  widget.onSMSCodeEntered(smsCodeController.text, context);
                  otp = true;
                },
                child: Text("Send")),
            Visibility(
              visible: showResend,
              child: TextButton(
                  onPressed: _resendVerificationCode,
                  child: Text("Resend Code")),
            ),
          ],
        ),
      ),
    );
  }
}
