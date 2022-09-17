import 'package:carousel_slider/carousel_slider.dart';
import 'package:data/models/banner_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../config/config.dart';
import '../../../../controllers/home_controller.dart';
import '../../../../widgets/widgets.dart';

class BannersSection extends StatefulWidget {
  const BannersSection({super.key});

  @override
  State<BannersSection> createState() => _BannersSectionState();
}

class _BannersSectionState extends State<BannersSection> {
  bool isLoaded = Get.find<HomeController>().isBannerLoaded;

  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().addListener(() {
      if (Get.find<HomeController>().isBannerLoaded != isLoaded) {
        setState(() {
          isLoaded = Get.find<HomeController>().isBannerLoaded;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = Size(context: context);
    return !isLoaded
        ? const Preloader()
        : Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              CarouselSlider(
                items: <Widget>[
                  for (BannerInfo banner in Get.find<HomeController>().banners)
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(size.width(mobile: 20)),
                      child: CustomImage(
                        imagePath: banner.mainMediaUrl,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    )
                ],
                options: CarouselOptions(
                  onPageChanged: (int index, _) {
                    currentPage = index;
                    setState(() {});
                  },
                  aspectRatio: 375 / 127,
                  autoPlay: true,
                  viewportFraction: 1,
                  enableInfiniteScroll:
                      Get.find<HomeController>().banners.length > 1,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: size.width(mobile: 6)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    for (int i = 0;
                        i < Get.find<HomeController>().banners.length;
                        i++)
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: size.width(mobile: 4)),
                        width: size.width(mobile: i == currentPage ? 10 : 6),
                        height: size.width(mobile: i == currentPage ? 10 : 6),
                        decoration: BoxDecoration(
                          color: i == currentPage
                              ? null
                              : Theme.of(context).scaffoldBackgroundColor,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
              )
            ],
          );
  }
}
