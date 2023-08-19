import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) {
              Future.delayed(Duration(seconds: 5), () {
                Navigator.of(context).pop(true);
              });
              return AlertDialog(
                title: const Text('AlertDialog Title'),
                content: const Text('AlertDialog description'),
              );
            }).then((value) {
          showDialog(
            // Second dialog open
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(child: Text('Welcome')),
                    Text('Second Dialog')
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'OK'),
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }),
        child: const Text('Show Dialog'),
      ),
    );
  }

  Widget show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          Future.delayed(Duration(seconds: 5), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
            title: const Text('AlertDialog Title'),
            content: const Text('AlertDialog description'),
          );
        }).then((value) {
      showDialog(
        // Second dialog open
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Center(child: Text('Welcome')), Text('Second Dialog')],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    });
  }
}
