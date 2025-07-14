import 'package:flutter/material.dart';
import 'package:global_defense_insight/common/app_text.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/core/utils/theme/text_theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/controller/onboarding_controller.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static String onboardingImage1 =
      "assets/animations/Earth Globe Looped Icon.json";
  static String onboardingImage2 = "assets/animations/Creative Idea.json";
  static String onboardingImage3 =
      "assets/animations/Man working on a new business idea.json";

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              onBoardingPageWidget(
                width: width,
                height: height,
                onboardingTitle: GonBoardingText.onboardingTitle1,
                onboardingDescription: GonBoardingText.onboardingDescription1,
                onboardingImage1: onboardingImage1,
                onboardingColor: Appcolor.onBoardingColor1,
              ),
              onBoardingPageWidget(
                width: width,
                height: height,
                onboardingTitle: GonBoardingText.onboardingTitle2,
                onboardingDescription: GonBoardingText.onboardingDescription2,
                onboardingImage1: onboardingImage2,
                onboardingColor: Appcolor.onBoardingColor2,
              ),
              onBoardingPageWidget(
                width: width,
                height: height,
                onboardingTitle: GonBoardingText.onboardingTitle3,
                onboardingDescription: GonBoardingText.onboardingDescription3,
                onboardingImage1: onboardingImage3,
                onboardingColor: Appcolor.onBoardingColor3,
              ),
            ],
          ),
          Positioned(
            top: 20,
            right: 8,
            child: TextButton(
                onPressed: () {
                  controller.skipPage();
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600),
                )),
          ),
          Positioned(
              bottom: 40,
              left: 8,
              child: SmoothPageIndicator(
                  controller: controller.pageController,
                  onDotClicked: controller.dotNavigation,
                  count: 3,
                  effect: ExpandingDotsEffect(
                      activeDotColor: Appcolor.blue, dotHeight: 10))),
          Positioned(
              bottom: 25,
              right: 8,
              child: ElevatedButton(
                  onPressed: () {
                    controller.nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(17),
                    backgroundColor: Appcolor.blue,
                    iconColor: Colors.white,
                  ),
                  child: Icon(Iconsax.arrow_right_3)))
        ],
      ),
    );
  }
}

class onBoardingPageWidget extends StatelessWidget {
  const onBoardingPageWidget({
    super.key,
    required this.width,
    required this.height,
    required this.onboardingTitle,
    required this.onboardingDescription,
    required this.onboardingImage1,
    required this.onboardingColor,
  });

  final double width;
  final double height;
  final String onboardingTitle;
  final String onboardingDescription;
  final String onboardingImage1;
  final Color onboardingColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      color: onboardingColor,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: width * 0.8,
            height: height * 0.5,
            child: Lottie.asset(onboardingImage1),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                child: Text(
                  onboardingTitle,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.readexPro(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  onboardingDescription,
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
