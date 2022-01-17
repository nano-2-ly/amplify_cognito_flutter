import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


class mainScreenCarouselWidget extends StatelessWidget {
  const mainScreenCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 340.0,

          enlargeCenterPage: true
        ),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                      color: Color(0xFFfefefe)
                  ),
                  child: Image.asset("assets/images/testMarketingImage.png")
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
