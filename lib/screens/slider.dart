import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:templering/constants/AppConstant.dart';
import '../../../../utils/color.dart';
import 'slider_controller.dart';

class SliderWidget extends StatelessWidget {
  final SliderController sliderController = Get.put(SliderController());

  SliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (sliderController.imageList.isEmpty) {
        return Center(child: CircularProgressIndicator());
      }

      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.26,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.26,
              child: CarouselSlider.builder(
                itemCount: sliderController.imageList.length,
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.19,
                  enableInfiniteScroll: true,
                  viewportFraction: 1,
                  autoPlay: true,
                  onPageChanged: (index, reason) {
                    sliderController.currentindex.value = index;
                  },
                ),
                carouselController: sliderController.carouselController,
                itemBuilder: (BuildContext context, int index, int realIndex) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.26,
                    decoration: BoxDecoration(
                      color: adoptifyPrimaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Image.network(
                          "$BaseUrl/images/adoptify/icons/background.png",
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  LimitedBox(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.45,
                                    child: Text(
                                      sliderController.imageList[index].title,
                                      style: primaryTextStyle(
                                        color: Colors.white,
                                        size: 20,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  LimitedBox(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.45,
                                    child: Text(
                                      sliderController
                                          .imageList[index].description,
                                      style: secondaryTextStyle(
                                        color: Colors.white,
                                        size: 14,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ).fit(),
                              Image.network(
                                sliderController.imageList[index].image,
                                height: 180,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).paddingAll(MediaQuery.of(context).size.height * 0.002);
                },
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.23,
              bottom: MediaQuery.of(context).size.height * 0.02,
              right: MediaQuery.of(context).size.width * 0.4,
              left: MediaQuery.of(context).size.width * 0.4,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: sliderController.imageList
                      .asMap()
                      .entries
                      .map(
                        (entry) => GestureDetector(
                          onTap: () => sliderController.carouselController
                              .animateToPage(entry.key),
                          child: Container(
                            width:
                                sliderController.currentindex.value == entry.key
                                    ? 17
                                    : 7,
                            height: 7.0,
                            margin: const EdgeInsets.symmetric(horizontal: 3.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: white,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ).paddingSymmetric(
        vertical: MediaQuery.of(context).size.height * 0.01,
        horizontal: MediaQuery.of(context).size.width * 0.04,
      );
    });
  }
}
