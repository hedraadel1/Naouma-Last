import 'package:flutter/material.dart';

class FullScreenImage extends StatelessWidget {
  const FullScreenImage({Key key, this.imageUrl, this.tag}) : super(key: key);
  final String imageUrl;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: tag,
            child: FadeInImage.memoryNetwork(
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
              image: imageUrl,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
