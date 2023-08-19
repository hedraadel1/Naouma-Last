import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeSlide extends StatelessWidget {
  List<String> images = [
    "assets/images/slide_img_1.png",
    "assets/images/slide_img_1.png"
  ];
  @override
  Widget build(BuildContext context) {
    SwiperController _controller = SwiperController();
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 54),
      child: Stack(
        children: [
          // align slider images at top
          Swiper(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
                child: Image.asset(
                  images[index],
                  fit: BoxFit.fill,
                ),
              );
            },
            itemCount: images.length,
            autoplay: true,
            containerWidth: size.width,
            containerHeight: size.height,
            duration: 1800,
            scrollDirection: Axis.horizontal,
            controller: _controller,
            pagination: SwiperPagination(),
          ),
        ],
      ),
    );
  }
}
