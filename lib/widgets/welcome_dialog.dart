import 'package:flutter/material.dart';

import 'custom_raised_button.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          width: size.width * 0.8,
          padding: const EdgeInsets.only(left: 16, top: 60, right: 16, bottom: 16),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 2,
                  offset: Offset(0, -2),
                )
              ]
          ),
          child: Column(
            children: [
              Text("مرحبا بك في يلا", style: theme.textTheme.bodyText1.copyWith(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),),
              Text("اهلا بك في يلا ٫ تم اضافة هةايا مجانية لاشتراكك بالتطبيق.", style: theme.textTheme.bodyText2.copyWith(color: Colors.black, fontSize: 16),),
              CustomRaisedButton(
                title: "اذهب واستمتع",
                function: (){Navigator.of(context).pop();},
              )
            ],
          ),
        ),
        Positioned(
          top: 16,
          left: 16,
          child: GestureDetector(
          onTap: (){
            print("close clicked...");
          },
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: Icon(Icons.close, color: Colors.black,),
          ),
        ),),
        Positioned(
          top: -30,
          left: 0,
          right: 0,
          child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
              ),
              child: Image.asset("assets/images/Profile Image.png"),
            ),
          ),
      ],
    );
  }
}
