import 'package:amazonclone/utils/colors.dart';
import 'package:amazonclone/utils/constants.dart';
import 'package:flutter/material.dart';

class BannerAdWidget extends StatefulWidget {
  const BannerAdWidget({Key? key}) : super(key: key);

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  int currentAd = 0;
  Widget getSmallAdsFromIndex({required int index, required double height}) {
    return Container(
      height: height,
      width: height,
      margin: EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            smallAds[index],
          ),
          Text(
            adItemNames[index],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double smallAdHeight = screenSize.width / 4;
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (currentAd == (largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          //image with gradient
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        backgroundColor,
                        backgroundColor.withAlpha(0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
              color: backgroundColor,
              width: screenSize.width,
              height: smallAdHeight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return getSmallAdsFromIndex(
                      index: index, height: smallAdHeight);
                },
                itemCount: smallAds.length,
              )),
        ],
      ),
    );
  }
}
