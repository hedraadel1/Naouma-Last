import 'package:flutter/material.dart';
import 'package:project/widgets/custom_raised_button.dart';

class NoInternetConnectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/no-signal.png",
              width: 160,
            ),
            _sizedBox(height: 36),
            Text(
              "No available internet",
              style: theme.textTheme.bodyText1.copyWith(
                  color: Colors.black,
                  fontSize: 19,
                  fontWeight: FontWeight.w700),
            ),
            _sizedBox(height: 6.0),
            Text("check your internet connection and try again later!"),
            _sizedBox(height: 24),
            CustomRaisedButton(
              title: "try again",
              function: () {},
            ),
          ],
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
}
