import 'package:amplify_cognito_flutter/controller/mainScreenCarouselController.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';


class mainScreenCarouselWidget extends StatelessWidget {
  const mainScreenCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mainScreenCarouselController = Get.put(mainScreenCarouselController());
    final CarouselController _controller = CarouselController();
    var imgList = ["assets/images/testMarketingImage.png","assets/images/testMarketingImage.png","assets/images/testMarketingImage.png","assets/images/testMarketingImage.png","assets/images/testMarketingImage.png"];
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            carouselController: _controller,
            options: CarouselOptions(
              height: 340.0,
                autoPlay: false,
              enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  _mainScreenCarouselController.currentIndex.value = index;
                },
            ),
            items: imgList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFfefefe)
                      ),
                      child: Image.asset(i)
                  );
                },
              );
            }).toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                child: Obx(()=>Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black)
                          .withOpacity(_mainScreenCarouselController.currentIndex.value == entry.key ? 0.9 : 0.4)),
                )),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
