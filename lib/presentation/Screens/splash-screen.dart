import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global_defense_insight/core/AppConstant/appContant.dart';
import 'package:global_defense_insight/presentation/Screens/home-Screen.dart';
import 'package:global_defense_insight/presentation/Screens/onboarding.dart';
import 'package:global_defense_insight/presentation/Screens/sign_In.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
     
      Get.off(() => OnboardingScreen());
    });
  }


Future<void> checkFirstTimeAndNavigate() async {
  final prefs = await SharedPreferences.getInstance();
  final isFirstTime = prefs.getBool('isFirstTime') ?? true;

  await Future.delayed(Duration(seconds: 3));

  if (isFirstTime) {
    await prefs.setBool('isFirstTime', false);
    Get.off(() => OnboardingScreen());
  } else {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && user.emailVerified) {
      Get.off(() => HomeScreen());
    } else {
      Get.off(() => SignIn());
    }
  }
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
