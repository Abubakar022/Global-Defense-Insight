import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/presentation/Screens/onboarding.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      print("hello");
      Get.off(() => OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return Scaffold(
      backgroundColor: Appcolor.SplashScreenColor,
      appBar: AppBar(
        backgroundColor: Appcolor.SplashScreenColor,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: height * 0.1),
            Expanded(
              child: SizedBox(
                child: Text(
                  "Global Defense \n Insight ",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.permanentMarker(
                      fontSize: width * 0.12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Container(
              child: Lottie.asset("assets/animations/Rocket.json"),
            )
          ],
        ),
      ),
    );
  }
}
